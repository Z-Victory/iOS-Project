//
//  YHTitleScrollView.m
//  iOSProject
//
//  Created by mana on 2020/7/7.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "YHTitleScrollView.h"

@interface YHTitleScrollView()
@property (nonatomic,strong) NSMutableArray * viewArray;
@end

@implementation YHTitleScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - lazy

- (NSMutableArray *)viewArray{
    if (_viewArray == nil) {
        _viewArray = [NSMutableArray array];
    }
    return _viewArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.brownColor;
        for (int i = 0; i<2; i++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (50+10)*i, 100, 50)];
            imageView.image = [UIImage imageNamed:@"image3"];
            [self addSubview:imageView];
            [self.viewArray addObject:imageView];
        }
    }
    return self;
}
- (void)scroll{
    [UIView animateWithDuration:2 animations:^{
        
        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DMakeRotation(- M_PI_2, 1, 0, 0);
        transform = CATransform3DScale(transform, 0, 0, 50);
        self.layer.transform = transform;
        
    }];
    
//    UIView * view0 =  self.viewArray[0];
//    // 1.创建动画
//    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//
//    // 2.设置路径
//    CGRect rect = view0.frame;
//    rect.origin.y = 60;
//    UIBezierPath * path = [UIBezierPath bezierPathWithRect:rect];
//    animation.path = path.CGPath;
//
//    //重复数量
//    animation.repeatCount = CGFLOAT_MAX;
//
//    // 动画时长,沿着路径运动,修改了时长,做完运动会停一下!又接着走!
//    animation.duration = 3.0f;
//
//    // 计算模式 -> 强制运动,匀速进行,不管路径有多远!
//    animation.calculationMode = kCAAnimationPaced;
//
//
//    // 旋转模式 -> 沿着路径,自行旋转 转的时候需要沿着路径的切线!进行转动!
//    animation.rotationMode = kCAAnimationRotateAuto;
//
//
//    // 3.添加
//    [view0.layer addAnimation:animation forKey:nil];
}
@end
