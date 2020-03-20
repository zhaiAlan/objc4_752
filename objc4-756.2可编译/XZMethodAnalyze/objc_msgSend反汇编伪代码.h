//
//  objc_msgSend反汇编伪代码.h
//  AlanTest
//
//  Created by 翟兴智 on 2019/11/13.
//

//下面的结构体中只列出objc_msgSend函数内部访问用到的那些数据结构和成员。

/*
其实SEL类型就是一个字符串指针类型，所描述的就是方法字符串指针
*/
typedef char * SEL;

/*
IMP类型就是所有OC方法的函数原型类型。
*/
typedef id (*IMP)(id self, SEL _cmd, ...);


/*
  方法名和方法实现桶结构体
*/
struct bucket_t  {
    SEL  key;       //方法名称
    IMP imp;       //方法的实现，imp是一个函数指针类型
};

/*
   用于加快方法执行的缓存结构体。这个结构体其实就是一个基于开地址冲突解决法的哈希桶。
*/
struct cache_t {
    struct bucket_t *buckets;    //缓存方法的哈希桶数组指针，桶的数量 = mask + 1
    int  mask;        //桶的数量 - 1
    int  occupied;   //桶中已经缓存的方法数量。
};

/*
    OC对象的类结构体描述表示，所有OC对象的第一个参数保存是的一个isa指针。
*/
struct objc_object {
  void *isa;
};

/*
   OC类信息结构体，这里只展示出了必要的数据成员。
*/
struct objc_class : objc_object {
    struct objc_class * superclass;   //基类信息结构体。
    cache_t cache;    //方法缓存哈希表
    //... 其他数据成员忽略。
};



/*
objc_msgSend的C语言版本伪代码实现.
receiver: 是调用方法的对象
op: 是要调用的方法名称字符串
*/
id  objc_msgSend(id receiver, SEL op, ...)
{

    //1............................ 对象空值判断。
    //如果传入的对象是nil则直接返回nil
    if (receiver == nil)
        return nil;
    
   //2............................ 获取或者构造对象的isa数据。
    void *isa = NULL;
    //如果对象的地址最高位为0则表明是普通的OC对象，否则就是Tagged Pointer类型的对象
    if ((receiver & 0x8000000000000000) == 0) {
        struct objc_object  *ocobj = (struct objc_object*) receiver;
        isa = ocobj->isa;
    }
    else { //Tagged Pointer类型的对象中没有直接保存isa数据，所以需要特殊处理来查找对应的isa数据。
        
        //如果对象地址的最高4位为0xF, 那么表示是一个用户自定义扩展的Tagged Pointer类型对象
        if (((NSUInteger) receiver) >= 0xf000000000000000) {
            
            //自定义扩展的Tagged Pointer类型对象中的52-59位保存的是一个全局扩展Tagged Pointer类数组的索引值。
            int  classidx = (receiver & 0xFF0000000000000) >> 52
            isa =  objc_debug_taggedpointer_ext_classes[classidx];
        }
        else {
            
            //系统自带的Tagged Pointer类型对象中的60-63位保存的是一个全局Tagged Pointer类数组的索引值。
            int classidx = ((NSUInteger) receiver) >> 60;
            isa  =  objc_debug_taggedpointer_classes[classidx];
        }
    }
    
   //因为内存地址对齐的原因和虚拟内存空间的约束原因，
   //以及isa定义的原因需要将isa与上0xffffffff8才能得到对象所属的Class对象。
    struct objc_class  *cls = (struct objc_class *)(isa & 0xffffffff8);
    
   //3............................ 遍历缓存哈希桶并查找缓存中的方法实现。
    IMP  imp = NULL;
    //cmd与cache中的mask进行与计算得到哈希桶中的索引，来查找方法是否已经放入缓存cache哈希桶中。
    int index =  cls->cache.mask & op;
    while (true) {
        
        //如果缓存哈希桶中命中了对应的方法实现，则保存到imp中并退出循环。
        if (cls->cache.buckets[index].key == op) {
              imp = cls->cache.buckets[index].imp;
              break;
        }
        
        //方法实现并没有被缓存，并且对应的桶的数据是空的就退出循环
        if (cls->cache.buckets[index].key == NULL) {
             break;
        }
        
        //如果哈希桶中对应的项已经被占用但是又不是要执行的方法，则通过开地址法来继续寻找缓存该方法的桶。
        if (index == 0) {
            index = cls->cache.mask;  //从尾部寻找
        }
        else {
            index--;   //索引减1继续寻找。
        }
    } /*end while*/

   //4............................ 执行方法实现或方法未命中缓存处理函数
    if (imp != NULL)
         return imp(receiver, op,  ...); //这里的... 是指传递给objc_msgSend的OC方法中的参数。
    else
         return objc_msgSend_uncached(receiver, op, cls, ...);
}

/*
  方法未命中缓存处理函数：objc_msgSend_uncached的C语言版本伪代码实现，这个函数也是用汇编语言编写。
*/
id objc_msgSend_uncached(id receiver, SEL op, struct objc_class *cls)
{
   //这个函数很简单就是直接调用了_class_lookupMethodAndLoadCache3 来查找方法并缓存到struct objc_class中的cache中，最后再返回IMP类型。
  IMP  imp =   _class_lookupMethodAndLoadCache3(receiver, op, cls);
  return imp(receiver, op, ....);
}
