//
//  RecChannelCell.m
//  DookayProject
//
//  Created by mana on 2020/5/9.
//  Copyright © 2020 Dookay. All rights reserved.
//

#import "MenuTableCollectCell.h"
#import <objc/runtime.h>
#import <Masonry.h>
#import "UIView+Coordinate.h"
#import "MenuCollectionViewCell.h"

@implementation MenuTableCollectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    MenuTableCollectCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableCollectCell"];
    if (!cell) {
        cell = [[MenuTableCollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MenuTableCollectCell"];
//        cell.delegate = self;
        [cell setupUI];
    }
    return cell;
}
- (void)setupUI{

    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.backgroundColor = kLightGrayColor;
    CGFloat channelWidth = 100;
    CGFloat channelHeight = 54;
    //精彩频道
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.text = @"精彩频道";
    titleLabel.textColor = UIColor.darkGrayColor;
    titleLabel.frame = CGRectMake(17, 20, 100, 20);
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    //更多
//    UILabel * moreLabel = [[UILabel alloc]init];
//    moreLabel.text = @"更多";
//    moreLabel.textColor = UIColor.darkGrayColor;
//    moreLabel.font = [UIFont systemFontOfSize:13];
//    moreLabel.textAlignment = NSTextAlignmentRight;
//    moreLabel.userInteractionEnabled = YES;
//    [self.contentView addSubview:moreLabel];
//
//    [moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(@-23);
//        make.centerY.equalTo(titleLabel);
//    }];
//    UITapGestureRecognizer * moreTap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
//        NSString *url = [NSString stringWithFormat:@"%@/topichome",BASE_WEB_URL];//创建URL
//        UIViewController *topVC = [[VCManager shareVCManager] getTopViewController];
//        [DKJumpManager pushToWebVCWithNavgationVC:topVC.navigationController title:@"频道") loadUrl:url];
//    }];
//    moreTap.numberOfTapsRequired = 1;
//    moreTap.numberOfTouchesRequired = 1;
//    [moreLabel addGestureRecognizer:moreTap];
    //更多指示器
//    UIImageView * moreIndicatorImg = [[UIImageView alloc]init];
//    moreIndicatorImg.image = [UIImage imageNamed:@"more_small"];
//    [self.contentView addSubview:moreIndicatorImg];
//    [moreIndicatorImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(moreLabel.mas_right).with.offset(3);
//        make.size.mas_equalTo(CGSizeMake(6, 10));
//        make.centerY.equalTo(moreLabel);
//    }];
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout.itemSize = CGSizeMake(channelWidth, channelHeight);
    //设置scrollDirection = UICollectionViewScrollDirectionHorizontal后，collectionView高度大于ItemSize高度时，content会自动竖直方向居中
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.contentView addSubview:self.collectionView];
//    UIView * blankView = [[UIView alloc] init];
//    blankView.backgroundColor = UIColor.whiteColor;
//    [self.contentView addSubview:blankView];
//    [blankView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(15);
//    }];
}

- (void)reloadCell{
    [self.collectionView reloadData];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(didSelectRow:row:)]) {
        [self.delegate didSelectRow:self row:indexPath.row];
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count = 0;
    if ([self.delegate respondsToSelector:@selector(numberOfRowsCollectionViewCell:)]) {
        count = [self.delegate numberOfRowsCollectionViewCell:self];
    }
    return count;
}


/** section的margin*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 0, 10);
}
//行(横)间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20.0f;
}

//列(纵)间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    if (self.type == RecommandConfig) {
//        CGFloat space = 0;
////        if (self.communityData.count == 4) {
////            space = (kScreenWidth - 40 - SCREEN_RATIO(66)*4)/3;
////        }else{
////            space = (kScreenWidth - 10 - SCREEN_RATIO(66)*5)/4;
////        }
//        return space;
//    }
//    return 20.0f;
//}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MenuCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MenuCollectionViewCell" forIndexPath:indexPath];
//    cell.type = RecChannel;
//    cell.backgroundColor = kWhiteColor;
//    cell.layer.cornerRadius = 8.0f;
//    cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//    cell.layer.shadowOffset = CGSizeMake(0,1.0f);
//    cell.layer.shadowRadius = 3.0f;
//    cell.layer.shadowOpacity = 0.3f;
//    cell.layer.masksToBounds = NO;
//    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
//    cell.channelModel = self.itemsArray[indexPath.row];
//    [cell.follow addTarget:self action:@selector(followCommunityAction:) forControlEvents:UIControlEventTouchUpInside];
//    NSIndexPath * communityPath = [NSIndexPath indexPathForRow:indexPath.row inSection:1];
//    objc_setAssociatedObject(cell.follow, @"RecCommunityFollow", communityPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
//    cell.menuTitleLabel.text = self.model.filterTags[indexPath.row];
    NSString * text;
    if ([self.delegate respondsToSelector:@selector(collectionViewCell:titleForItemAtIndexPath:)]) {
        text = [self.delegate collectionViewCell:self titleForItemAtIndexPath:indexPath.row];
    }
    cell.menuTitleLabel.text = text;
    return cell;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectMake(125+10, 0, [UIScreen mainScreen].bounds.size.width-135,_layout.itemSize.height) collectionViewLayout:_layout];//self.layout.itemSize.height
        _collectionView.backgroundColor = [UIColor whiteColor];
//        _collectionView.layer.masksToBounds = YES;
//        _collectionView.backgroundColor = UIColor.blueColor;
        [_collectionView registerNib:[UINib nibWithNibName:@"MenuCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MenuCollectionViewCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}
//- (void)setItemsArray:(NSMutableArray *)itemsArray{
//    _itemsArray = itemsArray;
//}
//- (void)followCommunityAction:(UIButton *)sender{
//    if (!_CustomerInfo.isLogIn) {
//        [DKJumpManager presentLogInVC];
//        return;
//    }
//    NSIndexPath * index = objc_getAssociatedObject(sender, @"RecCommunityFollow");
//    FocusCommunityModel * model = _itemsArray[index.row];
//    if (model.isFollow) {
//        [self requestCancelFollow:[@(model.communityId) stringValue] index:index.row];
//    }else{
//        [self requestFollow:[@(model.communityId) stringValue] index:index.row];
//    }
//}
////关注
//- (void)requestFollow:(NSString *)domainId index:(NSInteger)index
//{
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    FocusCommunityModel * model = self.itemsArray[index];
//    [dic setValue:@(model.communityId) forKey:@"topicId"];
//
//    [[Interface instance] request:DKInterfaceRequestTypePost
//                          baseUrl:BASE_URL
//                        urlString:homeJoinCommunity
//                       parameters:dic
//                         finished:^(id responseObject, NSString *error) {
//                             if (error ||  responseObject == nil) {
//                                 [MBProgressHUD showInfoMessage:error.description];
//                                 return ;
//                             }
//        FocusCommunityModel * model = self.itemsArray[index];
//        model.isFollow = YES;
//        [self reloadCell];
//        [MBProgressHUD showSuccessMessage:@"关注成功"];
//    }];
//}
////取消关注
//- (void)requestCancelFollow:(NSString *)domainId index:(NSInteger)index
//{
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    FocusCommunityModel * model = self.itemsArray[index];
//    [dic setValue:@(model.communityId) forKey:@"topicId"];
//    [[Interface instance] request:DKInterfaceRequestTypePost
//                          baseUrl:BASE_URL
//                        urlString:homeLeaveCommunity
//                       parameters:dic
//                  finishedWithMsg:^(id responseObject, NSString *error) {
//                      if (responseObject == nil || error) {
//                          [MBProgressHUD showErrorMessage:error.description];
//                      }else{
//                          FocusCommunityModel * model = self.itemsArray[index];
//                          model.isFollow = NO;
//
//                          [self reloadCell];
//                          [MBProgressHUD showInfoMessage:responseObject[@"message"]];
//                      }
//                  }];
//}
@end
