//
//  DateViewController.m
//  iOSProject
//
//  Created by mana on 2020/7/29.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "DateViewController.h"
#import "YHDatePickerView.h"
#import "UploadConditionView.h"
#import "YHPricePickerView.h"

@interface DateViewController ()
//@property (nonatomic,strong) UIView * dateView;
@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}
- (IBAction)show:(id)sender{
    YHDatePickerView * datePicker = [[YHDatePickerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [datePicker show];
}

- (IBAction)showCondition:(id)sender{
    UploadConditionView * datePicker = [[UploadConditionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [datePicker show];
}
- (IBAction)showPrice:(id)sender{
    YHPricePickerView * datePicker = [[YHPricePickerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [datePicker show];
}

@end
