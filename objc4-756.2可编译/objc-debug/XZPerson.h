//
//  XZPerson.h
//  objc-debug
//
//  Created by Alan on 3/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZPerson : NSObject
/**
 *  name
 */
@property (copy, nonatomic) NSString *name;
/**
 *  age
 */
@property (assign,nonatomic) int age;

/**
height
 */
@property (assign,nonatomic) long height;

/**
 *  hobby
 */
@property (copy, nonatomic) NSString *hobby;


@end

NS_ASSUME_NONNULL_END
