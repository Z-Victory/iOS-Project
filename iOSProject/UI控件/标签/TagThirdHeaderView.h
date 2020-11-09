//
//  LYHCollectionHeaderView.h
//  iOSProject
//
//  Created by mana on 2020/7/24.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TagThirdHeaderView : UICollectionReusableView
@property (nonatomic,weak) IBOutlet UILabel * titleLabel;
@property (nonatomic,assign) int count;
@end

NS_ASSUME_NONNULL_END
