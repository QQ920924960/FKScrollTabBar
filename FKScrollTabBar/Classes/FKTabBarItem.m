//
//  FKTabBarItem.m
//  FKScrollTabBar
//
//  Created by frank on 16/1/26.
//  Copyright © 2016年 QQ920924960. All rights reserved.
//

#import "FKTabBarItem.h"

@interface FKTabBarItem ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *titleLabel;
@end

@implementation FKTabBarItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        self.backgroundColor = [UIColor redColor];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor greenColor];
        [self addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageWH = 10;
    self.imageView.frame = CGRectMake((self.frame.size.width - imageWH) * 0.5, 0, imageWH, imageWH);
    CGFloat titleLabelW = 100;
    CGFloat titleLabelH = 30;
    CGFloat titleLabelY = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.frame = CGRectMake(self.imageView.frame.origin.x, titleLabelY, titleLabelW, titleLabelH);
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

@end
