//
//  PSCourseViewController.m
//  BaiDuChuanKe
//
//  Created by 思 彭 on 16/6/15.
//  Copyright © 2016年 combanc. All rights reserved.
//

#import "PSCourseViewController.h"
#import "NetworkSingleton.h"
#import "PSCourseCell.h"
#import "PSAlbumCell.h"
#import "PSFocusListModel.h"
#import "PSAlbumListModel.h"
#import "PSCourseListModel.h"
#import "PSImageScrollCell.h"
#import "PSSpeechViewController.h"


@interface PSCourseViewController ()<UITableViewDataSource,UITableViewDelegate,PSAlbumDelegate,ImageScrollViewDelegate>

{
    NSMutableArray *_focusListArray;/**< 第一个轮播数据 */
    NSMutableArray *_focusImgurlArray;/**< 第一个轮播图片URL数据 */
    NSMutableArray *_courseListArray;/**< 列表数据 */
    NSMutableArray *_albumListArray;/**< 第二个轮播数据 */
    NSMutableArray *_albumImgurlArray;/**< 第二个轮播图片URL数据 */
    
    NSInteger _type;/**< segment */
    
    NSMutableArray *_classCategoryArray;/**< 课程分类数组 */
    NSMutableArray *_iCategoryListArray;

}
@end

@implementation PSCourseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self setNav];
    [self initTableView];
    [self requestData];
}

/**
 *  初始化数据
 */
- (void)initData{
    
    _focusListArray = [[NSMutableArray alloc]init];
    _courseListArray = [[NSMutableArray alloc]init];
    _albumListArray = [[NSMutableArray alloc]init];
    _focusImgurlArray = [[NSMutableArray alloc]init];
    _albumImgurlArray = [[NSMutableArray alloc]init];
    _type = 0;
    // 读取plist文件
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"classCategory" ofType:@"plist"];
    _classCategoryArray = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    //课程类型
    NSString *iCategoryListPath = [[NSBundle mainBundle]pathForResource:@"iCategoryList" ofType:@"plist"];
    _iCategoryListArray = [[NSMutableArray alloc]initWithContentsOfFile:iCategoryListPath];
}


/**
 *  设置导航栏
 */
- (void)setNav{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 98)];
    backView.backgroundColor = navigationBarColor;
    [self.view addSubview:backView];
    //声明：原创所有，不要注释下面的UIButton
    UIButton *nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nameBtn.frame = CGRectMake(10, 20, 60, 40);
    nameBtn.font = [UIFont systemFontOfSize:15];
    [nameBtn setTitle:@"原创所有!!!" forState:UIControlStateNormal];
    [nameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nameBtn addTarget:self action:@selector(OnNameBtn) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:nameBtn];
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width/2-80, 20, 160, 30)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"百度传课";
    titleLabel.font = [UIFont systemFontOfSize:19];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:titleLabel];
    // segment
    NSArray *segmentArray = @[@"精选推荐",@"课程分类"];
    UISegmentedControl *segmentCtrl = [[UISegmentedControl alloc]initWithItems:segmentArray];
    segmentCtrl.frame = CGRectMake(36, 64, screen_width-36*2, 30);
    // 默认选择
    segmentCtrl.selectedSegmentIndex = 0;
    // 默认样式
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [segmentCtrl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    // 高亮样式
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [segmentCtrl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    segmentCtrl.tintColor = RGB(46, 158, 138);
    [segmentCtrl addTarget:self action:@selector(OnTapSegmentCtr:) forControlEvents:UIControlEventValueChanged];
    [backView addSubview:segmentCtrl];
}

#pragma mark - SegmentCtr被点击切换

- (void)OnTapSegmentCtr: (UISegmentedControl *)seg{
    
    NSInteger index = seg.selectedSegmentIndex;
    if (index == 0) {
        _type = 0;
    }
    else{
        _type = 1;
    }
    [self.tableView reloadData];
}


/**
 *  懒加载
 */

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 98, screen_width, screen_height-98-49) style: UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

/**
 *  初始化表视图
 */
- (void)initTableView{
    
    [self.view addSubview:self.tableView];
}

/**
 *  添加刷新
 */

- (void)setUpTableView{
    
    // 添加刷新的动画图片
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSInteger i = 1; i <= 60; i++) {
        UIImage *image = [UIImage imageNamed:@"icon_listheader_animation_1"];
        [idleImages addObject:image];
    }
    [self.tableView.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    //设置即将刷新的图片
    NSMutableArray  *refreshingImages = [NSMutableArray array];
    UIImage *image1 = [UIImage imageNamed:@"icon_listheader_animation_1"];
    [refreshingImages addObject:image1];
    UIImage *image2 = [UIImage imageNamed:@"icon_listheader_animation_2"];
    [refreshingImages addObject:image2];
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStatePulling];
    //设置正在刷新是的动画图片
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    
    //马上进入刷新状态
    [self.tableView.gifHeader beginRefreshing];

    
}


// 异步刷新加载数据
- (void)loadNewData{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        [self requestData];
    });
}


// 请求数据
- (void)requestData{
    __weak typeof(self) weakSelf = self;
    NSString *urlStr = @"http://pop.client.chuanke.com/?mod=recommend&act=mobile&client=2&limit=20";
    [[NetworkSingleton sharedManager]getRecommendCourseResult:nil url:urlStr successBlock:^(id responseBody) {
        NSLog(@"%@",responseBody);
        
        NSMutableArray *focusArray = [responseBody objectForKey:@"FocusList"];
        NSMutableArray *courseArray = [responseBody objectForKey:@"CourseList"];
        NSMutableArray *albumArray = [responseBody objectForKey:@"AlbumList"];
        // 清除数据
        [_focusListArray removeAllObjects];
        [_focusImgurlArray removeAllObjects];
        [_courseListArray removeAllObjects];
        [_albumListArray removeAllObjects];
        [_albumImgurlArray removeAllObjects];
        for (NSInteger i = 0; i < focusArray.count; i++) {
            PSFocusListModel *focusModel = [PSFocusListModel objectWithKeyValues:focusArray[i]];
            [_focusListArray addObject:focusModel];
            [_focusImgurlArray addObject:focusModel.PhotoURL];
        }
        for (NSInteger i = 0; i < courseArray.count; ++i) {
            PSCourseListModel *courseModel = [PSCourseListModel objectWithKeyValues:courseArray[i]];
            [_courseListArray addObject:courseModel];
        }
        for (NSInteger i = 0; i < albumArray.count; ++i) {
            PSAlbumListModel *jzAlbumM = [PSAlbumListModel objectWithKeyValues:albumArray[i]];
            [_albumListArray addObject:jzAlbumM];
            [_albumImgurlArray addObject:jzAlbumM.PhotoURL];
        }
        // 刷新表视图
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
 
    } failureBlock:^(NSString *error) {
        [SVProgressHUD showErrorWithStatus:error];
        [weakSelf.tableView.header endRefreshing];
    }];
}



// 导航栏左边按钮点击事件

- (void)OnNameBtn{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"关于作者`" message:@"纯属学习,欢迎大家一起学习!!!" delegate:self cancelButtonTitle:@"同意" otherButtonTitles: nil];
    [alertView show];
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_type == 0) {
        if (_courseListArray.count>0) {
            return _courseListArray.count+2;
        }else{
            return 0;
        }
    }else{
        return _classCategoryArray.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == 0) {
        if (indexPath.row == 0) {
            return 155;
        }else if (indexPath.row == 1){
            return 90;
        }else{
            return 72;
        }
    }else{
        return 60;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == 0) {
        if (indexPath.row == 0) {
            static NSString *const cellIndentifier = @"courseCell0";
            PSImageScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[PSImageScrollCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier frame:CGRectMake(0, 0, screen_width, 155)];
            }
            cell.imageScrollView.delegate = self;
            cell.imageArr = _focusImgurlArray;
            return cell;
        }else if (indexPath.row == 1){
            static NSString *const cellIndentifier = @"courseCell1";
            PSAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[PSAlbumCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier frame:CGRectMake(0, 0, screen_width, 90)];
                //下划线
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 89.5, screen_width, 0.5)];
                lineView.backgroundColor = separaterColor;
                [cell addSubview:lineView];
            }
            cell.delegate = self;
            cell.albumImageUrls = _albumImgurlArray;
            return cell;
        }else if (indexPath.row > 1){
            static NSString *cellIndentifier = @"courseCell2";
            PSCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[PSCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
                //            NSLog(@"%f/%f",cell.frame.size.width,cell.frame.size.height);
                //下划线
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 71.5, screen_width, 0.5)];
                lineView.backgroundColor = separaterColor;
                [cell addSubview:lineView];
            }
            
            PSCourseListModel *courseM = _courseListArray[indexPath.row-2];
            cell.model = courseM;
            
            return cell;
        }
        static NSString *cellIndentifier = @"courseCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        return cell;
    }else{
        static NSString *cellIndentifier = @"courseClassCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            //下划线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5, screen_width, 0.5)];
            lineView.backgroundColor = separaterColor;
            [cell addSubview:lineView];
            //图
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
            imageView.tag = 10;
            [cell addSubview:imageView];
            //标题
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, 100, 30)];
            titleLabel.tag = 11;
            [cell addSubview:titleLabel];
        }
        NSDictionary *dataDic = _classCategoryArray[indexPath.row];
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:10];
        NSString *imageStr = [dataDic objectForKey:@"image"];
        [imageView setImage:[UIImage imageNamed:imageStr]];
        UILabel *titleLabel = (UILabel *)[cell viewWithTag:11];
        titleLabel.text = [dataDic objectForKey:@"title"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

#pragma mark - ImageViewScrollViewDelegate

- (void)didSelectImageAtIndex:(NSInteger)index{
    
    
}

#pragma mark - AlbumDelegate

- (void)didSelectAlbumAtIndex:(NSInteger)index{
    if (index == 0) {
        NSURL *url = [NSURL URLWithString:@"openchuankekkiphone:"];
        BOOL isStalled = [[UIApplication sharedApplication]canOpenURL:url];
        if (isStalled) {
            
            // 直接打开
        }
        else{
            //土豆    https://appsto.re/cn/c8oMx.i
            //找教练  https://appsto.re/cn/kRb26.i
            //百度传课 https://appsto.re/cn/78XAL.i
            //                NSURL *url1 = [NSURL URLWithString:@"https://appsto.re/cn/c8oMx.i"];
            //                NSURL *url1 = [NSURL URLWithString:@"https://appsto.re/cn/kRb26.i"];

            NSURL *url1 = [NSURL URLWithString:@"https://appsto.re/cn/78XAL.i"];
            [[UIApplication sharedApplication]openURL:url];
            NSLog(@"没安装");
        }
    }
    else{
        PSSpeechViewController *speechVc = [[PSSpeechViewController alloc]init];
        [self.navigationController pushViewController:speechVc animated:YES];
    }
}
@end
