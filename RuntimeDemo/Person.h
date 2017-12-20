//
//  Person.h
//  RuntimeDemo
//
//  Created by  Forfarming on 2017/12/20.
//  Copyright © 2017年  Forfarming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *age;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

- (void)play;

@end
