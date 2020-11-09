//
//  MenuContentView.h
//  iOSProject
//
//  Created by mana on 2020/8/14.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTableView.h"
#import "MenuTableCollectView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuContentView : UIView
@property (nonatomic, strong) MenuTableView * tableView1;
@property (nonatomic, strong) MenuTableView * tableView2;
@property (nonatomic, strong) MenuTableCollectView * collectionView;
@end

NS_ASSUME_NONNULL_END
