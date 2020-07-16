//
//  AnimationDemo.m
//  iOSProject
//
//  Created by mana on 2020/7/1.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "AnimationDemo.h"
#import "YHTitleScrollView.h"
#import "YHTitleRolling.h"

@interface AnimationDemo ()<CAAnimationDelegate,CDDRollingDelegate>
{
    
}
@property (nonatomic,strong) YHTitleRolling *jdRollingView;
@property (nonatomic,strong) UIImageView * romate;
@property (nonatomic,strong) UIImageView * romate2;
@property (nonatomic,strong) NSMutableArray * viewArray;
@end

@implementation AnimationDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.lightGrayColor;
    _viewArray = [NSMutableArray array];
//    [self demo5];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [UIView animateWithDuration:2 animations:^{
//            NSLog(@"%@-%@", NSStringFromCGRect(self.romate.frame),NSStringFromCGRect(self.romate2.frame));
//            CATransform3D transform = CATransform3DIdentity;
//            transform = CATransform3DMakeRotation(- M_PI_2, 1, 0, 0);
//            transform = CATransform3DTranslate(transform, 0, -100, -100);
//            self.romate.layer.transform = transform;
//
//            CATransform3D trans = CATransform3DIdentity;
//            trans = CATransform3DMakeRotation(0, 1, 0, 0);
//            trans = CATransform3DTranslate(trans, 0, 0, 0);
//            self.romate2.layer.transform = trans;
//        } completion:^(BOOL finished) {
//            NSLog(@"%@-%@", NSStringFromCGRect(self.romate.frame),NSStringFromCGRect(self.romate2.frame));
//        }];
//    });
//    [self setupView];
//    __weak typeof(self) weakSelf = self;
//    NSTimer * timer = [NSTimer timerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [UIView animateWithDuration:1 animations:^{
//
//            [weakSelf getMiddleArrayWithIndex:0 WithAngle:-M_PI_2 Height:-50];
//            [weakSelf getMiddleArrayWithIndex:1 WithAngle:0 Height:0];
//        } completion:^(BOOL finished) {
//            UIView * view = [weakSelf getMiddleArrayWithIndex:0 WithAngle:M_PI_2 Height:-50];
//            [weakSelf.viewArray addObject:view];
//
//            [weakSelf.viewArray removeObjectAtIndex:0];
//        }];
//    }];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
//    YHTitleScrollView * scr = [[YHTitleScrollView alloc] initWithFrame:CGRectMake(0, 300, 100, 40)];
//    [self.view addSubview:scr];
//    [scr scroll];
    _jdRollingView = [[YHTitleRolling alloc] initSimpleWithFrame:CGRectMake(0, 450, self.view.frame.size.width , 44) WithTitleData:^(CDDRollingGroupStyle *rollingGroupStyle,NSArray<YHTitleScrollModel *> *__autoreleasing *rolTitles) {
        NSMutableArray * array = [NSMutableArray array];
        YHTitleScrollModel * model1 = [YHTitleScrollModel new];
        model1.style = YHRollingTodayLive;
        model1.time = @"8:00";
        model1.title = @"新媒体装置艺术 在公共商业空…";
        YHTitleScrollModel * model2 = [YHTitleScrollModel new];
        model2.style = YHRollingLiving;
        model2.title = @"新媒体装置艺术 在公共商业空…";
        YHTitleScrollModel * model3 = [YHTitleScrollModel new];
        model3.style = YHRollingTodayLive;
        model3.time = @"8:00";
        model3.title = @"新媒体装置艺术 在公共商业空…";
        array = [NSMutableArray arrayWithArray:@[model1,model2,model3]];
        *rolTitles = array;
    }];
    
    [_jdRollingView dc_beginRolling];
    _jdRollingView.delegate = self;
//    _jdRollingView.layer.cornerRadius = 15;
//    [_jdRollingView.layer masksToBounds];
    _jdRollingView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_jdRollingView];
}
#pragma mark - <CDDRollingDelegate>
- (void)dc_RollingViewSelectWithActionAtIndex:(NSInteger)index
{
    NSLog(@"点击了第%zd头条滚动条",index);
}
- (void)setupView{
    for (int i=0; i<4; i++) {

        //romate
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
        img.image = [UIImage imageNamed:[NSString stringWithFormat:@"img%i",i+1]];
        img.backgroundColor = UIColor.redColor;
        [self.view addSubview:img];
        [self setUpCATransform3DWithIndex:i WithButton:img];
        [self.viewArray addObject:img];
    }
}
#pragma mark - CATransform3D翻转
- (UIView *)getMiddleArrayWithIndex:(NSInteger)index WithAngle:(CGFloat)angle Height:(CGFloat)height
{
    if (index > _viewArray.count) return 0;
    UIView *middleView = _viewArray[index];
    
    CATransform3D trans = CATransform3DIdentity;
    trans = CATransform3DMakeRotation(angle, 1, 0, 0);
    trans = CATransform3DTranslate(trans, 0, height, height);
    middleView.layer.transform = trans;
    
    return middleView;
}
#pragma mark - 初始布局
- (void)setUpCATransform3DWithIndex:(NSInteger)index WithButton:(UIView *)contentButton
{
    if (index != 0) {
        CATransform3D trans = CATransform3DIdentity;
        trans = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
        trans = CATransform3DTranslate(trans, 0, - 100 / 2, -100 / 2);
        contentButton.layer.transform = trans;
    }else{
        CATransform3D trans = CATransform3DIdentity;
        trans = CATransform3DMakeRotation(0, 1, 0, 0);
        trans = CATransform3DTranslate(trans, 0, 0, - 100 / 2);
        contentButton.layer.transform = trans;
    }
}
//1.CABasicAnimation基本动画（fromValue和toValue）
- (void)demo1{
    CABasicAnimation *animation = [CABasicAnimation new];
    
    // 设置动画要改变的属性
    animation.keyPath = @"transform.rotation.x";
    
    //animation.fromValue = @(_bgImgV.layer.transform.m11);
    
    // 动画的最终属性的值（转7.5圈）
    animation.toValue = @(M_PI*2);
    
    // 动画的播放时间
    animation.duration = 10;
    
    animation.repeatCount = LONG_MAX;
    
    // 动画效果同速度
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // 解决动画结束后回到原始状态的问题
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.delegate = self;
    
    // 将动画添加到视图bgImgV的layer上
    [self.romate.layer addAnimation:animation forKey:@"rotation"];

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
    [self.romate.layer addAnimation:animation forKey:nil];
    
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
       
    [self.romate.layer addAnimation:animation forKey:nil];

}
#pragma mark - UIView 代码块调用layer的CATransform3DIdentity;
//layer的CATransform3DIdentity;
- (void)demo4{
    self.romate.layer.transform = CATransform3DIdentity;
    [UIView animateWithDuration:20
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction|
     UIViewAnimationOptionCurveLinear
                     animations:^{
                       self.romate.layer.transform = CATransform3DMakeRotation(M_PI/4, 0, 0, 1);
                     }
                     completion:NULL
     ];
}
//view的CGAffineTransformIdentity；
- (void)demo5{
//    __block romateNew = romate;
//    romate.transform = CGAffineTransformIdentity;
//    [UIView animateWithDuration:100
//                            delay:0
//                          options:UIViewAnimationOptionAllowUserInteraction|
//       UIViewAnimationOptionCurveLinear
//                       animations:^{
//                         romate.transform = CGAffineTransformMakeRotation(M_PI);
//
//                       }
//                       completion:NULL
//       ];
    //====================================================================================
//    [UIView animateWithDuration:5 animations:^{
//        CATransform3D trans = CATransform3DIdentity;
//        trans = CATransform3DMakeRotation(- M_PI_2, 1, 0, 0);
//        trans = CATransform3DTranslate(trans, 0, 100, 100);
//        romate.layer.transform = trans;
//    }];
//
//    [UIView animateWithDuration:5 animations:^{
//        CATransform3D trans = CATransform3DIdentity;
//        trans = CATransform3DMakeRotation(- M_PI_2, 1, 0, 0);
//        trans = CATransform3DTranslate(trans, 0, 100, 100);
//        romate.layer.transform = trans;
//    }];
    //====================================================================================
    
    CATransition *transition = [[CATransition alloc] init];
    
    transition.type = @"pageCurl";
    transition.subtype = @"fromRight";
    transition.duration = 2.0;
    [self.romate.layer setValue:transition forKey:@"curlAnimation"];
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
