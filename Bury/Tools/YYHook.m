//
//  YYHook.m
//  Bury
//
//  Created by YY on 2019/5/8.
//  Copyright © 2019 YY. All rights reserved.
//

#import "YYHook.h"
#import <objc/runtime.h>

@implementation YYHook

+ (void)hookClass:(Class)classObject fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector {
    Class cls = classObject;
    Method fromMethod = class_getInstanceMethod(cls, fromSelector);
    Method toMethod = class_getInstanceMethod(cls, toSelector);
    
    if (class_addMethod(cls, fromSelector, method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        class_replaceMethod(cls, toSelector, method_getImplementation(fromMethod), method_getTypeEncoding(fromMethod));
    } else {
        method_exchangeImplementations(fromMethod, toMethod);
    }
}


@end
