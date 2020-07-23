//
//  SearchHistoryManager.m
//  LearnDatabase
//
//  Created by mana on 2020/4/8.
//  Copyright © 2020 Loying. All rights reserved.
//

#import "SearchHistoryManager.h"
#import <FMDB.h>
static NSUInteger SEARCHMAXCOUNT = 10;
static SearchHistoryManager * historyManager = nil;

@interface SearchHistoryManager ()

@property (nonatomic, strong) FMDatabase *db;
//路径
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) FMDatabaseQueue *sqlQueue;

@end

@implementation SearchHistoryManager

+ (instancetype)shareHistory{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        historyManager = [[SearchHistoryManager alloc] init];
        [historyManager createQueue];
    });
    return historyManager;
}
#pragma mark - 创建路径
- (void)createQueue{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"mana_searchHistory.sqlite"];
    NSLog(@"%@", path);
    _sqlQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    if (_sqlQueue) {
        //创建成功
        [self.sqlQueue inDatabase:^(FMDatabase * _Nonnull db) {
            _db = db;
//            [db open];
            
        }];
        [self createTable];
    }else{
        //创建失败
    }
}

//创建表
- (void)createTable{
//    NSString *createSqlStr = @"create table if not exists SearchHistoryTags_table(searchText text not null)";
//    [self.db executeUpdate:createSqlStr];
    [_sqlQueue inDatabase:^(FMDatabase * _Nonnull db) {
        _db = db;
        NSString *createSqlStr = @"create table if not exists SearchHistoryTags_table(id integer PRIMARY KEY AUTOINCREMENT,searchText text NOT NULL,searchTime text NOT NULL)";
        if ([db open]) {
            BOOL isOK = [db executeStatements:createSqlStr];
            NSLog(@"创建表%@",isOK?@"成功":@"失败");
        }
        [db close];
    }];
}

//插入
- (void)insert:(NSString *)string{
    [_sqlQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
        //检测某个数据是否存在
        FMResultSet *rs =[db executeQuery:@"SELECT COUNT(searchText) AS countNum FROM SearchHistoryTags_table WHERE searchText = ?",string];
            if ([rs next]) {
                NSInteger count = [rs intForColumn:@"countNum"];
                if (count > 0) {
                    //已存在 将这条记录提到最前面
                    NSLog(@"已存在");
                    
                    NSString * updateTimeSql = [NSString stringWithFormat:@"UPDATE SearchHistoryTags_table SET searchTime = '%@' WHERE searchText = '%@'",[self getCurrentTimestamp],string];
                    BOOL isUpdateOK = [db executeUpdate:updateTimeSql];
                    if (isUpdateOK) {
                        NSLog(@"更新成功");
                    }else{
                        NSLog(@"更新失败");
                    }
                }else{
                    // 先查询表中行数的总个数
                    NSUInteger count = [db intForQuery:@"select count(*) from SearchHistoryTags_table"];
                    // 即将超过10条 删除最早数据
                    if (count >= SEARCHMAXCOUNT) {
                        NSMutableArray * array = [NSMutableArray array];
                        NSString *selectSqlStr = @"select * FROM SearchHistoryTags_table ORDER BY searchTime";
                        FMResultSet *result = [db executeQuery:selectSqlStr];
                        while ([result next]) {
                            //查询到结果
                            int value_id = [result intForColumn:@"id"];
                            NSString *value_name = [result stringForColumn:@"searchText"];
                            NSString *time = [result stringForColumn:@"searchTime"];
                            NSLog(@"id:%d, searchText:%@ searchTime:%@", value_id, value_name, time);
                            [array addObject:value_name];
                        }
                        NSString * firstHistory = array.firstObject;
                        //删除最早数据
                        NSString * deleteSqlStr = [NSString stringWithFormat:@"DELETE FROM SearchHistoryTags_table WHERE searchText = '%@'",firstHistory];
                        BOOL isDeleteOK = [db executeUpdate:deleteSqlStr];
                        if (isDeleteOK) {
                            NSLog(@"删除成功");
                        }else{
                            NSLog(@"删除失败");
                        }
                    }else{
                        
                    }
                    //插入
                    NSString * insertSqlStr = [NSString stringWithFormat:@"INSERT INTO SearchHistoryTags_table(searchText,searchTime) VALUES('%@','%@');",string,[self getCurrentTimestamp]];
                    BOOL isOK = [db executeUpdate:insertSqlStr];
                    if (isOK) {
                        NSLog(@"插入成功");
                    }else{
                        NSLog(@"插入失败");
                    }
                }
            }
        }
        
        
        [db close];
    }];
}

//获取全部历史
- (NSArray *)getHistory{
    NSMutableArray * array = [NSMutableArray array];
    [_sqlQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            NSString *selectSqlStr = @"select * FROM SearchHistoryTags_table ORDER BY searchTime";
            FMResultSet *result = [db executeQuery:selectSqlStr];
            while ([result next]) {
                //查询到结果
                int value_id = [result intForColumn:@"id"];
                NSString *value_name = [result stringForColumn:@"searchText"];
                NSString *time = [result stringForColumn:@"searchTime"];
                NSLog(@"id:%d, searchText:%@ searchTime:%@", value_id, value_name, time);
                [array addObject:value_name];
            }
            [result close];
        }
        [db close];
    }];
    
    return array;
}
//清空
- (void)cleanHistory{
    [_sqlQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            NSString * insertSqlStr = @"DELETE FROM SearchHistoryTags_table";
            BOOL isOK = [db executeStatements:insertSqlStr];
            if (isOK) {
                NSLog(@"删除成功");
            }else{
                NSLog(@"删除失败");
            }
        }
        [db close];
    }];
//    NSString * insertSqlStr = @"DELETE * FROM SearchHistoryTags_table";
//    [self.db executeUpdate:insertSqlStr];
}
// 获取当前时间戳
- (NSString *)getCurrentTimestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0]; // 获取当前时间0秒后的时间
    NSTimeInterval time = [date timeIntervalSince1970]*1000;// *1000 是精确到毫秒(13位),不乘就是精确到秒(10位)
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}
@end
