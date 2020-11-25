//
//  ADLaunchView.m
//  iOSProject
//
//  Created by mana on 2020/11/6.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "ADLaunchView.h"
//#import "LoginHomeViewController.h"
//#import "Community-Swift.h"
#import "AppDelegate.h"

@implementation ADLaunchView {
    NSTimer *m_pTimer;
    int inputSeconds;
    UILabel *secLabel;
    UIButton *contentBtn;
    UIImageView *adimg;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        adimg = [[UIImageView alloc]initWithFrame:frame];
        adimg.backgroundColor = [UIColor orangeColor];
        [self addSubview:adimg];
        adimg.userInteractionEnabled = YES;
        contentBtn = [[UIButton alloc] initWithFrame:adimg.bounds];
        contentBtn.backgroundColor = [UIColor clearColor];
        [contentBtn addTarget:self action:@selector(contentBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [adimg addSubview:contentBtn];
        
        UIView * timeBg = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width-80, 30, 65, 30)];
        timeBg.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        timeBg.layer.cornerRadius = 15;
        timeBg.clipsToBounds = YES;
        timeBg.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
        [adimg addSubview:timeBg];
        timeBg.userInteractionEnabled = YES;
        UITapGestureRecognizer *popTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction)];
        [timeBg addGestureRecognizer:popTap];
        
        UILabel * woldLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 32, 20)];
        woldLabel.text = @"跳过";
        woldLabel.textColor = [UIColor whiteColor];
        woldLabel.textAlignment = 1;
        woldLabel.font  = [UIFont systemFontOfSize:15.0];
        [timeBg addSubview:woldLabel];
        
        
        secLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(woldLabel.frame), 5, 20, 20)];
//        secLabel.textColor = [Constant colorOfDefined:@"#ff9900"];
        secLabel.textColor = UIColor.blackColor;
        secLabel.font = [UIFont systemFontOfSize:15.0];
        secLabel.textAlignment = 1;
        [timeBg addSubview: secLabel];
        inputSeconds = 3;
        secLabel.text = [NSString stringWithFormat:@"%d",inputSeconds];
        m_pTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                     target:self selector:@selector(calcuRemainTime)
                                                   userInfo:nil repeats:YES];
    }
    return self;
}

- (void)setAdImage:(UIImage *)adImage {
    adimg.image = adImage;
}

/*
 *倒计时剩余时间计算
 */
- (void)calcuRemainTime
{
    inputSeconds--;
    if (inputSeconds >= 0) {
        secLabel.text = [NSString stringWithFormat:@"%d",inputSeconds];
    }
    if (inputSeconds <= 0.0) {
        [m_pTimer invalidate];
        m_pTimer = nil;
        
        [self closeAction];
    }
}

- (void)closeAction {
    self.userInteractionEnabled = NO;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // 动画选项设定
    animation.duration = 1.5; // 动画持续时间
    animation.repeatCount = 0; // 重复次数
    animation.autoreverses = NO; // 动画结束时执行逆动画
    animation.delegate = self;
    
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:1.5]; // 结束时的倍率
    // 添加动画
    [self.layer addAnimation:animation forKey:@"scale-layer"];
    [UIView animateWithDuration:0.6 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
    }];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    if (flag) {
        [self removeFromSuperview];
    }
}

- (void)contentBtnAction {
//    NSString *link = [[NSUserDefaults standardUserDefaults] objectForKey:AD_PICS_CONNECT];
    NSString *link = @"www.baidu.com";
    if (link) {
//        SQ_OPEN(link, @"");
        [self closeAction];
//        for (UIViewController *vc in [AppDelegate sharedAppDelegate].topNavigationController.viewControllers) {
//            if ([vc isKindOfClass:[LoginHomeViewController class]]) {
//                [vc removeFromParentViewController];
//                [[AppDelegate sharedAppDelegate].topNavigationController setNavigationBarHidden:NO animated:YES];
//                break;
//            }
//        }
    }
}

+ (void)showAdView:(UIImage *)adImage1 {
    ADLaunchView *adView = [[ADLaunchView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    adView.adImage = adImage1;
    [[[UIApplication sharedApplication] keyWindow] addSubview:adView];
}
@end
