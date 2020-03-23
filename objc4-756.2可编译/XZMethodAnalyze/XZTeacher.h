//
//  XZTeacher.h
//  XZMethodAnalyze
//
//  Created by Alan on 3/18/20.
//

#import "XZPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZTeacher : XZPerson
- (void)sayHello;
+(void)sayObjc;
//这个方法只声明不实现
- (void)saySomthing;
+ (void)sayLove;

@end

NS_ASSUME_NONNULL_END
