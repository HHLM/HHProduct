//
//  HHSnowViewController.m
//  HHProduct
//
//  Created by AYS on 2021/2/4.
//  Copyright © 2021 024084. All rights reserved.
//

#define IMAGE_X                arc4random()%(int)Main_Screen_Width
#define IMAGE_ALPHA            ((float)(arc4random()%10))/10
#define IMAGE_WIDTH            arc4random()%10 + 10
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

#import "HHSnowViewController.h"
#import "UIView+HHExt.h"
@interface HHSnowViewController ()
@property (nonatomic, strong) NSMutableArray *imagesArray;
@end

@implementation HHSnowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _imagesArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 1000; ++ i) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"snow"]];
        float x = IMAGE_WIDTH;
        imageView.frame = CGRectMake(IMAGE_X, -30, x, x);
        imageView.alpha = IMAGE_ALPHA;
        [self.view addSubview:imageView];
        [_imagesArray addObject:imageView];
    }
    
    //创建时钟，并且添加到主循环中
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(makeSnow)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}


- (void)makeSnow
{
    if (_imagesArray.count > 0) {
        UIImageView *imageView = _imagesArray[0];
        [_imagesArray removeObjectAtIndex:0];
        [self snowFall:imageView];
    }
}

- (void)snowFall:(UIImageView *)imageView
{
    [UIView animateWithDuration:10 animations:^{
        imageView.frame = CGRectMake(imageView.frame.origin.x, Main_Screen_Height, imageView.frame.size.width, imageView.frame.size.height);
        imageView.transform = CGAffineTransformMakeScale(0.3, 0.3);
        imageView.transform = CGAffineTransformRotate(imageView.transform, M_PI);
    } completion:^(BOOL finished) {
        float x = IMAGE_WIDTH;
        imageView.frame = CGRectMake(IMAGE_X, -30, x, x);
        [self->_imagesArray addObject:imageView];
    }];
}

@end
