//
//  PSImageScrollCell.h
//  BaiDuChuanKe
//
//  Created by 思 彭 on 16/6/20.
//  Copyright © 2016年 combanc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageScrollView.h"

@interface PSImageScrollCell : UITableViewCell

@property(nonatomic, strong) ImageScrollView *imageScrollView;
@property(nonatomic, strong) NSArray *imageArr;/**< 图片URL */

-(void)setImageArray:(NSArray *)imageArray;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame;

@end
