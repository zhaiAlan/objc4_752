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
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        XZPerson *p = [XZPerson alloc];
     
        NSLog(@"%@",p);
    }
    return 0;
}



