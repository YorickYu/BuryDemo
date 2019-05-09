//
//  FourthViewController.m
//  Bury
//
//  Created by YY on 2019/5/9.
//  Copyright © 2019 YY. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()
@property (weak, nonatomic) IBOutlet UIView *actionView;
@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.actionView addGestureRecognizer:gesture];
}

- (void)click:(UITapGestureRecognizer *)sender {
    NSLog(@"view 点击了");
}


@end
