//
//  FKScrollTabBarVC.m
//  FKScrollTabBar
//
//  Created by frank on 16/1/26.
//  Copyright © 2016年 QQ920924960. All rights reserved.
//

#import "FKScrollTabBarVC.h"
#import "FKTestVC1.h"
#import "FKTestVC2.h"
#import "FKTestVC3.h"
#import "FKTabBarItem.h"
static CGFloat const tabBarH = 49;
static CGFloat screenW() {
    return [UIScreen mainScreen].bounds.size.width;
}
static CGFloat screenH() {
    return [UIScreen mainScreen].bounds.size.height;
}

@interface FKScrollTabBarVC ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *tabBar;
@end

@implementation FKScrollTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建UI控件
    [self setupUI];
    
    // 添加子控制器
    [self setupChildVCs];
    
    // 添加底部的tabbar的Item
    [self setupTabBarItem];
    
    // 设置默认控制器
    UIViewController *firstVC = [self.childViewControllers firstObject];
    firstVC.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:firstVC.view];
    self.title = firstVC.title;
    
    // 设置scrollview的content
    [self setupScrollViewContent];
}


/** 创建UI控件 */
- (void)setupUI
{
    CGRect scrollViewF = CGRectMake(0, 0, screenW(), screenH() - tabBarH);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:scrollViewF];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    //    scrollView.showsHorizontalScrollIndicator = NO;
    //    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGRect tabBarF = CGRectMake(0, screenH() - tabBarH, screenW(), tabBarH);
    UIView *tabBar = [[UIView alloc] initWithFrame:tabBarF];
    [self.view addSubview:tabBar];
    self.tabBar = tabBar;
    self.tabBar.backgroundColor = [UIColor yellowColor];
    
    
}

/** 添加子控制器 */
- (void)setupChildVCs
{
    FKTestVC1 *test1 = [[FKTestVC1 alloc] init];
    test1.title = @"test1";
    [self addChildViewController:test1];
    
    FKTestVC2 *test2 = [[FKTestVC2 alloc] init];
    test2.title = @"test2";
    [self addChildViewController:test2];
    
    FKTestVC3 *test3 = [[FKTestVC3 alloc] init];
    test3.title = @"test3";
    [self addChildViewController:test3];
}


/** 添加底部的tabbar以及tabBarItem */
- (void)setupTabBarItem
{
    NSUInteger count = self.childViewControllers.count;
    CGFloat itemW = screenW() / count;
    CGFloat itemH = 40;
    CGFloat itemY = 5;
    for (NSUInteger index = 0; index < count; index++) {
        FKTabBarItem *item = [[FKTabBarItem alloc] init];
        item.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(255) / 255.0) green:(arc4random_uniform(255) / 255.0) blue:(arc4random_uniform(255) / 255.0) alpha:1.0];
        item.itemIndex = index;
        [self.tabBar addSubview:item];
        
        CGFloat itemX = index * itemW;
        item.frame = CGRectMake(itemX, itemY, itemW, itemH);
        
        UIViewController *VC = self.childViewControllers[index];
        item.title = VC.title;
        
        // 监听点击事件
        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClicked:)]];
    }
}

/** item的点击事件 */
- (void)itemClicked:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"---itemClicked--");
    // 获得被点击的view
    FKTabBarItem *item = (FKTabBarItem *)recognizer.view;
    CGFloat offsetX = item.itemIndex * self.scrollView.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:offset animated:YES];
}

/** 设置scrollview的content */
- (void)setupScrollViewContent
{
    // 设置内容的size
    NSUInteger count = self.childViewControllers.count;
    CGFloat contentW = count * screenW();
    self.scrollView.contentSize = CGSizeMake(contentW, 0);
    
    // 将子控制器的view添加到scrollview上
    CGFloat VCW = self.scrollView.frame.size.width;
    CGFloat VCH = self.scrollView.frame.size.height;
    CGFloat VCY = 0;
    for (NSUInteger index = 0; index < count; index++) {
        UIViewController *VC = self.childViewControllers[index];
        CGFloat VCX = index * VCW;
        VC.view.frame = CGRectMake(VCX, VCY, VCW, VCH);
        if ([VC isKindOfClass:[UITableViewController class]] || [VC isKindOfClass:[UICollectionViewController class]]) {
            VC.view.frame = CGRectMake(VCX, VCY, VCW, VCH - 20 - 44);
        }
        [self.scrollView addSubview:VC.view];
    }
}

#pragma mark - UIScrollViewDelegate
/** 在scrollView动画结束时调用 【用户手动触发的动画结束，不会调用这个方法】*/
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self setTitleWithScrollView:scrollView];
}

/** 当scrollview停止滚动时调用这个方法（用户手动触发的动画停止，就会调用这个方法） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self setTitleWithScrollView:scrollView];
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 设置导航栏的标题 */
- (void)setTitleWithScrollView:(UIScrollView *)scrollView
{
    // 获得当前显示的子控制器的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    UIViewController *VC = self.childViewControllers[index];
    self.title = VC.title;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
