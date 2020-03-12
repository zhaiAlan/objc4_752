//
//  main.m
//  iskindof面试题
//
//  Created by Alan on 3/12/20.
//

#import <Foundation/Foundation.h>
#import "XZPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        BOOL re1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
        BOOL re2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
        BOOL re3 = [(id)[XZPerson class] isKindOfClass:[XZPerson class]];
        BOOL re4 = [(id)[XZPerson class] isMemberOfClass:[XZPerson class]];
        NSLog(@" \nre1 :%hhd\n re2 :%hhd\n re3 :%hhd\n re4 :%hhd\n",re1,re2,re3,re4);

        BOOL re5 = [(id)[NSObject alloc] isKindOfClass:[NSObject class]];
        BOOL re6 = [(id)[NSObject alloc] isMemberOfClass:[NSObject class]];
        BOOL re7 = [(id)[XZPerson alloc] isKindOfClass:[XZPerson class]];
        BOOL re8 = [(id)[XZPerson alloc] isMemberOfClass:[XZPerson class]];
        NSLog(@" \nre5 :%hhd\n re6 :%hhd\n re7 :%hhd\n re8 :%hhd\n",re5,re6,re7,re8);
        
        BOOL re9 = [(id)[NSObject class] isKindOfClass:[XZPerson class]];
        BOOL re10 = [(id)[NSObject class] isMemberOfClass:[XZPerson class]];
        BOOL re11 = [(id)[NSObject alloc] isKindOfClass:[XZPerson class]];
        BOOL re12 = [(id)[NSObject alloc] isKindOfClass:[XZPerson class]];

        NSLog(@" \nre5 :%hhd\n re6 :%hhd\n re7 :%hhd\n re8 :%hhd\n",re9,re10,re11,re12);

    }
    return 0;
}
