//
//  NSObject+XZ.m
//  XZMethodAnalyze
//
//  Created by Alan on 3/18/20.
//

#import "NSObject+XZ.h"
#import <objc/message.h>
#import <AppKit/AppKit.h>


@implementation NSObject (XZ)
- (void)sayMaster{
    NSLog(@"%s",__func__);
}
+ (void)sayEasy{
    NSLog(@"%s",__func__);
}
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"来了，%s",__func__);
    if (sel == @selector(saySomthing)) {
        NSLog(@"进入方法了saySomthing");
        IMP saySomeIMP = class_getMethodImplementation(self, @selector(sayMaster));
        Method sayMethod = class_getInstanceMethod(self, @selector(sayMaster));
        const char *sayType = method_getTypeEncoding(sayMethod);
        return class_addMethod(self, sel, saySomeIMP, sayType);
    }
    
        if (sel == @selector(sayLove)) {
            NSLog(@"进入方法了sayLove");
            IMP sayObjIMP = class_getMethodImplementation(objc_getMetaClass("NSObject"), @selector(sayEasy));
            Method sayObjMethod = class_getClassMethod(objc_getMetaClass("NSObject"), @selector(sayEasy));
            const char *sayObjType = method_getTypeEncoding(sayObjMethod);
            // 类方法在元类 objc_getMetaClass("XZTeacher")
            return  class_addMethod(objc_getMetaClass("NSObject"), sel, sayObjIMP, sayObjType);;
        }

//    [super resolveInstanceMethod:sel]，因为这里是根类不能调用super了，直接返回NO就行
    return NO;
}

@end
