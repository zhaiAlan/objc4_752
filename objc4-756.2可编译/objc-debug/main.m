//
//  main.m
//  objc-debug
//
//  Created by Cooci on 2019/10/9.
//

#import <Foundation/Foundation.h>
#import "XZPerson.h"
#import "XZTearcher.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>
#import "MemoryAlignment.h"
#import "isaAnalyze.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        XZPerson *p1 = [XZPerson alloc];
        Class pClass = object_getClass(p1);
     
        NSLog(@"%@ --- %@",p1,pClass);
        
    }
    return 0;
}



