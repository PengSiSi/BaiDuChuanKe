//
//  PSAlbumCell.h
//  BaiDuChuanKe
//
//  Created by 思 彭 on 16/6/20.
//  Copyright © 2016年 combanc. All rights reserved.
//

#import <UIKit/UIKit.h>

// 选中图片协议
@protocol PSAlbumDelegate <NSObject>

@optional

- (void)didSelectAlbumAtIndex: (NSInteger)index;

@end

@interface PSAlbumCell : UITableViewCell

@property (nonatomic , strong) NSArray *albumImageUrls;

@property (nonatomic, assign) id<PSAlbumDelegate> delegate;

// 初始化方法

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame;

@end
