//
//  PSAlbumCell.m
//  BaiDuChuanKe
//
//  Created by 思 彭 on 16/6/20.
//  Copyright © 2016年 combanc. All rights reserved.
//

#import "PSAlbumCell.h"

@interface PSAlbumCell ()

{
    UIScrollView *_scrollView;
    
}

@end

@implementation PSAlbumCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        // 创建scrollView
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 0, frame.size.width - 10, frame.size.height)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        // 添加图片
        for (NSInteger i = 0; i < 10; i++) {
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((screen_width*2/5+5)*i, 5, screen_width*2/5, frame.size.height)];
            imgView.layer.masksToBounds = YES;
            imgView.layer.cornerRadius = 5;
            imgView.tag = i + 100;
            // 图片上添加手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
            [imgView addGestureRecognizer:tap];
            //打开交互
            imgView.userInteractionEnabled = YES;
            [_scrollView addSubview:imgView];
        }
    }
    return self;
}

// 接收数据设置scrollview的尺寸

- (void)setAlbumImageUrls:(NSArray *)albumImageUrls{
    _albumImageUrls = albumImageUrls;
    _scrollView.contentSize = CGSizeMake((screen_width*2/5+5)*albumImageUrls.count+5, _scrollView.frame.size.height);
    for (NSInteger i = 0; i < albumImageUrls.count; i++) {
        UIImageView *imgView = (UIImageView *)[_scrollView viewWithTag:i + 100];
        [imgView sd_setImageWithURL:albumImageUrls[i] placeholderImage:[UIImage imageNamed:@"lesson_default"]];
    }
}

// 手势触发
- (void)tapImage: (UITapGestureRecognizer *)tap{
  
    // 取得手势下的图片
    UIImageView *imgVc = (UIImageView *)tap.view;
    NSInteger tag = imgVc.tag - 100;
    if ([self.delegate respondsToSelector:@selector(didSelectAlbumAtIndex:)]) {
        [self.delegate didSelectAlbumAtIndex:tag];
    }
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
