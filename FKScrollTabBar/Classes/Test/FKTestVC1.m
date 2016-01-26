//
//  FKTestVC1.m
//  FKScrollTabBar
//
//  Created by frank on 16/1/26.
//  Copyright © 2016年 QQ920924960. All rights reserved.
//

#import "FKTestVC1.h"

@interface FKTestVC1 ()

@end

@implementation FKTestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];
    view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0];
    [self.view addSubview:view];
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
