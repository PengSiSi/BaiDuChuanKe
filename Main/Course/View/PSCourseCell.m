//
//  PSCourseCell.m
//  BaiDuChuanKe
//
//  Created by 思 彭 on 16/6/20.
//  Copyright © 2016年 combanc. All rights reserved.
//

#import "PSCourseCell.h"
#import "UIImageView+WebCache.h"


@interface PSCourseCell ()

{
    UIImageView *_imageView;/**< 图 */
    UILabel *_titleLabel;/**< 大标题 */
    UILabel *_subtitleLabel;/**< 小标题 */
}


@end
@implementation PSCourseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 子类化子视图
        [self initViews];
    }
    return self;
}

-(void)initViews{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 52)];
    [self addSubview:_imageView];
    //
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, screen_width-100, 30)];
    [self addSubview:_titleLabel];
    //
    _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, screen_width-100, 40)];
    _subtitleLabel.font = [UIFont systemFontOfSize:13];
    _subtitleLabel.textColor = [UIColor lightGrayColor];
    _subtitleLabel.numberOfLines = 2;
    [self addSubview:_subtitleLabel];
}

- (void)setModel:(PSCourseListModel *)model{
    _model = model;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.PhotoURL] placeholderImage:[UIImage imageNamed:@"lesson_default"]];
    _titleLabel.text = model.CourseName;
    _subtitleLabel.text = model.Brief;

}

@end
