//
//  TextViewDemo.m
//  iOSProject
//
//  Created by mana on 2020/6/30.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "TextViewDemo.h"

@interface TextViewDemo ()<UITextViewDelegate>
{
    UITextView * textview;
}
@end

@implementation TextViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    NSString * string  = @"频道更新了视频";
    
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc] initWithString:string];

    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 2)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:UIColor.blueColor range:NSMakeRange(0, 2)];
    [attributeString addAttribute:NSLinkAttributeName value:@"user://" range:NSMakeRange(0, 2)];
    
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(2, string.length - 2)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:UIColor.brownColor range:NSMakeRange(2, string.length - 2)];
    
    textview = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, 100, 50)];
    textview.attributedText = attributeString;
    //文字顶部对齐添加如下方法：
    textview.textContainerInset = UIEdgeInsetsZero;
    textview.textContainer.lineFragmentPadding = 0;
    
    textview.linkTextAttributes = @{NSForegroundColorAttributeName:UIColor.redColor};
    textview.delegate = self;
    [self.view addSubview:textview];
}
#pragma mark - UITextViewDelegate ----核心代码
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"user"]) {
        NSLog(@"哈哈");
    }
    return YES;
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
