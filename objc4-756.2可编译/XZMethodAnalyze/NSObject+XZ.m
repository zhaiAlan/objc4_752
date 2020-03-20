//
//  NSObject+XZ.m
//  XZMethodAnalyze
//
//  Created by Alan on 3/18/20.
//

#import "NSObject+XZ.h"

#import <AppKit/AppKit.h>


@implementation NSObject (XZ)
- (void)sayMaster{
    NSLog(@"%s",__func__);
}
+ (void)sayEasy{
    NSLog(@"%s",__func__);
}

@end
