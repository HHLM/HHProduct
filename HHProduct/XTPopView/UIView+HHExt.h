//
//  UIView+HHExt.h
//  NowKit_Example
//
//  Created by Now on 2020/5/26.
//  Copyright © 2020 HHLM. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HHExt)

@end

#pragma mark -- load Nib
@interface UIView (ZZExt)

@end

#pragma mark -- Register
@interface UIView (Register)
+ (instancetype _Nullable )loadInstanceFromNib;

+ (instancetype _Nullable )loadInstanceFromNibWithName:(NSString *_Nullable)nibName;

+ (instancetype _Nullable )loadInstanceFromNibWithName:(NSString *_Nullable)nibName owner:(nullable id)owner;

+ (instancetype _Nullable )loadInstanceFromNibWithName:(NSString *_Nullable)nibName owner:(nullable id)owner bundle:(NSBundle *_Nullable)bundle;

- (void)setRoundingCornerWithCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

@end


#pragma mark -- CornerRadius
@interface UIView (CornerRadius)

@end

#pragma mark -- frame
@interface UIView (frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@end

@interface UIView(layer)

- (void)setRoundedCornersSize:(CGFloat)cornerRadius;
/** 圆角 */
- (void)rounded:(CGFloat)cornerRadius;

/** 边框+边框颜色 */
- (void)border:(CGFloat)borderWidth color:(UIColor *_Nullable)borderColor;

/** 圆角 + 边框  + 边框颜色*/
- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *_Nullable)borderColor;

/** 圆角大小+圆角位置 */
- (void)round:(CGFloat)cornerRadius rectCorners:(UIRectCorner)rectCorner;


/// 设置阴影
/// @param shadowColor 阴影颜色
/// @param opacity opacity
/// @param radius 阴影圆角
/// @param offset 偏移
- (void)shadow:(UIColor *_Nullable)shadowColor opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;
@end

NS_ASSUME_NONNULL_END
