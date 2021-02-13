//
//  HHQDViewController.m
//  HHProduct
//
//  Created by AYS on 2021/2/3.
//  Copyright © 2021 024084. All rights reserved.
//

#import "HHQDViewController.h"
#import "HHAttendanceView.h"
#import "UIView+HHExt.h"
@interface HHQDViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HHAttendanceView *attendanceView;
@end

@implementation HHQDViewController

- (HHAttendanceView *)attendanceView {
    if (!_attendanceView) {
        _attendanceView = [HHAttendanceView loadInstanceFromNib];
        _attendanceView.frame = CGRectMake(0, 0, self.view.frame.size.width, 1000);
    }return _attendanceView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.tableView setTableHeaderView:self.attendanceView];
}

#pragma mark UITableVieDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark creat UI
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }return _tableView;
}
@end
