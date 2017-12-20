//
//  Person.m
//  RuntimeDemo
//
//  Created by  Forfarming on 2017/12/20.
//  Copyright © 2017年  Forfarming. All rights reserved.
//

#import "Person.h"
#import "Car.h"

#import <objc/runtime.h>

@implementation Person

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    id model = [[self alloc] init];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        ivarName = [ivarName substringFromIndex:1];
        id value = dict[ivarName];

        [model setValue:value forKeyPath:ivarName];
    }
    return model;
}

- (void)play {
    NSLog(@"----人玩----");
}

/*
#pragma mark - 以下写法都可以
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return YES;
    
//    return NO;
    
//    return [super resolveInstanceMethod:sel];

//    if (sel == @selector(run)) {
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [[Car alloc] init];
}
 */

//  第一步，消息接收者没有找到对应的方法时候，会先调用此方法，可在此方法实现中动态添加新的方法
//  返回YES表示相应selector的实现已经被找到，或者添加新方法到了类中，否则返回NO
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return YES;
}
//  第二步， 如果第一步的返回NO或者直接返回了YES而没有添加方法，该方法被调用
//  在这个方法中，我们可以指定一个可以返回一个可以响应该方法的对象， 注意如果返回self就会死循环
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}
//  第三步， 如果forwardingTargetForSelector:返回了nil，则该方法会被调用，系统会询问我们要一个合法的『类型编码(Type Encoding)』
//  若返回 nil，则不会进入下一步，而是无法处理消息
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
}
// 当实现了此方法后，-doesNotRecognizeSelector: 将不会被调用
// 在这里进行消息转发
- (void)forwardInvocation:(NSInvocation *)anInvocation {
/*  (转发给自己)
    // 在这里可以改变方法选择器
    [anInvocation setSelector:@selector(unknow)];
    // 改变方法选择器后，需要指定消息的接收者
    [anInvocation invokeWithTarget:self];
 */
    [anInvocation setSelector:@selector(run2:)];
    [anInvocation invokeWithTarget:[[Car alloc] init]];
}

- (void)unknow {
    NSLog(@"unkown method.......");
}
// 如果没有实现消息转发 forwardInvocation  则调用此方法
- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"unresolved method ：%@", NSStringFromSelector(aSelector));
}

@end
