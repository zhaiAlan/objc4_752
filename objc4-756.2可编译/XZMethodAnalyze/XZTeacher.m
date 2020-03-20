//
//  XZTeacher.m
//  XZMethodAnalyze
//
//  Created by Alan on 3/18/20.
//

#import "XZTeacher.h"
#import <objc/message.h>

@implementation XZTeacher
- (void)sayHello{
    NSLog(@"%s",__func__);

}
+(void)sayObjc{
    NSLog(@"%s",__func__);

}
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(saySomthing)) {
        NSLog(@"进入方法了");
        IMP saySomeIMP = class_getMethodImplementation(self, @selector(sayHello));
        Method sayMethod = class_getInstanceMethod(self, @selector(sayHello));
        const char *sayType = method_getTypeEncoding(sayMethod);
        return class_addMethod(self, sel, saySomeIMP, sayType);
    }
    return [super resolveInstanceMethod:sel];
}
@end
