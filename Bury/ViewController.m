//
//  ViewController.m
//  Bury
//
//  Created by YY on 2019/5/6.
//  Copyright © 2019 YY. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) NSArray<Class> *vcs;

@end

@implementation ViewController

-(UITableView *)tableView {
    if (_tableView) {
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseid"];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"HOME";
    self.list = @[@"声明周期埋点",
                  @"点击事件",
                  @"cell点击",
                  @"手势事件"];
    self.vcs = @[FirstViewController.self,
                 SecondViewController.self,
                 ThirdViewController.self,
                 FourthViewController.self];
    [self.view addSubview:self.tableView];
    
}

#pragma mark --- UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseid" forIndexPath:indexPath];
    cell.textLabel.text = _list[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    if (indexPath.row > self.vcs.count - 1) {
        return;
    }
    id controller = self.vcs[indexPath.row];
    UIViewController * vc = [[controller alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}


@end
