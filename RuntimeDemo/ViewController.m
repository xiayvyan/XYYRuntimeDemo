//
//  ViewController.m
//  RuntimeDemo
//
//  Created by  Forfarming on 2017/12/19.
//  Copyright © 2017年  Forfarming. All rights reserved.
//

#import "ViewController.h"
#import "Cat.h"
#import "Cat+Extend.h"
#import "Person.h"

#import <objc/runtime.h>
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];

//  消息机制
    ((void(*)(id, SEL))objc_msgSend)(self, @selector(message)); //  [self message];
 
/*
//  动态加载方法
    ((void(*)(id, SEL))objc_msgSend)(self, @selector(dynamicLoad)); //  [self dynamicLoad];
 */
/*
//    消息转发
    ((void(*)(id, SEL))objc_msgSend)(self, @selector(transpondMessage)); //  [self transpondMessage];
*/
/*
//    动态关联属性 (实现 category 添加属性)
    ((void(*)(id, SEL))objc_msgSend)(self, @selector(addCategoryWithProperty)); //  [self addCategoryWithProperty];
 */
/*
//    字典转模型应用
    ((void(*)(id, SEL))objc_msgSend)(self, @selector(dicTurnModel)); // [self dicTurnModel];
 */
}

#pragma mark - 1）消息机制、方法交换
- (void)message {
    //  通过类名获取类
    Class catClass = NSClassFromString(@"Cat");
    //  注意Class实际上也是对象，所以同样能够接受消息，向Class发送alloc消息
    id cat = ((id(*)(id, SEL))objc_msgSend)(catClass, @selector(alloc));
    //  发送init消息给Cat实例cat
    cat = ((id(*)(id, SEL))objc_msgSend)(cat, @selector(init));
    //  发送eat消息给cat，即调用eat方法
    ((void(*)(id, SEL, id))objc_msgSend)(cat, @selector(eat:), @"鱼");
}

#pragma mark - 2) 动态加载方法
- (void)dynamicLoad {
    //  通过类名获取类
    Class catClass = NSClassFromString(@"Cat");
    //  注意Class实际上也是对象，所以同样能够接受消息，向Class发送alloc消息
    id cat = ((id(*)(id, SEL))objc_msgSend)(catClass, @selector(alloc));
    //  发送init消息给Cat实例cat
    cat = ((id(*)(id, SEL))objc_msgSend)(cat, @selector(init));
    
    ((void(*)(id, SEL, id))objc_msgSend)(cat, @selector(study:), @"English");
}

#pragma mark - 4）消息转发
- (void)transpondMessage {

    Class personClass = NSClassFromString(@"Person");
    id person = ((id(*)(id, SEL))objc_msgSend)(personClass, @selector(alloc));
    person = ((id(*)(id, SEL))objc_msgSend)(person, @selector(init));
    
    ((void(*)(id, SEL, id))objc_msgSend)(person, @selector(run), @"Car");
    [person play];
}

#pragma mark - 5）动态关联属性 (实现 category 添加属性)
- (void)addCategoryWithProperty {
/*
    Cat *cat = [[Cat alloc] init];
    cat.name = @"壮壮";
 */
    Class catClass = NSClassFromString(@"Cat");
    Cat *cat = ((id(*)(id, SEL))objc_msgSend)(catClass, @selector(alloc));
    cat = ((id(*)(id, SEL))objc_msgSend)(cat, @selector(init));
    
    ((void(*)(id, SEL, id))objc_msgSend)(cat, @selector(setName:), @"壮壮");
    NSLog(@"%@", cat.name);
}

#pragma mark - 6）字典转模型应用
- (void)dicTurnModel {
    NSDictionary *dic = @{@"age" : @"3岁",
                          @"test" : @"测试",
                          @"sex" : @"母",
                          @"array" : @[@{@"age" : @"10岁"}, @{@"age" : @"21岁"}],
                          @"name" : @"壮壮"};
    Cat *cat = [Cat modelWithDict:dic];
    Person *person = cat.array.firstObject;
    NSLog(@"age = %@, sex = %@, person.age = %@, name = %@", cat.age, cat.sex, person.age, cat.name);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
