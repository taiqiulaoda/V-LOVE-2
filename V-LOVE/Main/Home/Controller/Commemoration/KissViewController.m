//
//  KissViewController.m
//  V-LOVE
//
//  Created by mac on 15/10/23.
//  Copyright (c) 2015年 Anyi. All rights reserved.
//

#import "KissViewController.h"

@interface KissViewController ()

@end

@implementation KissViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSubView:@"第一次接吻的日子" forKey:KKissTime];
    self.maskWindow.index = 5;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
