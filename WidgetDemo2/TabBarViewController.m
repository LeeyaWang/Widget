//
//  TabBarViewController.m
//  WidgetDemo
//
//  Created by wangliya on 2017/3/28.
//  Copyright © 2017年 wangliya. All rights reserved.
//

#import "TabBarViewController.h"
#import "SaoYiSaoViewController.h"
#import "NoteViewController.h"
#import "ContactViewController.h"
#import "ErWeiMaViewController.h"

static NSString *const kControllerKey    = @"rootVCClassString";
static NSString *const kTitleKey    = @"title";
static NSString *const kImageNameKey      = @"imageName";
static NSString *const kSelImageNameKey   = @"selectedImageName";

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINavigationController * saNav = [[UINavigationController alloc] initWithRootViewController:[SaoYiSaoViewController new]];
    UINavigationController * noteNav = [[UINavigationController alloc] initWithRootViewController:[NoteViewController new]];
    UINavigationController * contactNav = [[UINavigationController alloc] initWithRootViewController:[ContactViewController new]];
    UINavigationController * erNav = [[UINavigationController alloc] initWithRootViewController:[ErWeiMaViewController new]];
    
    NSArray * array = @[@{kControllerKey : saNav,
                          kTitleKey : @"扫一扫",
                          kImageNameKey : @"saoyisao",
                          kSelImageNameKey : @"saoyisao"},
                        @{kControllerKey : noteNav,
                          kTitleKey : @"记事本",
                          kImageNameKey : @"note",
                          kSelImageNameKey : @"note"},
                        @{kControllerKey : contactNav,
                          kTitleKey : @"通讯录",
                          kImageNameKey : @"contact",
                          kSelImageNameKey : @"contact"},
                        @{kControllerKey : erNav,
                          kTitleKey : @"二维码",
                          kImageNameKey : @"erweima",
                          kSelImageNameKey : @"erweima"}];
    [array enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL * _Nonnull stop) {
        UINavigationController * nav = [dic objectForKey:kControllerKey];
        nav.title = [dic objectForKey:kTitleKey];
        UITabBarItem * item = nav.tabBarItem;
        item.title = [dic objectForKey:kTitleKey];
        item.image = [UIImage imageNamed:[dic objectForKey:kImageNameKey]];
        item.selectedImage = [[UIImage imageNamed:[dic objectForKey:kSelImageNameKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithWhite:0.9 alpha:1]} forState:UIControlStateSelected];
        [self addChildViewController:nav];
    }];
    
    self.selectedIndex = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
