//
//  PSAlbumListModel.h
//  BaiDuChuanKe
//
//  Created by 思 彭 on 16/6/20.
//  Copyright © 2016年 combanc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSAlbumListModel : NSObject

@property(nonatomic, strong) NSString *AlbumID;
@property(nonatomic, strong) NSString *Title;
@property(nonatomic, strong) NSString *PhotoURL;
@property(nonatomic, strong) NSString *Sort;
@property(nonatomic, strong) NSString *message;

@property(nonatomic, strong) NSString *IphoneType;
@property(nonatomic, strong) NSString *IpadType;


@end
