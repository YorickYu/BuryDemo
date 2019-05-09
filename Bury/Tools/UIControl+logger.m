//
//  UIControl+logger.m
//  Bury
//
//  Created by YY on 2019/5/8.
//  Copyright © 2019 YY. All rights reserved.
//

#import "UIControl+logger.h"
#import <objc/runtime.h>
#import "YYHook.h"

@implementation UIControl (logger)

- (NSString *)buryTag {
    return objc_getAssociatedObject(self, @selector(buryTag));
}

- (void)setBuryTag:(NSString *)buryTag {
    objc_setAssociatedObject(self, @selector(buryTag), buryTag, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL fromSelector = @selector(sendAction:to:forEvent:);
        SEL toSelector = @selector(yy_sendAction:to:forEvent:);
        [YYHook hookClass:self fromSelector:fromSelector toSelector:toSelector];
    });
}

- (void)yy_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [self yy_sendAction:action to:target forEvent:event];
    NSLog(@"点击buryTag：%@", self.buryTag);
}

@end
