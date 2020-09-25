//
//  MenuViewController.h
//  iOSProject
//
//  Created by mana on 2020/8/12.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHFilterModel.h"
#import "MenuView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuViewController : UIViewController<MenuViewDelegate>

{
    UIView * headerView;
    
    MenuView * filterView;
}
@end

NS_ASSUME_NONNULL_END
