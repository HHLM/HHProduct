//
//  HHAnimationViewController.m
//  HHProduct
//
//  Created by AYS on 2021/2/22.
//  Copyright © 2021 024084. All rights reserved.
//

#import "HHAnimationViewController.h"
#import "LOTAnimationView.h"
@interface HHAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (nonatomic, strong) LOTAnimationView *animation;

@property (nonatomic, strong) UIButton *midButton;

@property (nonatomic, strong) NSArray *imgParr;

@end

@implementation HHAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstBtn.selected = YES;
    self.midButton = self.firstBtn;
}

- (NSArray *)imgParr
{
    if (!_imgParr) {
        _imgParr = @[@"first", @"first", ];
    }
    return _imgParr;
}
- (IBAction)clicked:(UIButton *)sender {
    if (self.midButton == sender) {
        return;
    }
    sender.selected = !sender.selected;
    self.midButton.selected = NO;
    self.midButton = sender;
    
    [self.animation removeFromSuperview];
    NSString *name = self.imgParr[sender.tag];
    CGFloat scale = [[UIScreen mainScreen] scale];
    name = 3.0 == scale ? [NSString stringWithFormat:@"%@@2x", name] : [NSString stringWithFormat:@"%@@2x", name];
    LOTAnimationView *animation = [LOTAnimationView animationNamed:name];
    [sender addSubview:animation];
    animation.bounds = sender.bounds;
    animation.center = CGPointMake(sender.frame.size.width/2.f, sender.frame.size.width/2.f);
    [animation playWithCompletion:^(BOOL animationFinished) {
    }];
    self.animation = animation;
}




+ (UIImage *)ssimageNamed:(NSString *)name {
    CGFloat scale = [[UIScreen mainScreen] scale];
    name = 3.0 == scale ? [NSString stringWithFormat:@"%@@2x.png", name] : [NSString stringWithFormat:@"%@@2x.png", name];
    UIImage *image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name]];
    return image;
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
