//
//  YHDatePickerView.m
//  iOSProject
//
//  Created by mana on 2020/7/30.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "UploadConditionView.h"
#import "UploadButton.h"
@interface UploadConditionView()
@property (nonatomic,strong) UploadButton * button1;
@property (nonatomic,strong) UploadButton * button2;
@end
@implementation UploadConditionView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView * dateView = [[UIView alloc] initWithFrame:self.frame];//CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        dateView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
        [self addSubview:dateView];
        
        //工具栏
        UIView * dateToolView = [[UIView alloc] initWithFrame:CGRectMake(0, dateView.frame.size.height - 271, dateView.frame.size.width, 60)];
        dateToolView.backgroundColor = UIColor.whiteColor;
        [dateView addSubview:dateToolView];
        
        UIButton * cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 78, dateToolView.frame.size.height)];
        cancleBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC" size: 16];
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
        [dateToolView addSubview:cancleBtn];
        [cancleBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel * dateTittle = [[UILabel alloc] initWithFrame:CGRectMake((dateToolView.frame.size.width - 68)/2, 0, 68, dateToolView.frame.size.height)];
        dateTittle.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
        dateTittle.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        dateTittle.text = @"展示条件";
        [dateToolView addSubview:dateTittle];
        
        UIButton * okBtn = [[UIButton alloc] initWithFrame:CGRectMake(dateToolView.frame.size.width - 78, 0, 78, dateToolView.frame.size.height)];
        okBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC" size: 16];
        [okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [okBtn setTitleColor:[UIColor colorWithRed:54/255.0 green:100/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
        [dateToolView addSubview:okBtn];
        [okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 59, dateToolView.bounds.size.width, 1)];
        line.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1];
        [dateToolView addSubview:line];
        
        //选项
        UIView *pickView = [[UIView alloc]initWithFrame:CGRectMake(0, dateView.frame.size.height-211, dateView.frame.size.width, 211)];
        pickView.backgroundColor = UIColor.whiteColor;
        [self addSubview:pickView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((pickView.bounds.size.width - 40)/2,16,40,14)];
        label.font = [UIFont systemFontOfSize:12];//[UIFont fontWithName:@"PingFangSC" size:12];
        label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        label.text = @"可多选";
        label.textAlignment = NSTextAlignmentCenter;
        [pickView addSubview:label];
        
        UploadButton *button = [[UploadButton alloc] initWithFrame:CGRectMake(0, 36, frame.size.width, 55) text:@"适用于室内"];
        [button addTarget:self action:@selector(selectCondition:) forControlEvents:UIControlEventTouchDown];
        [pickView addSubview:button];
        _button1 = button;
        
        UploadButton * button2 = [[UploadButton alloc] initWithFrame:CGRectMake(0, 91, frame.size.width, 55) text:@"适用于室外"];
        [button2 addTarget:self action:@selector(selectCondition:) forControlEvents:UIControlEventTouchDown];
        [pickView addSubview:button2];
        _button2 = button;
        
    }
    return self;
}
- (void)selectCondition:(UploadButton *)sender{
    if (sender.selectedState) {
        sender.selectedState = NO;
    }else{
        sender.selectedState = YES;
    }
}

/** 弹出此弹窗 */
- (void)show {
    // 出场动画
//    self.alpha = 0;
//    self.contentView.transform = CGAffineTransformScale(self.contentView.transform, 1.3, 1.3);
//    [UIView animateWithDuration:0.2 animations:^{
//        self.alpha = 1;
//        self.contentView.transform = CGAffineTransformIdentity;
//    }];
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
}
- (void)cancel{
    [self removeFromSuperview];
}
- (void)okAction{
    int state = 0;
    if (_button1.selectedState) {
        state = 1;
    }
    
    if (_button2.selectedState && !_button1.selectedState) {
        state = 2;
    }
    if (_button2.selectedState && _button1.selectedState) {
        state = 3;
    }
    
    if (self.block) {
        self.block(state);
    }
    [self removeFromSuperview];
}
- (void)dealloc{
    NSLog(@"日期选择已经销毁");
}
@end
