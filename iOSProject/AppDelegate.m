//
//  AppDelegate.m
//  iOSProject
//
//  Created by 刘亚和 on 2020/5/30.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ADLaunchView.h"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.backgroundColor = UIColor.whiteColor;
    ViewController * vc = [[ViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    [self ad_pic_show];
    return YES;
}
- (void)ad_pic_show {
//    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //字符串拼接得到文件完整路径
//    NSString *ad_pic_name = @"/adPic.jpg";
//    NSString *ad_pic_path = [documentsDirectoryPath stringByAppendingString:ad_pic_name];
//    NSLog(@"完整路径是:%@",ad_pic_path);
    
//    NSData *ad_pic_data = [NSData dataWithContentsOfFile:ad_pic_path];
//    if (ad_pic_data){
//        UIImage *ad_pic_image = [UIImage imageWithData:ad_pic_data];
//        NSDate *endTime = [[NSUserDefaults standardUserDefaults] objectForKey:AD_PICS_ENDTIME];
    UIImage *ad_pic_image = [UIImage imageNamed:@"开屏_iPhone X"];
        NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:10];
        NSDate *nowTime = [NSDate date];
        
        if ([endTime isEqualToDate:[endTime laterDate:nowTime]] && ad_pic_image){
            [ADLaunchView showAdView:ad_pic_image];
        }
//    }
}
@end
