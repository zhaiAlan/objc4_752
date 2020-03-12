//
//  main.m
//  XZMethodAnalyze
//
//  Created by Alan on 3/12/20.
//

//#import <Foundation/Foundation.h>
#import "XZPerson.h"
#import <objc/runtime.h>
//#import <malloc/malloc.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        XZPerson *person = [XZPerson alloc];
        [person sayHello];
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
