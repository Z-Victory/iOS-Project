//
//  StackViewDemo.m
//  iOSProject
//
//  Created by mana on 2020/7/22.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "StackViewDemo.h"

@interface StackViewDemo ()
@end

@implementation StackViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStackView * stackView = [[UIStackView alloc] initWithFrame:self.view.bounds];
    stackView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    stackView.spacing = 10.0;//子视图的间距
    /*
     UIStackViewAlignmentFill,//!< 子视图填充
     UIStackViewAlignmentLeading,//!< 竖直排列时，子视图左对齐
     UIStackViewAlignmentTop = UIStackViewAlignmentLeading,//!< 水平排列时，子视图上对齐
     UIStackViewAlignmentFirstBaseline, // Valid for horizontal axis only //!< 水平排列时，子视图按照首个子视图的首行文字对齐
     UIStackViewAlignmentCenter,//!< 居中对齐
     UIStackViewAlignmentTrailing,//!< 竖直排列时，子视图右对齐
     UIStackViewAlignmentBottom = UIStackViewAlignmentTrailing,//!< 水平排列时，子视图下对齐
     UIStackViewAlignmentLastBaseline, // Valid for horizontal axis only //!< 水平排列时，子视图按照最后一个子视图的末行文字对齐
     */
    stackView.alignment = UIStackViewAlignmentFill;//子视图的对齐方式
    
    
    /*
     UILayoutConstraintAxisHorizontal = 0,
     UILayoutConstraintAxisVertical = 1
     */
    stackView.axis = UILayoutConstraintAxisVertical;//排列方式 横向还纵向
    
    
    /*
     UIStackViewDistributionFill = 0, //!< 子视图填充，多个视图时以最后一个视图填充
     UIStackViewDistributionFillEqually,//!< 子视图等宽或等高填充
     UIStackViewDistributionFillProportionally,//!< 子视图按比例填充]
     UIStackViewDistributionEqualSpacing,//!< 子视图等间距填充
     UIStackViewDistributionEqualCentering,//!< 子视图等中点填充
     */
    stackView.distribution = UIStackViewDistributionFillEqually;//子视图的宽度或高度布局
    
    
    stackView.backgroundColor = UIColor.whiteColor;
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectZero];
    label1.backgroundColor = [UIColor.redColor colorWithAlphaComponent:0.6];
    label1.text = @"我就简单测试下";
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectZero];
    label2.backgroundColor = [UIColor.blueColor colorWithAlphaComponent:0.6];
    label2.text = @"你是谁";
    UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectZero];
    label3.backgroundColor = [UIColor.greenColor colorWithAlphaComponent:0.6];
    label3.text = @"钟无艳";
    UILabel * label4 = [[UILabel alloc] initWithFrame:CGRectZero];
    label4.backgroundColor = [UIColor.purpleColor colorWithAlphaComponent:0.6];
    label4.text = @"高渐离";
    
    [stackView addArrangedSubview:label1];
    [stackView addArrangedSubview:label2];
    [stackView addArrangedSubview:label3];
    [stackView addArrangedSubview:label4];
    
    
    
    [self.view addSubview:stackView];
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
