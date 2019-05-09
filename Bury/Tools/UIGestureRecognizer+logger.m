//
//  UIGestureRecognizer+logger.m
//  Bury
//
//  Created by YY on 2019/5/9.
//  Copyright © 2019 YY. All rights reserved.
//

#import "UIGestureRecognizer+logger.h"
#import "YYHook.h"
#import <objc/runtime.h>

@interface UIGestureRecognizer()

@property (nonatomic, copy) NSString *clazzName;
@property (nonatomic, copy) NSString *actionName;

@end

@implementation UIGestureRecognizer (logger)

- (NSString *)clazzName {
    return objc_getAssociatedObject(self, @selector(clazzName));
}

- (void)setClazzName:(NSString *)className {
    objc_setAssociatedObject(self, @selector(clazzName), className, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)actionName {
    return objc_getAssociatedObject(self, @selector(actionName));
}

- (void)setActionName:(NSString *)actionName {
    objc_setAssociatedObject(self, @selector(actionName), actionName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL fromSelector = @selector(initWithTarget:action:);
        SEL toSelector = @selector(yy_initWithTarget:action:);
        [YYHook hookClass:self fromSelector:fromSelector toSelector:toSelector];
    });
}

- (instancetype)yy_initWithTarget:(id)target action:(SEL)action {
    SEL fromSelector = action;
    SEL toSelector = @selector(yy_action:);
    UIGestureRecognizer *originGesture = [self yy_initWithTarget:target action:action];
 
    // 1 过滤 target 和 action 为null的情况
    if (!target || !action) {
        return originGesture;
    }
    
    // 2 过滤 系统类 调用的 initWithTarget:action: 方法
    NSBundle *mainB = [NSBundle bundleForClass:[target class]];
    if (mainB != [NSBundle mainBundle]) {
        return originGesture;
    }
    
    // 3
    Method method = class_getInstanceMethod([self class], toSelector);
    if (class_addMethod([target class], toSelector, method_getImplementation(method), method_getTypeEncoding(method))) {
        [YYHook hookClass:[target class] fromSelector:fromSelector toSelector:toSelector];
    }
    NSLog(@"---->>>target: %@", [target class]);
    NSLog(@"----<<<action: %@", NSStringFromSelector(action));
    self.clazzName = NSStringFromClass([target class]);
    self.actionName = NSStringFromSelector(action);
    return originGesture;
}

- (void)yy_action:(UIGestureRecognizer *)gesture {
    [self yy_action:gesture];
    NSLog(@"点击了%@方法，位于：%@", gesture.actionName, gesture.clazzName);
}


@end
