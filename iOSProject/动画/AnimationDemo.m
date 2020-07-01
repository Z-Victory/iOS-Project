//
//  AnimationDemo.m
//  iOSProject
//
//  Created by mana on 2020/7/1.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "AnimationDemo.h"

@interface AnimationDemo ()<CAAnimationDelegate>
{
    UIView * romate;
}
@end

@implementation AnimationDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    romate = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    romate.backgroundColor = UIColor.redColor;
    [self.view addSubview:romate];
    [self demo4];
}
//1.CABasicAnimation基本动画（fromValue和toValue）
- (void)demo1{
    CABasicAnimation *animation = [CABasicAnimation new];
    
    // 设置动画要改变的属性
    animation.keyPath = @"transform.rotation.z";
    
    //animation.fromValue = @(_bgImgV.layer.transform.m11);
    
    // 动画的最终属性的值（转7.5圈）
    animation.toValue = @(M_PI*2);
    
    // 动画的播放时间
    animation.duration = 60;
    
    animation.repeatCount = LONG_MAX;
    
    // 动画效果同速度
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // 解决动画结束后回到原始状态的问题
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.delegate = self;
    
    // 将动画添加到视图bgImgV的layer上
    [romate.layer addAnimation:animation forKey:@"rotation"];

}
#pragma mark - 、关键帧动画之path路径
- (void)demo2{
    // 1.创建动画
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.x"];

    // 2.设置路径
    animation.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(200, 200, 100, 100)].CGPath;
    
    //重复数量
    animation.repeatCount = CGFLOAT_MAX;

    // 动画时长,沿着路径运动,修改了时长,做完运动会停一下!又接着走!
    animation.duration = 60.0f;

    // 计算模式 -> 强制运动,匀速进行,不管路径有多远!
    animation.calculationMode = kCAAnimationPaced;
    
    
    // 旋转模式 -> 沿着路径,自行旋转 转的时候需要沿着路径的切线!进行转动!
    animation.rotationMode = kCAAnimationRotateAuto;
    

    // 3.添加
    [romate.layer addAnimation:animation forKey:nil];
    
}
//关键帧动画之values("之"字形动画)
- (void)demo3{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
       
    //设置value
   
    NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(100, 100)];
  
    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(200, 200)];
   
    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(100, 300)];
    
    NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(200, 400)];
   
    animation.values=@[value1,value2,value3,value4];
       
       //重复次数 默认为1
    animation.repeatCount=MAXFLOAT;
       
       //设置是否原路返回默认为不
    animation.autoreverses = YES;
       
       //设置移动速度，越小越快
    animation.duration = 4.0f;
       
    //完成后是否移除
    animation.removedOnCompletion = NO;

    //动画在开始和结束时的动作，默认值是kCAFillModeRemoved
    animation.fillMode = kCAFillModeForwards;
       
    //速度变化
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
       
    animation.delegate=self;
       
    //给这个view加上动画效果
       
    [romate.layer addAnimation:animation forKey:nil];

}
#pragma mark - UIView 代码块调用layer的CATransform3DIdentity;
//layer的CATransform3DIdentity;
- (void)demo4{
    romate.layer.transform = CATransform3DIdentity;
    [UIView animateWithDuration:20
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction|
     UIViewAnimationOptionCurveLinear
                     animations:^{
                       romate.layer.transform = CATransform3DMakeRotation(M_PI/4, 0, 0, 1);
                     }
                     completion:NULL
     ];
}
//view的CGAffineTransformIdentity；
- (void)demo5{
//    __block romateNew = romate;
    romate.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:100
                            delay:0
                          options:UIViewAnimationOptionAllowUserInteraction|
       UIViewAnimationOptionCurveLinear
                       animations:^{
                         romate.transform = CGAffineTransformMakeRotation(M_PI);

                       }
                       completion:NULL
       ];

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
