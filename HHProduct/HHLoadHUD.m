//
//  HHLoadHUD.m
//  aiyingshi
//
//  Created by AYS on 2020/8/14.
//  Copyright © 2020 爱婴室. All rights reserved.
//

#import "HHLoadHUD.h"
#import "Masonry.h"
@interface HHLoadHUD ()
#define kWindow                 ([UIApplication sharedApplication].keyWindow)
@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UIView *showView;

@end

@implementation HHLoadHUD

+ (instancetype)shareInstall {
    static dispatch_once_t onceToken;
    static HHLoadHUD *loadHUD = nil;
    dispatch_once(&onceToken, ^{
        loadHUD = [[HHLoadHUD alloc] initWithFrame:kWindow.bounds];
    });
    return loadHUD;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageV];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 1; i < 75; i++) {
            [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"load%d", i]]];
        }
        _imageV.animationImages = array;
        _imageV.animationDuration = 30 * 0.1f;
        _imageV.animationRepeatCount = 0;
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.height.mas_equalTo(36);
        }];
    }
    return self;
}

- (void)ays_show {
    [self ays_show:kWindow];
}

- (void)ays_show:(UIView *)showView {
    _showView = showView;
    self.bounds = showView.bounds;
    [showView addSubview:self];
    [showView bringSubviewToFront:self];
    self.hidden = NO;
    [self.imageV startAnimating];
}

- (void)ays_hidden {
    [self removeFromSuperview];
    self.hidden = YES;
    [self.imageV stopAnimating];
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
        _imageV.backgroundColor = [UIColor clearColor];
    }
    return _imageV;
}

@end

@implementation HHLoadHUD (HHExt)

+ (void)ays_showHUD:(UIView *)view {
    [[HHLoadHUD shareInstall] ays_show:view];
}

+ (void)ays_showHUD {
    [HHLoadHUD ays_showHUD:kWindow];
}

+ (void)ays_hiddenHUD {
    [[HHLoadHUD shareInstall] ays_hidden];
}

@end
