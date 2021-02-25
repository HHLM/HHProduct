//
//  HHAttendanceView.m
//  aiyingshi
//
//  Created by AYS on 2021/2/3.
//  Copyright © 2021 爱婴室. All rights reserved.
//


#define IMAGE_X                arc4random()%(int)Main_Screen_Width
#define IMAGE_ALPHA            ((float)(arc4random()%10))/10
#define IMAGE_WIDTH            arc4random()%10 + 10

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

#import "UIView+HHExt.h"
#import "HHAttendanceView.h"
@interface HHAttendanceView ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UILabel *qdLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet UIImageView *icon1;
@property (weak, nonatomic) IBOutlet UIImageView *icon2;
@property (weak, nonatomic) IBOutlet UIImageView *icon3;
@property (weak, nonatomic) IBOutlet UIImageView *icon4;
@property (weak, nonatomic) IBOutlet UIImageView *icon5;
@property (weak, nonatomic) IBOutlet UIImageView *icon6;
@property (weak, nonatomic) IBOutlet UIImageView *icon7;
@property (weak, nonatomic) IBOutlet UIImageView *icon8;
@property (weak, nonatomic) IBOutlet UIImageView *icon9;
@property (weak, nonatomic) IBOutlet UIImageView *icon10;
@property (weak, nonatomic) IBOutlet UIButton *qdButton;
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (nonatomic, strong) UIImageView *fishImageView;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) CALayer *ppLayer;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
@implementation HHAttendanceView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.infoLab.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -0.12);
    self.dataArray = @[self.icon1, self.icon2, self.icon3, self.icon4, self.icon5, self.icon6, self.icon7, self.icon8, self.icon9, self.icon10].mutableCopy;
    [self addHuxiAnimation:self.qdButton];
    
    [self addFish];
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (IBAction)qd_showAdDetail:(id)sender {
}

- (IBAction)qd_clicked:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    sender.selected = !sender.selected;
    for (int i = 0; i < 4; i++) {
        int count = arc4random() % 10;
        UIImageView *imageV = self.dataArray[count];
        [self addAnimation:imageV];
    }
    [sender setTitle:@"已签到" forState:UIControlStateNormal];
    self.qdButton.userInteractionEnabled = NO;
    [self.qdButton.layer removeAllAnimations];
}

- (void)show {
    [self.dataArray enumerateObjectsUsingBlock:^(UIImageView *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
//        obj.hidden = NO;
    }];
}

- (void)addAnimation:(UIView *)view {
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:view.center];
    [movePath addQuadCurveToPoint:CGPointMake(320, 35) controlPoint:CGPointMake(320, 35)];
    //关键帧动画（位置）
    CAKeyframeAnimation *posAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    posAnim.path = movePath.CGPath;
    posAnim.removedOnCompletion = YES;

    //缩放动画
    CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima1.fromValue = [NSNumber numberWithFloat:2.0f];
    anima1.toValue = [NSNumber numberWithFloat:0.5f];

    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
    anima2.fromValue = [NSValue valueWithCGPoint:CGPointMake(view.center.x, view.center.y)];
    anima2.toValue = [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width - 40, 35)];
    //组动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = [NSArray arrayWithObjects:posAnim, anima1, nil];
    groupAnimation.duration = 1.f;
    groupAnimation.delegate = self;
    [view.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        view.hidden = YES;
    });
}

- (void)addHuxiAnimation:(UIView *)view {
    CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima1.fromValue = [NSNumber numberWithFloat:1.2f];
    anima1.toValue = [NSNumber numberWithFloat:1.0f];
    anima1.duration = 1;
    anima1.autoreverses = YES;
    anima1.repeatCount = MAXINTERP;
    anima1.removedOnCompletion = NO;
    anima1.fillMode = kCAFillModeForwards;
    anima1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [view.layer addAnimation:anima1 forKey:@"groupAnimation"];
}

CGFloat timeStr = -0.1;
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    timeStr += 0.2;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeStr * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.countLab.text =  @([self.countLab.text intValue] + 1).description;
    });

    [self groupAnimation];
}



#pragma mark - 落下的paopao
- (void)addPopGroups {
    _imagesArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; ++ i) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ays_qd_pp"]];
        float x = IMAGE_WIDTH;
        imageView.frame = CGRectMake(IMAGE_X, -30, x, x);
        imageView.alpha = IMAGE_ALPHA;
        [self.topView addSubview:imageView];
        [_imagesArray addObject:imageView];

    }
    
    //创建时钟，并且添加到主循环中
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(makeSnow)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)makeSnow {
    if (_imagesArray.count > 0) {
        UIImageView *imageView = _imagesArray[0];
        [_imagesArray removeObjectAtIndex:0];
        [self snowFall:imageView];
    }
}

- (void)snowFall:(UIImageView *)imageView {
    [UIView animateWithDuration:10 animations:^{
        imageView.frame = CGRectMake(imageView.frame.origin.x, self.topView.height, imageView.frame.size.width, imageView.frame.size.height);
        imageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        imageView.transform = CGAffineTransformRotate(imageView.transform, M_PI);
    } completion:^(BOOL finished) {
        float x = IMAGE_WIDTH;
        imageView.frame = CGRectMake(IMAGE_X, -30, x, x);
        [self->_imagesArray addObject:imageView];
    }];
}


#pragma mark 基础旋转动画
- (CABasicAnimation *)rotationAnimation {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    CGFloat toValue = M_PI_2 * 3;
    basicAnimation.toValue = [NSNumber numberWithFloat:M_PI_2 * 3];
    //    basicAnimation.duration=6.0;
    basicAnimation.autoreverses = true;
    basicAnimation.repeatCount = HUGE_VALF;
    basicAnimation.removedOnCompletion = NO;

    [basicAnimation setValue:[NSNumber numberWithFloat:toValue] forKey:@"KCBasicAnimationProperty_ToValue"];

    return basicAnimation;
}

#pragma mark 关键帧移动动画
- (CAKeyframeAnimation *)translationAnimation {
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];

    CGPoint endPoint = CGPointMake(55, 375);
    CGPathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _ppLayer.position.x, _ppLayer.position.y);
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, endPoint.x, endPoint.y);

    keyframeAnimation.path = path;
    CGPathRelease(path);
    [keyframeAnimation setValue:[NSValue valueWithCGPoint:endPoint] forKey:@"KCKeyframeAnimationProperty_EndPosition"];

    return keyframeAnimation;
}

#pragma mark 创建动画组
- (void)groupAnimation {
    //1.创建动画组
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    //2.设置组中的动画和其他属性
    CABasicAnimation *basicAnimation = [self rotationAnimation];
    CAKeyframeAnimation *keyframeAnimation = [self translationAnimation];
    animationGroup.animations = @[basicAnimation, keyframeAnimation];
    animationGroup.delegate = self;
    animationGroup.duration = 10.0;//设置动画时间，如果动画组中动画已经设置过动画属性则不再生效
    animationGroup.beginTime = CACurrentMediaTime() + 1;//延迟五秒执行
    //3.给图层添加动画
    [_ppLayer addAnimation:animationGroup forKey:nil];
}


#pragma mark - 水里的小鱼
- (void)addFish {
    self.fishImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.topView.width/2 - 40, self.topView.height - 60, 80, 40)];
    self.fishImageView.image = [UIImage imageNamed:@"ays_icon"];
    [self.topView addSubview:self.fishImageView];
    self.fishImageView.hidden = YES;
    [NSTimer scheduledTimerWithTimeInterval:.3
                                     target:self
                                   selector:@selector(createBubble)
                                   userInfo:nil
                                    repeats:YES];
    
    [self goFishGo];
}
- (void)goFishGo {
    [UIView animateWithDuration:5 animations:^{
        self.fishImageView.frame = CGRectMake(20, self.topView.height - 60, 80, 40);
    } completion:^(BOOL finished) {
        self.fishImageView.frame = CGRectMake(self.topView.width - 100, self.topView.height - 60, 80, 40);
        [self goFishGo];
    }];
}

- (void)createBubble {
    UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ays_qd_pp"]];
    
    CGFloat size = [self randomFloatBetween:8 and:30];
    
    //获取气泡的位置
    CGFloat x = [self.fishImageView.layer.presentationLayer frame].origin.x + 5;
    CGFloat y = [self.fishImageView.layer.presentationLayer frame].origin.y + 80;
    [bubbleImageView setFrame:CGRectMake(x, y, size, size)];
    //透明度
    bubbleImageView.alpha = [self randomFloatBetween:.2 and:1];
    
    [self.topView addSubview:bubbleImageView];
    
    UIBezierPath *zigzagPath = [[UIBezierPath alloc] init];
    CGFloat oX = bubbleImageView.frame.origin.x;
    CGFloat oY = bubbleImageView.frame.origin.y;
    CGFloat eX = oX; // x坐标
    CGFloat eY = oY - [self randomFloatBetween:50 and:300];
    CGFloat t = [self randomFloatBetween:60 and:280];
    CGPoint cp1 = CGPointMake(oX - t, ((oY + eY) / 2));
    CGPoint cp2 = CGPointMake(oX + t, cp1.y);
    
    NSInteger r = arc4random() % 2;
    if (r == 1) {
        CGPoint temp = cp1;
        cp1 = cp2;
        cp2 = temp;
    }
    
    //开始位置
    [zigzagPath moveToPoint:CGPointMake(oX, oY)];
    
    //运动轨迹曲线
    [zigzagPath addCurveToPoint:CGPointMake(eX, eY) controlPoint1:cp1 controlPoint2:cp2];
    
    //开始动画
    [CATransaction begin];
    
    //气泡的爆照效果
    [CATransaction setCompletionBlock:^{
        [UIView transitionWithView:bubbleImageView
                          duration:0.5f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            bubbleImageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
                        } completion:^(BOOL finished) {
                            [bubbleImageView removeFromSuperview];
                        }];
    }];
    
    //运动动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 5;
    pathAnimation.path = zigzagPath.CGPath;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    [bubbleImageView.layer addAnimation:pathAnimation forKey:@"movingAnimation"];
    
    [CATransaction commit];

}


/// 获取  【区间】随机值
/// @param smallNumber 最小值
/// @param bigNumber 最大值
- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber; //差值
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

@end
