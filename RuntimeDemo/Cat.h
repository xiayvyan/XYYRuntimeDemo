//
//  Cat.h
//  RuntimeDemo
//
//  Created by  Forfarming on 2017/12/19.
//  Copyright © 2017年  Forfarming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cat : NSObject

@property (nonatomic, copy) NSString *age;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, strong) NSMutableArray *array;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
