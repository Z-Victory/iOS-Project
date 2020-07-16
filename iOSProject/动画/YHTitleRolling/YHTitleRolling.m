//
//  YHTitleScrollView.h
//  iOSProject
//
//  Created by mana on 2020/7/7.
//  Copyright © 2020 刘亚和. All rights reserved.
//
#define RollingBtnTag      1000

#define RollingViewHeight self.frame.size.height
#define RollingViewWidth self.frame.size.width
#define RollingMargin 10

#import "YHTitleRolling.h"

// Controllers

// Models

// Views

// Vendors

// Categories
#import "UIView+DCRolling.h"
// Others

@interface YHTitleRolling ()

/** 定时器的循环时间 */
@property (nonatomic , assign) NSInteger interval;
/* 定时器 */
@property (strong , nonatomic)NSTimer *timer;
/* 图片 */
@property (strong , nonatomic)NSString *leftImage;
/* 按钮提示文字 */
@property (strong , nonatomic)NSString *rightbuttonTitle;

/* 标题 */
@property (strong , nonatomic)NSArray *rolTitles;
/* tags */
@property (strong , nonatomic)NSArray *rolTags;
/* 右边图片数组 */
@property (strong , nonatomic)NSArray *rightImages;
/* 滚动时间 */
@property (assign , nonatomic)float rollingTime;
/* 字体尺寸 */
@property (nonatomic , assign) NSInteger titleFont;
/* 字体颜色 */
@property (strong , nonatomic)UIColor *titleColor;

/* 滚动按钮数组 */
@property (strong , nonatomic)NSMutableArray *saveMiddleArray;
/** 是否显示tagLabel边框 */
@property (nonatomic,assign)BOOL isShowTagBorder;

@property (nonatomic, assign) CDDRollingGroupStyle rollingGroupStyle;

@end

@implementation YHTitleScrollModel

@end

@implementation YHTitleRolling

#pragma mark - LazyLoad
- (UIImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_leftImageView];
    }
    return _leftImageView;
}


- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.adjustsImageWhenHighlighted = NO;
        [_rightButton setTitleColor:[UIColor darkGrayColor] forState:0];
        [self addSubview:_rightButton];
    }
    return _rightButton;
}

- (NSMutableArray *)saveMiddleArray
{
    if (!_saveMiddleArray) {
        _saveMiddleArray = [NSMutableArray array];
    }
    return _saveMiddleArray;
}

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame WithTitleData:(void(^)(CDDRollingGroupStyle *rollingGroupStyle, NSString **leftImage,NSArray **rolTitles,NSArray **rolTags,NSArray **rightImages,NSString **rightbuttonTitle,NSInteger *interval,float *rollingTime,NSInteger *titleFont,UIColor **titleColor,BOOL *isShowTagBorder))titleDataBlock{
    
    self = [super initWithFrame:frame];
    if (self) {

        NSString *leftImage;
        NSString *rightbuttonTitle;
        
        NSArray *rolTitles;
        NSArray *rolTags;
        NSArray *rightImages;
        
        NSInteger interval;
        float rollingTime;
        NSInteger titleFont;
        UIColor *titleColor;

        BOOL isShowTagBorder;
        
        if (titleDataBlock) {
        titleDataBlock(&_rollingGroupStyle,&leftImage,&rolTitles,&rolTags,&rightImages,&rightbuttonTitle,&interval,&rollingTime,&titleFont,&titleColor,&isShowTagBorder);
            
            self.leftImage = leftImage;
            self.rolTitles = rolTitles;
            self.rolTags = rolTags;
            self.rightImages = rightImages;
            self.interval = (interval == 0 || interval > 100) ? 5.0 : interval; //限定定时不大于100秒
            self.rollingTime = (rollingTime <= 0.1  || rollingTime > 1) ? 0.5 : rollingTime; //限定翻滚时间不能大于1秒
            self.rightbuttonTitle = rightbuttonTitle;
            self.titleFont = (titleFont == 0) ? 13 : titleFont;
            self.titleColor = (titleColor == nil) ? [UIColor blackColor] : titleColor;
            self.isShowTagBorder = isShowTagBorder;
            
            
            if (self.rolTags.count == 0 && self.rolTitles.count == 0) return 0; //若数组为0直接返回
            switch (_rollingGroupStyle) {
                case CDDRollingOneGroup:
                    [self setUpOneGroupRollingUI]; //UI
                    break;

                case CDDRollingTwoGroup:
                    [self setUpTwoGroupRollingUI]; //UI
                    break;
                    
                default:
                    [self setUpOneGroupRollingUI]; //UI
                    break;
            }
        };
        
    }
    return self;
}
- (instancetype)initSimpleWithFrame:(CGRect)frame WithTitleData:(void(^)(CDDRollingGroupStyle *rollingGroupStyle,NSArray<YHTitleScrollModel *> **rolTitles))titleDataBlock{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray * rolTitles;
        if (titleDataBlock) {
            titleDataBlock(&_rollingGroupStyle,&rolTitles);
            self.dataArray = rolTitles;
            self.interval = 3;
            self.rollingTime = 0.5;
            if (self.dataArray.count == 0) return 0; //若数组为0直接返回
            
            if (_rollingGroupStyle==CDDRollingOneGroup){
                [self setUpDefaultRollingUI]; //UI每组一个
            }else{
                [self setUpDefaultTwoGroupRollingUI]; //UI每组2个
            }
        }
        
    }
    return self;
}
#pragma mark - 界面搭建【CDDRollingOneGroup】
- (void)setUpDefaultRollingUI
{
    for (int i=0; i<self.dataArray.count; i++) {
        YHTitleScrollModel * model = self.dataArray[i];
        //右边按钮是否为空来改变middleFrame的宽度
        CGRect titleFrame = CGRectMake(0, 0, RollingViewWidth, RollingViewHeight);
        
        UIButton *titleView = [self getBackMiddleViewWithFrame:titleFrame WithIndex:i];

        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 14, 14)];
        [titleView addSubview:image];
        
        UILabel *livingState = [UILabel new];
        [titleView addSubview:livingState];
        livingState.textAlignment = NSTextAlignmentLeft;
        if (model.style == YHRollingTodayLive) {
            livingState.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 14];
            livingState.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
            livingState.text = @"今日直播";
            
            image.image = [UIImage imageNamed:@"icon_app_live_today_red"];
        }else{
            livingState.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 14];
            livingState.textColor = [UIColor colorWithRed:252/255.0 green:77/255.0 blue:63/255.0 alpha:1.0];
            livingState.text = model.title;
            livingState.text = @"直播中";
            
            NSArray * gifImageArray = [self getGifImage:@"icon_app_live_on_red"];
            image.image = gifImageArray[0];
            image.animationImages = gifImageArray;
            //animationDuration值越小，运动速度越快
            image.animationDuration = 0.7;
            //animationRepeatCount代表循环次数，默认是0，表示无限循环
            image.animationRepeatCount = 0;
            //这句话一定要记得加，启动动画；页面消失时别忘了stopAnimating
            [image startAnimating];
        }
        CGSize livingStateSize = [self labelAutoCalculateRectWith:livingState.text FontSize:14 MaxSize:CGSizeMake(MAXFLOAT, RollingViewHeight)];
        livingState.dc_size = CGSizeMake(livingStateSize.width + 4, livingStateSize.height + 4);
        livingState.dc_x = 35;
        livingState.dc_centerY = titleView.dc_centerY;
        

        UILabel *contentLabel = [UILabel new];
        [titleView addSubview:contentLabel];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
        contentLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        contentLabel.text = model.title;
        contentLabel.frame = CGRectMake(CGRectGetMaxX(livingState.frame) + 8, 0, titleView.dc_width - CGRectGetMaxX(livingState.frame) - 30, titleView.dc_height);
        
        //indicator
        UIImageView * indicatorImage = [[UIImageView alloc] init];
        indicatorImage.image = [UIImage imageNamed:@"icon_profile_live_now_arrow"];
        indicatorImage.dc_size = CGSizeMake(10, 16);
        indicatorImage.dc_x = self.dc_width - 16 - 15;
        indicatorImage.dc_centerY = titleView.dc_centerY;
        [titleView addSubview:indicatorImage];
        
        [self setUpCATransform3DWithIndex:i WithButton:titleView]; //旋转
    }

}
- (void)setUpDefaultTwoGroupRollingUI
{
    /*
     知识补充
     小数向上取整，指小数部分直接进1 x=3.14，ceilf(x)=4
     小数向下取整，指直接去掉小数部分 x=3.14，floor(x)=3

     ceil(x)返回不小于x的最小整数值（然后转换为double型）。 floor(x)返回不大于x的最大整数值 round(x)返回x的四舍五入整数值。

     NSLog(@"%d", (int) ceil(10 / 3));  //结果是3
     NSLog(@"%d",  (int)ceil(10 / 3.0));  //结果是4
     */
    int group = (int)ceilf(self.dataArray.count/2);
    for (int i=0; i<group; i++) {
        YHTitleScrollModel * model = self.dataArray[i];
        //右边按钮是否为空来改变middleFrame的宽度
        CGRect titleFrame = CGRectMake(0, 0, RollingViewWidth, RollingViewHeight);
        
        UIButton *titleView = [self getBackMiddleViewWithFrame:titleFrame WithIndex:i];

        UIImageView * topImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 14, 14)];
        [titleView addSubview:topImage];
        
        UIImageView * bottomImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 14, 14)];
        [titleView addSubview:bottomImage];
        
        UILabel *topLivingState = [UILabel new];
        UILabel *bottomLivingState = [UILabel new];
        [titleView addSubview:topLivingState];
        [titleView addSubview:bottomLivingState];
        topLivingState.textAlignment = NSTextAlignmentLeft;
        bottomLivingState.textAlignment = NSTextAlignmentLeft;
        if (model.style == YHRollingTodayLive) {
            topLivingState.font = [UIFont fontWithName:@"PingFangSC" size: 14];
            topLivingState.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
            topLivingState.text = @"今日直播";
            
            topImage.image = [UIImage imageNamed:@""];
            
            bottomLivingState.font = [UIFont fontWithName:@"PingFangSC" size: 14];
            bottomLivingState.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
            bottomLivingState.text = @"今日直播";
            
            bottomImage.image = [UIImage imageNamed:@""];
        }else{
            topLivingState.font = [UIFont fontWithName:@"PingFangSC" size: 14];
            topLivingState.textColor = [UIColor colorWithRed:252/255.0 green:77/255.0 blue:63/255.0 alpha:1.0];
            topLivingState.text = model.title;
            topLivingState.text = @"直播中";
            
            bottomLivingState.font = [UIFont fontWithName:@"PingFangSC" size: 14];
            bottomLivingState.textColor = [UIColor colorWithRed:252/255.0 green:77/255.0 blue:63/255.0 alpha:1.0];
            bottomLivingState.text = model.title;
            bottomLivingState.text = @"直播中";
            
            NSArray * gifImageArray = [self getGifImage:@"icon_app_live_on_red"];
            topImage.image = gifImageArray[0];
            topImage.animationImages = gifImageArray;
            //animationDuration值越小，运动速度越快
            topImage.animationDuration = 0.7;
            //animationRepeatCount代表循环次数，默认是0，表示无限循环
            topImage.animationRepeatCount = 0;
            //这句话一定要记得加，启动动画；页面消失时别忘了stopAnimating
            [topImage startAnimating];
            
            bottomImage.image = gifImageArray[0];
            bottomImage.animationImages = gifImageArray;
            //animationDuration值越小，运动速度越快
            bottomImage.animationDuration = 0.7;
            //animationRepeatCount代表循环次数，默认是0，表示无限循环
            bottomImage.animationRepeatCount = 0;
            //这句话一定要记得加，启动动画；页面消失时别忘了stopAnimating
            [bottomImage startAnimating];
        }
        CGSize topLivingStateSize = [self labelAutoCalculateRectWith:topLivingState.text FontSize:14 MaxSize:CGSizeMake(MAXFLOAT, RollingViewHeight)];
        topLivingState.dc_size = CGSizeMake(topLivingStateSize.width + 4, topLivingStateSize.height + 4);
        topLivingState.dc_x = 35;
        topLivingState.dc_centerY = titleView.dc_centerY;
        
        CGSize bottomLivingStateSize = [self labelAutoCalculateRectWith:bottomLivingState.text FontSize:14 MaxSize:CGSizeMake(MAXFLOAT, RollingViewHeight)];
        bottomLivingState.dc_size = CGSizeMake(bottomLivingStateSize.width + 4, bottomLivingStateSize.height + 4);
        bottomLivingState.dc_x = 35;
        bottomLivingState.dc_centerY = titleView.dc_centerY;
        

        UILabel *contentLabel = [UILabel new];
        [titleView addSubview:contentLabel];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.font = topLivingState.font;
        contentLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        contentLabel.text = model.title;
        contentLabel.frame = CGRectMake(CGRectGetMaxX(topLivingState.frame) + 8, 0, titleView.dc_width - CGRectGetMaxX(topLivingState.frame) - 30, titleView.dc_height/2);
        
        UILabel *bottomContentLabel = [UILabel new];
        [titleView addSubview:bottomContentLabel];
        bottomContentLabel.textAlignment = NSTextAlignmentLeft;
        bottomContentLabel.font = bottomLivingState.font;
        bottomContentLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        bottomContentLabel.text = model.title;
        bottomContentLabel.frame = CGRectMake(CGRectGetMaxX(bottomLivingState.frame) + 8, 0, titleView.dc_width - CGRectGetMaxX(bottomLivingState.frame) - 30, titleView.dc_height/2);
        
        [self setUpCATransform3DWithIndex:i WithButton:titleView]; //旋转
    }

}
- (void)setUpOneGroupRollingUI
{
    
    [self setUpRollingLeft];
    
    [self setUpRollingCenter];
    
    [self setUpRollingRight];

}

#pragma mark - 界面搭建【CDDRollingTwoGroup】
- (void)setUpTwoGroupRollingUI
{
    [self setUpRollingLeft];
    
    [self setUpRollingCenterRight];
}

#pragma mark - 左边图片
- (void)setUpRollingLeft
{
    if (self.leftImage == nil)return;

    self.leftImageView.frame = CGRectMake(0, RollingViewHeight * 0.1, RollingViewHeight * 1.5, RollingViewHeight * 0.8);
    self.leftImageView.image = [UIImage imageNamed:self.leftImage];
    
}

#pragma mark - 中间带右部
- (void)setUpRollingCenterRight
{
    if (self.saveMiddleArray.count > 0) return;

    if (_rolTitles.count > 1) {//@[@[],@[]]
        
        NSArray *firstTitleArrray = _rolTitles.firstObject;
        NSArray *firstTagArrray = _rolTags.firstObject;
        NSArray *lastTagArray = _rolTags.lastObject;
        NSArray *lastTitleArray = _rolTitles.lastObject;
        
        for (NSInteger i= 0; i < firstTitleArrray.count; i++) {
            
            UIButton *middleView = [self getBackMiddleViewWithFrame:CGRectMake(CGRectGetMaxX(self.leftImageView.frame), 0, RollingViewWidth - CGRectGetMaxX(self.leftImageView.frame), RollingViewHeight) WithIndex:i]; //中间View
            
            UILabel *contentTopLabel = [UILabel new];
            [middleView addSubview:contentTopLabel];
            
            UILabel *contentBottomLabel = [UILabel new];
            [middleView addSubview:contentBottomLabel];
            
            contentTopLabel.textAlignment = contentBottomLabel.textAlignment = NSTextAlignmentLeft;
            contentTopLabel.font = contentBottomLabel.font = [UIFont systemFontOfSize:self.titleFont];
            contentTopLabel.textColor = contentBottomLabel.textColor = self.titleColor;
            
            UIImageView *rightImageView = [UIImageView new];
            if (_rightImages.count == firstTitleArrray.count) {
                
                [middleView addSubview:rightImageView];
                rightImageView.frame = CGRectMake(middleView.dc_width - (middleView.dc_height * 1.2), 0, middleView.dc_height * 1.2, middleView.dc_height);
                rightImageView.contentMode = UIViewContentModeCenter;
                rightImageView.image = [UIImage imageNamed:_rightImages[i]];
            }
            
            contentTopLabel.text = firstTitleArrray[i];
            contentBottomLabel.text = lastTitleArray[i];
            
            if (_rolTags.count > 0 && firstTitleArrray.count == firstTagArrray.count) {

                UILabel *tagTopLabel = [UILabel new];
                UILabel *tagBottomLabel = [UILabel new];
                [middleView addSubview:tagTopLabel];
                [middleView addSubview:tagBottomLabel];

                tagTopLabel.font = tagBottomLabel.font = [UIFont systemFontOfSize:self.titleFont - 1.5];
                tagTopLabel.textColor = tagBottomLabel.textColor = [UIColor orangeColor];
                tagTopLabel.textAlignment = tagBottomLabel.textAlignment = NSTextAlignmentCenter;
                tagTopLabel.text = firstTagArrray[i];
                tagBottomLabel.text = lastTagArray[i];
                
                if (self.isShowTagBorder) { //是否tag显示边框
                    [self dc_chageControlCircularWith:tagTopLabel AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:tagTopLabel.textColor canMasksToBounds:YES];
                    [self dc_chageControlCircularWith:tagBottomLabel AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:tagBottomLabel.textColor canMasksToBounds:YES];
                }
                
                CGSize tagTopSize = [self labelAutoCalculateRectWith:firstTagArrray[i] FontSize:self.titleFont - 1 MaxSize:CGSizeMake(MAXFLOAT, RollingViewHeight)];
                CGSize tagBottomSize = [self labelAutoCalculateRectWith:lastTagArray[i] FontSize:self.titleFont - 1 MaxSize:CGSizeMake(MAXFLOAT, RollingViewHeight)];
                
                tagTopLabel.dc_size = CGSizeMake(tagTopSize.width + 4, tagTopSize.height + 4);
                tagBottomLabel.dc_size = CGSizeMake(tagBottomSize.width + 4, tagBottomSize.height + 4);
                
                contentTopLabel.frame = CGRectMake(CGRectGetMaxX(tagTopLabel.frame) + 5, 0, middleView.dc_width - rightImageView.dc_width, middleView.dc_height * 0.5);
                
                contentBottomLabel.frame = CGRectMake(CGRectGetMaxX(tagBottomLabel.frame) + 5, middleView.dc_height * 0.5, middleView.dc_width - rightImageView.dc_width, middleView.dc_height * 0.5);
                
                tagTopLabel.dc_x = tagBottomLabel.dc_x = 0;
                tagTopLabel.dc_centerY = contentTopLabel.dc_centerY;
                tagBottomLabel.dc_centerY = contentBottomLabel.dc_centerY;
                
            }else{
                
                contentTopLabel.frame = CGRectMake(0, 0, middleView.dc_width - rightImageView.dc_width, middleView.dc_height * 0.5);
                contentBottomLabel.frame = CGRectMake(0, middleView.dc_height * 0.5, middleView.dc_width - rightImageView.dc_width, middleView.dc_height * 0.5);
                
            }
            
            [self setUpCATransform3DWithIndex:i WithButton:middleView];//旋转
        }
    }
}

#pragma mark - 中间滚动内容
- (void)setUpRollingCenter
{
    if (self.saveMiddleArray.count > 0) return;
    
    if (_rolTitles.count > 0) {
        for (NSInteger i = 0; i < _rolTitles.count; i++) {
            //右边按钮是否为空来改变middleFrame的宽度
            CGRect middleFrame = (self.rightbuttonTitle == nil) ? CGRectMake(CGRectGetMaxX(self.leftImageView.frame), 0, RollingViewWidth - CGRectGetMaxX(self.leftImageView.frame), RollingViewHeight) : CGRectMake(CGRectGetMaxX(self.leftImageView.frame), 0, RollingViewWidth - (CGRectGetMaxX(self.leftImageView.frame) + RollingViewWidth * 0.2), RollingViewHeight);
            
            UIButton *middleView = [self getBackMiddleViewWithFrame:middleFrame WithIndex:i];
            
            UILabel *contentLabel = [UILabel new];
            [middleView addSubview:contentLabel];
            contentLabel.textAlignment = NSTextAlignmentLeft;
            contentLabel.font = [UIFont systemFontOfSize:self.titleFont];
            contentLabel.textColor = self.titleColor;
            contentLabel.text = self.rolTitles[i];
            
            if (self.rolTags.count > 0 && self.rolTitles.count == self.rolTags.count) {
            
                UILabel *tagLabel = [UILabel new];
                [middleView addSubview:tagLabel];
                tagLabel.font = [UIFont systemFontOfSize:self.titleFont - 1.5];
                tagLabel.textColor = [UIColor redColor];
                tagLabel.textAlignment = NSTextAlignmentCenter;
                
                tagLabel.text = self.rolTags[i];
                if (self.isShowTagBorder) {//是否tag显示边框
                    [self dc_chageControlCircularWith:tagLabel AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:tagLabel.textColor canMasksToBounds:YES];
                }
                
                CGSize tagSize = [self labelAutoCalculateRectWith:self.rolTags[i] FontSize:self.titleFont - 1 MaxSize:CGSizeMake(MAXFLOAT, RollingViewHeight)];
                tagLabel.dc_size = CGSizeMake(tagSize.width + 4, tagSize.height + 4);
                tagLabel.dc_x = 0;
                tagLabel.dc_centerY = middleView.dc_centerY;
                
                contentLabel.frame = CGRectMake(CGRectGetMaxX(tagLabel.frame) + 5, 0, middleView.dc_width - CGRectGetMaxX(tagLabel.frame), middleView.dc_height);

            }else{
                contentLabel.frame = CGRectMake(5, 0, middleView.dc_width - RollingMargin, middleView.dc_height);
            
            }
            
            [self setUpCATransform3DWithIndex:i WithButton:middleView]; //旋转
        }
    }
}

#pragma mark - 右边按钮
- (void)setUpRollingRight
{
    if (self.rightbuttonTitle == nil) return;
    
    self.rightButton.frame = CGRectMake(RollingViewWidth * 0.8, RollingViewHeight * 0.1, RollingViewWidth * 0.18, RollingViewHeight * 0.8);
    [self.rightButton setTitle:self.rightbuttonTitle forState:0];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:self.titleFont + 0.5];
    
    [self.rightButton addTarget:self action:@selector(rightMoreButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *btnLine = [UIView new];
    btnLine.backgroundColor = [UIColor darkGrayColor];
    btnLine.frame = CGRectMake(RollingViewWidth * 0.82, RollingViewHeight * 0.35, 1.5, RollingViewHeight * 0.3);
    [self addSubview:btnLine];
}



#pragma mark - 开始滚动
- (void)dc_beginRolling{
    if (self.saveMiddleArray.count <= 1) return;
    _timer = [NSTimer timerWithTimeInterval:self.interval target:self selector:@selector(titleRolling) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

#pragma mark - 结束滚动
- (void)dc_endRolling{
    
    [_timer invalidate];
}


#pragma mark - 标题滚动
- (void)titleRolling{
    
    if (self.saveMiddleArray.count > 1) { //所存的每组滚动
        __weak typeof(self)weakSelf = self;
        
        [UIView animateWithDuration:self.rollingTime animations:^{
            
            [self getMiddleArrayWithIndex:0 WithAngle:- M_PI_2 Height:- RollingViewHeight / 2]; //第0组
            
            [self getMiddleArrayWithIndex:1 WithAngle:0 Height:0]; //第一组
            
        } completion:^(BOOL finished) {
            
            if (finished == YES) { //旋转结束
                UIButton *newMiddleView = [weakSelf getMiddleArrayWithIndex:0 WithAngle:M_PI_2 Height: -RollingViewHeight / 2];
                [weakSelf.saveMiddleArray addObject:newMiddleView];
                
                [weakSelf.saveMiddleArray removeObjectAtIndex:0];
            }
        }];
    }
    
}

#pragma mark - CATransform3D翻转
- (UIButton *)getMiddleArrayWithIndex:(NSInteger)index WithAngle:(CGFloat)angle Height:(CGFloat)height
{
    if (index > _saveMiddleArray.count) return 0;
    UIButton *middleView = self.saveMiddleArray[index];
    
    CATransform3D trans = CATransform3DIdentity;
    trans = CATransform3DMakeRotation(angle, 1, 0, 0);
    trans = CATransform3DTranslate(trans, 0, height, height);
    middleView.layer.transform = trans;
    
    return middleView;
}

#pragma mark - 初始布局
- (void)setUpCATransform3DWithIndex:(NSInteger)index WithButton:(UIButton *)contentButton
{
    if (index != 0) {
        CATransform3D trans = CATransform3DIdentity;
        trans = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
        trans = CATransform3DTranslate(trans, 0, - RollingViewHeight / 2, -RollingViewHeight / 2);
        contentButton.layer.transform = trans;
    }else{
        CATransform3D trans = CATransform3DIdentity;
        trans = CATransform3DMakeRotation(0, 1, 0, 0);
        trans = CATransform3DTranslate(trans, 0, 0, - RollingViewHeight / 2);
        contentButton.layer.transform = trans;
    }
}

#pragma mark - 初始化中间View
- (UIButton *)getBackMiddleViewWithFrame:(CGRect)frame WithIndex:(NSInteger)index
{
    UIButton *middleView = [UIButton buttonWithType:UIButtonTypeCustom];
    middleView.adjustsImageWhenHighlighted = NO;
    middleView.tag = RollingBtnTag + index;
    [middleView addTarget:self action:@selector(titleButonAction:) forControlEvents:UIControlEventTouchUpInside];
    middleView.frame = frame;
    [self addSubview:middleView];
    [self.saveMiddleArray addObject:middleView];
    
    return middleView;
}

#pragma mark - 点击更多
- (void)rightMoreButtonClick
{
    !_moreClickBlock ? : _moreClickBlock();
}

- (void)titleButonAction:(UIButton *)sender
{
    NSInteger tag = sender.tag - RollingBtnTag;
    if ([self.delegate respondsToSelector:@selector(dc_RollingViewSelectWithActionAtIndex:)]) {
        [self.delegate dc_RollingViewSelectWithActionAtIndex:tag];
    }
}
#pragma mark - 取本地GIF图片
- (NSArray *)getGifImage:(NSString *)gifImageName{
    if (gifImageName.length <=0) {
        return @[];
    }
    NSURL *gifImageUrl = [[NSBundle mainBundle] URLForResource:gifImageName withExtension:@"gif"];
    //获取Gif图的原数据
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)gifImageUrl, NULL);
    //获取Gif图有多少帧
    size_t gifcount = CGImageSourceGetCount(gifSource);
    NSMutableArray* voiceImages = [NSMutableArray array];
    for (NSInteger i = 0; i < gifcount; i++) {
        
        //由数据源gifSource生成一张CGImageRef类型的图片
        
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        
        [voiceImages addObject:image];
        
        CGImageRelease(imageRef);
        
    }
    return voiceImages;
}
- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}
@end
