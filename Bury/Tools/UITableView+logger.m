//
//  UITableView+logger.m
//  Bury
//
//  Created by YY on 2019/5/8.
//  Copyright © 2019 YY. All rights reserved.
//

#import "UITableView+logger.h"
#import <objc/runtime.h>
#import "YYHook.h"

@implementation UITableView (logger)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL fromSelector = @selector(setDelegate:);
        SEL toSelector = @selector(yy_setDelegate:);
        [YYHook hookClass:self fromSelector:fromSelector toSelector:toSelector];
    });
}

- (void)yy_setDelegate:(id<UITableViewDelegate>)delegate {
    [self yy_setDelegate:delegate];
    SEL fromSelector = @selector(tableView:didSelectRowAtIndexPath:);
    SEL toSelector = @selector(yy_tableView:didSelectRowAtIndexPath:);

    // 检查 Controller 中是否实现了 tableView:didSelectRowAtIndexPath: 代理方法
    if (![self conformSel:fromSelector inClz:[delegate class]]) {
        return;
    }
    
    //        [YYHook hookClass:[delegate class] fromSelector:fromSelector toSelector:toSelector];
    //    Method method = class_getInstanceMethod([self class], toSelector);
    //        class_replaceMethod([delegate class], toSelector, method_getImplementation(method), method_getTypeEncoding(method));
    
    Method method = class_getInstanceMethod([self class], toSelector);

    /**
      1 给 Controller 添加替换方法 yy_tableView:didSelectRowAtIndexPath:
      2 把 Controller 中添加的方法实现在此分类中
     */
    if (class_addMethod([delegate class], toSelector, method_getImplementation(method), method_getTypeEncoding(method))) {
        [YYHook hookClass:[delegate class] fromSelector:fromSelector toSelector:toSelector];
    }
}

- (void)yy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self yy_tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    
    /**
      这个方法声明在 tableView 所在的 Controller 中！
      所以通过 [self class] 获取的是 controller 名称
     */
    NSString *controller = NSStringFromClass([self class]);
    NSLog(@"在%@，点击第%ld个cell", controller, indexPath.row);
}


#pragma mark --- tools
- (BOOL)conformSel:(SEL)sel inClz:(Class)class {
    unsigned int count = 0;
    Method *methods = class_copyMethodList(class, &count);
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        NSString *selString = [NSString stringWithUTF8String:sel_getName(method_getName(method))];
        if ([selString isEqualToString:NSStringFromSelector(sel)]) {
            return YES;
        }
    }
    return NO;
}

@end
