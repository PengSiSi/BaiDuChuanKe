//
//  PSImageScrollCell.m
//  BaiDuChuanKe
//
//  Created by 思 彭 on 16/6/20.
//  Copyright © 2016年 combanc. All rights reserved.
//

#import "PSImageScrollCell.h"

@implementation PSImageScrollCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageScrollView = [[ImageScrollView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 180) ImageArray:self.imageArr];
        [self.contentView addSubview:self.imageScrollView];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageScrollView = [[ImageScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) ImageArray:self.imageArr];
        [self.contentView addSubview:self.imageScrollView];
    }
    return self;
}

- (void)setImageArr:(NSArray *)imageArr{
    
    _imageArr = imageArr;
    [self.imageScrollView setImageArray:imageArr];
}

- (void)setImageArray:(NSArray *)imageArray{
    [self.imageScrollView setImageArray:imageArray];
}
@end
