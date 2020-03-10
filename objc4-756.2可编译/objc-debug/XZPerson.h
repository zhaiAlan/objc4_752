//
//  XZPerson.h
//  objc-debug
//
//  Created by Alan on 3/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZPerson : NSObject
{
    NSString *hobby;
}
@property (nonatomic, copy) NSString *nickName;

- (void)sayHello;
+ (void)sayHappy;


@end

NS_ASSUME_NONNULL_END
