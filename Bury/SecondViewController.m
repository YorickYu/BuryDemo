//
//  SecondViewController.m
//  Bury
//
//  Created by YY on 2019/5/8.
//  Copyright © 2019 YY. All rights reserved.
//

#import "SecondViewController.h"
#import "UIControl+logger.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@end

@implementation SecondViewController

- (IBAction)click:(UIButton *)sender {
    // 这里触发 sendaction 方法
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);

    _button1.buryTag = @"action1";
    _button2.buryTag = @"action2";
    _button3.buryTag = @"action3";
    _button4.buryTag = @"action4";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
