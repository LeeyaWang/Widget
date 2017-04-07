//
//  TodayViewController.m
//  WidgetExtension
//
//  Created by wangliya on 2017/3/30.
//  Copyright © 2017年 wangliya. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "Masonry.h"

@interface TodayViewController () <NCWidgetProviding>
@property (nonatomic,weak) UIView * messageView;              //消息通知
@property (nonatomic,weak) UIStackView * buttonContainer;     //隐藏button
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置widget视图的大小，最少110
    self.preferredContentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 110);
    [self setUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /*设置widget的展示模式:
     NCWidgetDisplayModeExpanded 展开
     NCWidgetDisplayModeCompact 隐藏
     */
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
}

-(void)setUI
{
    [self setUnreadMessage];
    [self setHiddenButton];
}

//消息推送通知
-(void)setUnreadMessage
{
    UIView * messageView = [[UIView alloc] init];
    [self.view addSubview:messageView];
    
    UILabel * titleLabel = [UILabel new];
    titleLabel.text = @"未读消息";
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [messageView addSubview:titleLabel];
    
    UIView * contentView = [UIView new];
    contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    [messageView addSubview:contentView];
    
    UIImageView * headImageview = [UIImageView new];
    headImageview.image = [UIImage imageNamed:@"iOS_icon_108x108"];
    [contentView addSubview:headImageview];
    
    UILabel * messageLabel = [UILabel new];
    messageLabel.text = @"重大消息，皮皮虾跟亚姐走啦！";
    messageLabel.font = [UIFont systemFontOfSize:12];
    messageLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1];
    messageLabel.textAlignment = NSTextAlignmentLeft;
    [contentView addSubview:messageLabel];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [contentView addGestureRecognizer:tap];
    
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self.view);
        make.height.mas_equalTo(110);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(messageView).offset(10);
        make.top.equalTo(messageView).offset(5);
        make.right.equalTo(messageView).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_left);
        make.top.equalTo(titleLabel.mas_bottom);
        make.right.equalTo(titleLabel.mas_right);
        make.height.mas_equalTo(60);
    }];
    
    [headImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.left.equalTo(contentView);
        make.width.height.mas_equalTo(40);
        make.centerY.equalTo(contentView);
    }];
    
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(headImageview.mas_trailing).offset(10);
        make.trailing.equalTo(contentView);
        make.centerY.equalTo(headImageview);
        //        make.left.equalTo(headImageview.mas_right).offset(5);
        //        make.right.equalTo(contentView.mas_right).offset(-10);
        make.height.mas_equalTo(contentView.mas_height);
    }];
    
    self.messageView = messageView;
}

//隐藏button
-(void)setHiddenButton
{
    UIStackView * buttonContainer = [UIStackView new];
    buttonContainer.distribution = UIStackViewDistributionFillEqually;
    [self.view addSubview:buttonContainer];
    
    [buttonContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_messageView.mas_bottom).offset(5);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(90);
    }];
    
    UIButton * button1 = [self creatButtonWithTitle:@"扫一扫" buttonImage:@"saoyisao"];
    button1.tag = 101;
    [buttonContainer addArrangedSubview:button1];
    
    UIButton * button2 = [self creatButtonWithTitle:@"记事本" buttonImage:@"note"];
    button2.tag = 102;
    [buttonContainer addArrangedSubview:button2];
    
    UIButton * button3 = [self creatButtonWithTitle:@"通讯录" buttonImage:@"contact"];
    button3.tag = 103;
    [buttonContainer addArrangedSubview:button3];
    
    UIButton * button4 = [self creatButtonWithTitle:@"二维码" buttonImage:@"erweima"];
    button4.tag = 104;
    [buttonContainer addArrangedSubview:button4];
    self.buttonContainer = buttonContainer;
    
}

-(UIButton *)creatButtonWithTitle:(NSString *)title buttonImage:(NSString *)imageName
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat space = 45;
    CGSize titleSize = button.titleLabel.intrinsicContentSize;
    CGSize imgViewSize = button.imageView.frame.size;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -imgViewSize.width - 33, -imgViewSize.height-space/2.0, 0);
    button.imageEdgeInsets = UIEdgeInsetsMake(-titleSize.height - space/2.0, 0, 0, -titleSize.width);
    return button;
}


//点击事件
-(void)tapClick
{
    [self.extensionContext openURL:[NSURL URLWithString:@"WidgetDemo://action=message"] completionHandler:^(BOOL success) {
        
    }];
}

-(void)buttonClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 101:
            [self.extensionContext openURL:[NSURL URLWithString:@"WidgetDemo://action=saoyisao"] completionHandler:^(BOOL success) {
                
            }];
            break;
        case 102:
            [self.extensionContext openURL:[NSURL URLWithString:@"WidgetDemo://action=note"] completionHandler:^(BOOL success) {
                
            }];
            break;
        case 103:
            [self.extensionContext openURL:[NSURL URLWithString:@"WidgetDemo://action=contact"] completionHandler:^(BOOL success) {
                
            }];
            break;
        case 104:
            [self.extensionContext openURL:[NSURL URLWithString:@"WidgetDemo://action=erweima"] completionHandler:^(BOOL success) {
                
            }];
            break;
        default:
            break;
    }
}

//隐藏展开模式改变是调用此方法
-(void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
{
    if(activeDisplayMode == NCWidgetDisplayModeCompact)
    {
        self.preferredContentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 110);
    }
    else
    {
        self.preferredContentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 210);
    }
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //
    //    });
}

-(UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
