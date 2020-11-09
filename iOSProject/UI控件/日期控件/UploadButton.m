//
//  UploadButton.m
//  iOSProject
//
//  Created by mana on 2020/7/30.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "UploadButton.h"
@implementation UploadButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width*0.35,(frame.size.height-18)/2,18,18)];
        image.image = [UIImage imageNamed:@"ticked_normal"];//ticked_option
        [self addSubview:image];
        _leftImage = image;
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(image.bounds.size.width+image.frame.origin.x+12,0,90,frame.size.height);
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:17];
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        label.text = text;
        [self addSubview:label];
    }
    return self;
}
- (void)setSelectedState:(BOOL)selectedState{
    _selectedState = selectedState;
    if (selectedState) {
        _leftImage.image = [UIImage imageNamed:@"ticked_option"];
    }else{
        _leftImage.image = [UIImage imageNamed:@"ticked_normal"];
    }
}
@end
