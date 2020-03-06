//
//  initInstanceIsa.m
//  objc-debug
//
//  Created by Alan on 3/6/20.
//

#import "initInstanceIsa.h"
#import "XZPerson.h"

@implementation initInstanceIsa
- (void)demo{
    
            XZPerson *p = [XZPerson alloc];
         
    //        isa -->8字节-->64位-->其中表示
            /*
            nonpointer :1
        表示是否对isa指针开启指针优化；0代表纯isa指针，1代表不止是类对象指针，还包含了类信息、对象的引用计数等；
            has_cxx_dtor:1
        该对象是否有C++或者Objc的析构器，如果有析构函数，则需要做析构逻辑，如果没有，则可以更快的释放对象；
            hasCxxDtor:1
             该对象是否有C++或者Objc的析构器，如果有析构函数，则需要做析构逻辑，如果没有，则可以更快的释放对象；
            shiftcls:33  ,这里是类信息右移三位
            存储类指针的值。开启指针优化的情况下，在arm64架构中有33位用来存储类指针；
            magic:6
             用于调试器判断当前对象是真的对象还是没有初始化的空间；
             weakly_referenced :1
            标志对象是否被指向或者曾经指向一个ARC的弱变量，没有弱引用的对象可以更快释放；
             deallocating :1
            标志对象是否正在释放内存；
             has_sidetable_rc :1   ，数据的引用计数
            当对象引用计数大于10时，则需要借用该变量存储进位
             extra_rc :19
            当表示该对象的引用计数值，实际上是引用计数值减1，例如，如果对象的引用计数为10，那么extra_rc为9.如果引用计数大于10，则需要使用上面提到的has_sidetable_rc。
             */
            NSLog(@"%@",p);
}
@end
