//
//  MemoryAlignment.m
//  objc-debug
//
//  Created by Alan on 3/6/20.
//

#import "MemoryAlignment.h"
#import "XZPerson.h"
#import "XZTearcher.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>
//24字节
struct XZStruct1 {
    char a;     // 1 + 7
    double b;   // 8
    int c;      // 4
    short d;    // 2 + 2
} MyStruct1;
//16字节
struct XZStruct2 {
    double b;   // 8
    char a;     // 1
    short d;    // 2
    int c;      // 4

} MyStruct2;


@implementation MemoryAlignment
-(void)demo{
       NSLog(@"\nMyStruct1 ==%lu\nMyStruct2==%lu",sizeof(MyStruct1),sizeof(MyStruct2));

                    /**
            １:数据成员对⻬规则：结构(struct)(或联合(union))的数据成员，第
            ⼀个数据成员放在offset为0的地⽅，以后每个数据成员存储的起始位置要
            从该成员⼤⼩或者成员的⼦成员⼤⼩（只要该成员有⼦成员，⽐如说是数组，
            结构体等）的整数倍开始(⽐如int为４字节,则要从４的整数倍地址开始存
            储。
            ２:结构体作为成员:如果⼀个结构⾥有某些结构体成员,则结构体成员要从
            其内部最⼤元素⼤⼩的整数倍地址开始存储.(struct a⾥存有struct b,b
            ⾥有char,int ,double等元素,那b应该从8的整数倍开始存储.)
            ３:收尾⼯作:结构体的总⼤⼩,也就是sizeof的结果,.必须是其内部最⼤
            成员的整数倍.不⾜的要补⻬。
            内存对⻬的原则
          */
        
            //size:
            //        1对象需要的内存空间 8 的倍数，8字节对齐 objc-os.h
            //        2.最少16
            XZPerson *person = [XZPerson alloc];
            NSLog(@"%lu ----%lu",class_getInstanceSize([person class]),malloc_size(person));

            
            
            XZTearcher *t = [XZTearcher alloc];
    //      isa   ---默认加载的       //8
            t.name  = @"Alan";      // 8
            t.age   = 18;           //4 +4 内存对齐
            t.height= 170;          //8
            t.course= @"数学";       //8
    //        这里进行内存对齐后应该是40
    //        t.sex   = 1;
    //        t.ch1   = 'a';
    //        t.ch2   = 'b';
            NSLog(@"%@",t);
           /***
            8字节对齐
            */
            NSLog(@"%lu ----%lu",class_getInstanceSize([t class]),malloc_size(t));
            //这里我们看出来，对象申请的内存大小，和系统开辟出来的内存大小不一样
            
    /***
     32位以4字节进行对齐
     64位以8字节进行对齐
     x/6gx t  打印出t内存 以4位进行排列
     首地址         内存值
     0x102e59200: 0x001d8001000026e9 0x0000001200006261
     0x102e59210: 0x0000000000000000 0x0000000100002048
     0x102e59220: 0x00000000000000aa 0x0000000100002068
     */
    //        0x0000001200006261  这是内存的值，从这个我们就可以看出来系统对内存有进行优化
    //        char  1字节
    //        int   4字节
    //        上篇文章中我们了解到系统内存有8字节对齐方式
            
    
}
@end
