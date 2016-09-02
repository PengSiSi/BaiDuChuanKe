//
//  PSSpeechViewController.m
//  BaiDuChuanKe
//
//  Created by 思 彭 on 16/7/20.
//  Copyright © 2016年 combanc. All rights reserved.
//

#import "PSSpeechViewController.h"

@interface PSSpeechViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *textField;

@end

@implementation PSSpeechViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNav];
    [self initSubViews];
}

- (void)setNav{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor = navigationBarColor;
    [self.view addSubview:backView];
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"file_tital_back_but"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backBtn];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width/2-60, 20, 120, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"课程详情";
    [backView addSubview:titleLabel];
    
    //收藏
    UIButton *collectBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    collectBtn.frame = CGRectMake(screen_width-60, 20, 40, 40);
    //    [collectBtn setImage:[UIImage imageNamed:@"course_info_bg_collect"] forState:UIControlStateNormal];
    //    [collectBtn setImage:[UIImage imageNamed:@"course_info_bg_collected"] forState:UIControlStateSelected];
    [collectBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [collectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [collectBtn addTarget:self action:@selector(OnTapCollectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:collectBtn];

}

- (void)initSubViews{
    
    //搜索框
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 64+10, screen_width-60, 30)];
    self.textField.delegate = self;
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    self.textField.placeholder = @"请 “尝试语音输入课程“";
    self.textField.text = @"";
    self.textField.backgroundColor = RGB(242, 242, 242);
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textField];
    
    //语音按钮
    UIImageView *voiceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width-60, 64+6, 60, 36)];
    [voiceImageView setImage:[UIImage imageNamed:@"voice"]];
    [self.view addSubview:voiceImageView];
    UITapGestureRecognizer *voiceTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapVoice)];
    voiceImageView.userInteractionEnabled = YES;
    [voiceImageView addGestureRecognizer:voiceTap];
    

}

@end
