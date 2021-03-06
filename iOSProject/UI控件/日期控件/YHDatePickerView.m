//
//  YHDatePickerView.m
//  iOSProject
//
//  Created by mana on 2020/7/30.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "YHDatePickerView.h"
@interface YHDatePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>


@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) NSMutableArray * dataArray1;
@property (nonatomic,strong) NSMutableArray * dataArray2;
@end
@implementation YHDatePickerView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        _dataArray1 = [NSMutableArray array];
        _dataArray2 = [NSMutableArray array];
        //中英文
        _dataArray1 = [NSMutableArray arrayWithObjects:@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月", nil];
//        _dataArray1 = [NSMutableArray arrayWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];
        [_dataArray1 insertObject:@"不选择月份" atIndex:0];
        for (int i = 2020; i>2000; i--) {
            //中英文判断
            NSString * string;
            if (YES) {
                string = [NSString stringWithFormat:@"%i月",i];
            }else{
                string = [@(i) stringValue];
            }
            
            [_dataArray2 addObject:string];
        }
        _dataArray = [NSMutableArray array];
        [_dataArray addObject:_dataArray2];
        [_dataArray addObject:_dataArray1];
        
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
        dateTittle.text = @"创作时间";
        [dateToolView addSubview:dateTittle];
        
        UIButton * okBtn = [[UIButton alloc] initWithFrame:CGRectMake(dateToolView.frame.size.width - 78, 0, 78, dateToolView.frame.size.height)];
        okBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC" size: 16];
        [okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [okBtn setTitleColor:[UIColor colorWithRed:54/255.0 green:100/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
        [dateToolView addSubview:okBtn];
        [okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        
        // pickView初始化并设置其大小，如果不设置其大小，默认大小为 320 * 216。
        UIPickerView *pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, dateView.frame.size.height-211, dateView.frame.size.width, 211)];
        pickView.delegate = self;
        pickView.dataSource = self;
        
        // 显示选中指示器，有一个透明的覆盖在选中航，默认是NO，iOS7 之后总是显示选中指示器，设置这个属性没有影响。
    //    pickView.showsSelectionIndicator = YES;
        
        //在iOS 7之后可以自定义选择器视图的背景颜色改变其backgroundColor
        pickView.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
        
        //设置pickVIew的透明度
//        pickView.alpha = 0.7;
        
        [self addSubview:pickView];
    }
    return self;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return _dataArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray * array = self.dataArray[component];
    return array.count;
}
#pragma mark - UIPickerViewDelegate
// 反回pickerView的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component == 0) {
        return 100;
    }
    return 129;
}

// 返回pickerView的高度
//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
//
//}
  
// 返回pickerView 每行的内容
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray * array = self.dataArray[component];

    NSString * string = array[row];
    return string;
}

//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//
//}

// 返回pickerView 每行的view
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
//    NSArray * array = self.dataArray[component];
//
//    NSString * string = array[row];
//
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 0.0f, [pickerView rowSizeForComponent:component].width-12, [pickerView rowSizeForComponent:component].height)];
//
//    [label setText:string];
//    label.backgroundColor = [UIColor clearColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    return label;
//}

// 选中行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
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
    [self removeFromSuperview];
}
- (void)dealloc{
    NSLog(@"日期选择已经销毁");
}
@end
