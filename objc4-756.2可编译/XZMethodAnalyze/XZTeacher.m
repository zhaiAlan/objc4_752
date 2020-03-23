//
//  XZTeacher.m
//  XZMethodAnalyze
//
//  Created by Alan on 3/18/20.
//

#import "XZTeacher.h"
#import <objc/message.h>
#import "XZStudent.h"
@implementation XZTeacher
- (void)sayHello{
    NSLog(@"%s",__func__);

}
+(void)sayObjc{
    NSLog(@"%s",__func__);

}
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    NSLog(@"来了，resolveInstanceMethod");
//    if (sel == @selector(saySomthing)) {
////        NSLog(@"进入方法了saySomthing");
////        IMP saySomeIMP = class_getMethodImplementation(self, @selector(sayHello));
////        Method sayMethod = class_getInstanceMethod(self, @selector(sayHello));
////        const char *sayType = method_getTypeEncoding(sayMethod);
////        return class_addMethod(self, sel, saySomeIMP, sayType);
//        return NO;
//    }
//    return [super resolveInstanceMethod:sel];
//}
//+(BOOL)resolveClassMethod:(SEL)sel
//{
//    NSLog(@"来了:resolveClassMethod");
////    if (sel == @selector(sayLove)) {
////        NSLog(@"进入方法了sayLove");
////        IMP sayObjIMP = class_getMethodImplementation(objc_getMetaClass("XZTeacher"), @selector(sayObjc));
////        Method sayObjMethod = class_getClassMethod(objc_getMetaClass("XZTeacher"), @selector(sayObjc));
////        const char *sayObjType = method_getTypeEncoding(sayObjMethod);
////        // 类方法在元类 objc_getMetaClass("XZTeacher")
////        BOOL isAdd = class_addMethod(objc_getMetaClass("XZTeacher"), sel, sayObjIMP, sayObjType);
////        return isAdd;
////    }
//    return [super resolveClassMethod:sel];
//}
//实例方法调用这个转发
// 别人可能有?
// 快速流程 - 交给一个对象来处理
//- (id)forwardingTargetForSelector:(SEL)aSelector
//{
//    if (aSelector == @selector(saySomthing)) {
//        return [XZStudent alloc];
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}
////类方法调用这个转发
//+ (id)forwardingTargetForSelector:(SEL)aSelector
//{
//    if (aSelector == @selector(sayLove)) {
//        return [XZStudent class];
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}
//方法签名的下层慢速处理，返回一个方法签名 但是只有这个方法肯定是不够的
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSLog(@"%s -- %@",__func__,NSStringFromSelector(aSelector));
    if (aSelector == @selector(saySomthing)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"%s",__func__);
    //    在这里进行处理方法，如果处理的话就可以处理，不处理就会失效
    SEL aSelector = [anInvocation selector];
//    查看XZStudent 对象能否进行处理，如果能，就交给他处理不能就不处理了
    if ([[XZStudent alloc] respondsToSelector:aSelector])
        [anInvocation invokeWithTarget:[XZStudent alloc]];
    else
        [super forwardInvocation:anInvocation];
}
//类方法处理
+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSLog(@"%s -- %@",__func__,NSStringFromSelector(aSelector));
    if (aSelector == @selector(sayLove)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}
+ (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"%s",__func__);
    //    在这里进行处理方法，如果处理的话就可以处理，不处理就会失效
    SEL aSelector = [anInvocation selector];
    //    查看XZStudent 类能否进行处理，如果能，就交给他处理不能就不处理了
    if ([[XZStudent class] respondsToSelector:aSelector])
        [anInvocation invokeWithTarget:[XZStudent class]];
    else
        [super forwardInvocation:anInvocation];
}

@end
