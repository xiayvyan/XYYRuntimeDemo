//
//  Cat.m
//  RuntimeDemo
//
//  Created by  Forfarming on 2017/12/19.
//  Copyright © 2017年  Forfarming. All rights reserved.
//

#import "Cat.h"
#import "Person.h"

#import <objc/runtime.h>
#import <objc/message.h>

@implementation Cat

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    id model = [[self alloc] init];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        ivarName = [ivarName substringFromIndex:1];
        id value = dict[ivarName];
        if ([value isKindOfClass:[NSArray class]]) {
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dic in value) {
                Person *person = [Person modelWithDict:dic];
                [arr addObject:person];
            }
            [model setValue:arr forKeyPath:ivarName];
        }else{
            [model setValue:value forKeyPath:ivarName];
        }
    }
    return model;
}

- (void)eat:(NSString *)str {
    NSLog(@"----猫吃%@----", str);
}
/*
#pragma mark - 方法交换
+ (void)load {
    //    2）方法交换    如果没有 shirt，还执行 eat 方法
    Method eatMethod = class_getInstanceMethod(self, @selector(eat:));
    Method shirtMethod = class_getInstanceMethod(self, @selector(shirt:));
    
    method_exchangeImplementations(eatMethod, shirtMethod);
}

- (void)shirt:(NSString *)str {
    NSLog(@"----%@吸猫----", str);
}
 */
#pragma mark - 动态加载方法
//  + (BOOL)resolveClassMethod:(SEL)sel 类方法
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"%@", NSStringFromSelector(sel));
    if (sel == NSSelectorFromString(@"study:")) {
        class_addMethod([self class], sel, (IMP)studyEngilsh, "v@:@");
        return YES;
    }
    return [super resolveClassMethod:sel];
}
void studyEngilsh(id self, SEL _cmd, NSString *str) {
    
    NSLog(@"动态添加了一个学习英语的方法%@", str);
}

@end
