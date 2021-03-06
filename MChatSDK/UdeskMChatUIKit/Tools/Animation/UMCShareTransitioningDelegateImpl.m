//
//  UMCShareTransitioningDelegateImpl.m
//  UdeskSDK
//
//  Created by Udesk on 16/7/18.
//  Copyright © 2016年 Udesk. All rights reserved.
//

#import "UMCShareTransitioningDelegateImpl.h"
#import "UMCAnimatorPush.h"

@implementation UMCShareTransitioningDelegateImpl

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    UMCAnimatorPush *animator = [UMCAnimatorPush new];
    animator.isPresenting = YES;
    return animator;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    UMCAnimatorPush *animator = [UMCAnimatorPush new];
    return animator;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactive ? self.interactiveTransitioning : nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactive ? self.interactiveTransitioning : nil;
}

- (UIPercentDrivenInteractiveTransition <UIViewControllerAnimatedTransitioning> *)interactiveTransitioning {
    if (!_interactiveTransitioning) {
        _interactiveTransitioning = [UMCAnimatorPush new];
    }
    return _interactiveTransitioning;
}

///At end of transitioning call this function, otherwise the transisted view controller will be kept in memory
- (void)finishTransition {
    _interactiveTransitioning = nil;
}

@end
