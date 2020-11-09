//
//  RequestDemoController.m
//  iOSProject
//
//  Created by mana on 2020/10/15.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "RequestDemoController.h"
#import <AFNetworking.h>

@interface RequestDemoController ()

@end

@implementation RequestDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self request];
}
- (void)request{
    
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setValue:@"a" forKey:@"keyword"];
//    [param setValue:[NSNumber numberWithInteger:0] forKey:@"type"];
//    [param setValue:[NSNumber numberWithInteger:1] forKey:@"pageIndex"];
//    [param setValue:[NSNumber numberWithInteger:10] forKey:@"pageSize"];
    [param setValue:@"0" forKey:@"type"];
    [param setValue:@"1" forKey:@"pageIndex"];
    [param setValue:@"10" forKey:@"pageSize"];
    //配置AF
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    [manage.requestSerializer setValue:@"application/form-data" forHTTPHeaderField:@"Content-Type"];
    manage.requestSerializer = [AFHTTPRequestSerializer serializer];
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    NSString * rul = [NSString stringWithFormat:@"%@%@",@"http://dev-front-cn.manamana.net:8000/api",@"/mobile/2.0/search/list/video"];
    
    [manage GET:rul parameters:param headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDic = (NSDictionary *)responseObject;
            NSLog(@"%@",resultDic);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    
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
