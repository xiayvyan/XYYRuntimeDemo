//
//  Cat+Extend.m
//  RuntimeDemo
//
//  Created by  Forfarming on 2017/12/20.
//  Copyright © 2017年  Forfarming. All rights reserved.
//

#import "Cat+Extend.h"
#import <objc/runtime.h>

@implementation Cat (Extend)

- (void)setName:(NSString *)name {
    /**
     *  设置关联对象
     *
     *  @param object  需要添加关联的对象
     *  @param key     添加的唯一标识符
     *  @param value   关联的对象
     *  @param policy  关联的策略,是个枚举
                 typedef OBJC_ENUM(uintptr_t, objc_AssociationPolicy){
                 OBJC_ASSOCIATION_ASSIGN = 0,             //assign
                 OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1,   //retain,nonatomic(非原子性)
                 OBJC_ASSOCIATION_COPY_NONATOMIC = 3,     //copy,nonatomic(非原子性)
                 OBJC_ASSOCIATION_RETAIN = 01401,         //retain(原子性)
                 OBJC_ASSOCIATION_COPY = 01403,           //copy(原子性)
                 };
     */
    objc_setAssociatedObject(self, "name", name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    /**
     *  获得关联对象
     *
     *  @param object    添加过关联的对象
     *  @param key       添加的唯一标识符
     */
    return objc_getAssociatedObject(self, "name");
}

@end
