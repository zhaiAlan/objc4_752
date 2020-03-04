//
//  XZTearcher.h
//  objc-debug
//
//  Created by Alan on 3/3/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZTearcher : NSObject
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
 *  course
 */
@property (copy, nonatomic) NSString *course;

@end

NS_ASSUME_NONNULL_END
