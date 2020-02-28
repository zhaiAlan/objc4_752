//
//  main.m
//  objc-debug
//
//  Created by Cooci on 2019/10/9.
//

#import <Foundation/Foundation.h>
#import "LGPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        LGPerson *object = [LGPerson alloc];
        NSLog(@"Hello, World! %@",object);
        NSString *str = [NSString stringWithFormat:@"123"];
        
        NSLog(@"%@ - %lu",str,[str retainCount]);
        NSNumber *num = @100;
        NSNumber *num2 = @(3.14);
        NSLog(@"%@ - %lu",num,[num retainCount]);
        NSLog(@"%@ - %lu",num2,[num2 retainCount]);

    }
    return 0;
}
