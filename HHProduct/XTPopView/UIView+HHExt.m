//
//  UIView+HHExt.m
//  NowKit_Example
//
//  Created by Now on 2020/5/26.
//  Copyright © 2020 HHLM. All rights reserved.
//

#import "UIView+HHExt.h"

@interface UIView ()

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable BOOL clipsToBounds;

@end

@implementation UIView (HHExt)

@end

@implementation UIView (ZZExt)

@end
#pragma mark -- Register
@implementation UIView (Register)

+ (instancetype)loadInstanceFromNib
{
    return [self loadInstanceFromNibWithName:NSStringFromClass([self class])];
}

+ (instancetype)loadInstanceFromNibWithName:(NSString *)nibName
{
    return [self loadInstanceFromNibWithName:nibName owner:nil];
}

+ (instancetype)loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner
{
    return [self loadInstanceFromNibWithName:nibName owner:nil bundle:[NSBundle mainBundle]];
}

+ (instancetype)loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle
{
    NSArray *nibViews = [bundle loadNibNamed:nibName owner:owner options:nil];

    UIView *curMainView = nil;

    for (id curObj in nibViews) {
        if ([curObj isKindOfClass:[self class]]) {
            curMainView = curObj;

            break;
        }
    }
    return curMainView;
}

- (void)setRoundingCornerWithCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end

#pragma mark -- CornerRadius
@implementation UIView (CornerRadius)

//圆角
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

//边框宽
- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = borderWidth > 0;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

//边框颜色
- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
    self.layer.masksToBounds = true;
}

- (CGColorRef)borderColor {
    return self.layer.borderColor;
}

@end
#pragma mark -- frame
@implementation UIView (frame)
- (void)setX:(CGFloat)x             /** 改变x坐标 */
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y             /** 改变y坐标 */
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width     /** 改变宽度 */
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height    /** 改变高度 */
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin    /** 改变x和y的坐标 */
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setSize:(CGSize)size         /** 改变frame */
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX /** < 改变中心x坐标 > */
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY /** < 改变中心y坐标 > */
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

/*--------------------get方法-----------------*/
- (CGFloat)x
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)y
{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}

- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)centerY             /** < 获取中心y坐标 > */
{
    return self.center.y;
}

- (CGFloat)centerX             /** < 获取中心x坐标 > */
{
    return self.center.x;
}

- (CGFloat)right               /** < 获取右边x坐标 > */
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)bottom              /** < 获取下面y坐标 > */
{
    return CGRectGetMaxY(self.frame);
}

@end
@implementation UIView (layer)

#pragma mark - layer
- (void)setRoundedCornersSize:(CGFloat)cornerRadius
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc] init];
    masklayer.frame = self.bounds;
    masklayer.path = maskPath.CGPath;
    self.layer.mask = masklayer;
}

- (void)rounded:(CGFloat)cornerRadius {
    [self rounded:cornerRadius width:0 color:nil];
}

- (void)border:(CGFloat)borderWidth color:(UIColor *_Nullable)borderColor {
    [self rounded:0 width:borderWidth color:borderColor];
}

- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *_Nullable)borderColor {
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [borderColor CGColor];
    self.layer.masksToBounds = YES;
}

- (void)round:(CGFloat)cornerRadius rectCorners:(UIRectCorner)rectCorner {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:rectCorner
                                                     cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

- (void)shadow:(UIColor *_Nullable)shadowColor opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset {
    //给Cell设置阴影效果
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = offset;
}

@end
