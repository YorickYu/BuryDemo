//
//  UIViewController+logger.m
//  Bury
//
//  Created by YY on 2019/5/8.
//  Copyright © 2019 YY. All rights reserved.
//

#import "UIViewController+logger.h"
#import "YYHook.h"

@implementation UIViewController (logger)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL fromSelectorAppear = @selector(viewWillAppear:);
        SEL toSelectorAppear = @selector(yy_viewWillAppear:);
        [YYHook hookClass:self fromSelector:fromSelectorAppear toSelector:toSelectorAppear];
        
        SEL fromSelectorDisappear = @selector(viewWillDisappear:);
        SEL toSelectorDisappear = @selector(yy_viewWillDisappear:);
        [YYHook hookClass:self fromSelector:fromSelectorDisappear toSelector:toSelectorDisappear];
    });
}


- (void)yy_viewWillAppear:(BOOL)animated {
    [self yy_viewWillAppear:animated];
    NSLog(@"%@ 启动", NSStringFromClass([self class]));
}

- (void)yy_viewWillDisappear:(BOOL)animated {
    [self yy_viewWillDisappear:animated];
    NSLog(@"%@ 销毁", NSStringFromClass([self class]));

}



@end
