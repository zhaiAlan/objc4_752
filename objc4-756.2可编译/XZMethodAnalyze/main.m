//
//  main.m
//  XZMethodAnalyze
//
//  Created by Alan on 3/12/20.
//

//#import <Foundation/Foundation.h>
#import "XZPerson.h"
#import "XZTeacher.h"
#import "NSObject+XZ.h"
#import <objc/runtime.h>

extern void instrumentObjcMessageSends(BOOL flag);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        #pragma clang diagnostic push
//        // 让编译器忽略错误,不然调用没有的方法，编译器编译完语法分析会报错，导致不能运行
        #pragma clang diagnostic ignored "-Wundeclared-selector"

        XZTeacher *teacher = [XZTeacher alloc];

        // 对象方法
        // 自己有 - 返回自己
        //                [teacher sayHello];
        //                [teacher sayNB];
        //                [XZTeacher sayMaster];
        //        找不到这个方法
        //        [teacher performSelector:@selector(saySomthing)];
        //        消息转发流程
        instrumentObjcMessageSends(true);
        [teacher saySomthing];
        instrumentObjcMessageSends(false);

//        [XZTeacher sayLove];
        
        
        #pragma clang diagnostic pop
    }
    return 0;
}
