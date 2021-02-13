//
//  HHLoadHUD.h
//  aiyingshi
//
//  Created by AYS on 2020/8/14.
//  Copyright © 2020 爱婴室. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHLoadHUD : UIView

/// 单利
+ (instancetype)shareInstall;

/// 展示
- (void)ays_show;

/// 展示
- (void)ays_show:(UIView *)showView;

/// 隐藏
- (void)ays_hidden;

@end

@interface HHLoadHUD (HHExt)

+ (void)ays_showHUD:(UIView *)view;

+ (void)ays_showHUD;

+ (void)ays_hiddenHUD;

@end

NS_ASSUME_NONNULL_END
