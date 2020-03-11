//
//  XZPerson.h
//  XZClassAnalyze
//
//  Created by Alan on 3/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZPerson : NSObject
{
    NSString *hobby;
}
@property (nonatomic, copy) NSString *nickName;

- (void)sayHello;
- (void)sayCat;
- (void)sayDog;
- (void)sayPig;
+ (void)sayHappy;

@end

NS_ASSUME_NONNULL_END
