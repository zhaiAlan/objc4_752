//
//  isaAnalyze.m
//  objc-debug
//
//  Created by Alan on 3/9/20.
//

#import "isaAnalyze.h"

@implementation isaAnalyze
- (void)demo{
    //        在内存里面-属性的位置是会发生变化的，之前文章中有提到过，系统内存优化
    //        对象第一个属性必然是isa
    //        isa  <-->cls  isa和类是相互关联的
    //        p/t 0x001d800100002659
            
    //        p/t  二进制打印
    //        p/o 八进制打印
    //        p/d 十进制打印
    //        p/x XZPerson.class   $5 = 0x0000000100002658 XZPerson
    //        p/t (uintptr_t)XZPerson.class
            
    // person 0b0000000000000000000000000000000100000000000000000010011001011000
    // isa    0b0000000000000000000000000000000100000000000000000010011001011000
         //    模拟器：define ISA_MASK        0x00007ffffffffff8ULL
         //    真机：  define ISA_MASK        0x0000000ffffffff8ULL

    /**
     对象可以创建多个，类只能创建一个
     类内存中第一个位置：0x100002678  -->也是一个XZPerson (元类)
     对象--根据类实例化出来 ---开发人员创建
     类--内存中只有一份，系统创建出来 ---编译器创建
     元类--系统编译时发现有类，-系统创建出来  编译器创建
     
     对象(isa) -> 类 (isa)-->元类(isa ) -->根源类 (isa) - 根源类
      获取类方法：object_getClass
     
     **/
    //        XZPerson *p1 = [XZPerson alloc];
    //        object_getClass(p);
            XZTearcher *t1 = [XZTearcher alloc];

         

}
@end
