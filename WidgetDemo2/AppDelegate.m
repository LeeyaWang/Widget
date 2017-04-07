//
//  AppDelegate.m
//  WidgetDemo2
//
//  Created by wangliya on 2017/3/30.
//  Copyright © 2017年 wangliya. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "MessageViewController.h"

@interface AppDelegate ()
@property (nonatomic,strong) TabBarViewController * tabBarController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _tabBarController = [TabBarViewController new];
    self.window.rootViewController = _tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
    
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    NSString * prefix = @"WidgetDemo://action=";
    NSString * urlString = [url absoluteString];
    if([urlString rangeOfString:prefix].location != NSNotFound)
    {
        NSString * action = [urlString substringFromIndex:prefix.length];
        if([action isEqualToString:@"saoyisao"])
        {
            _tabBarController.selectedIndex = 0;
        }
        else if ([action isEqualToString:@"note"])
        {
            _tabBarController.selectedIndex = 1;
        }
        else if ([action isEqualToString:@"contact"])
        {
            _tabBarController.selectedIndex = 2;
        }
        else if ([action isEqualToString:@"erweima"])
        {
            _tabBarController.selectedIndex = 3;
        }
        else if ([action isEqualToString:@"message"])
        {
            UIViewController * vc = _tabBarController.viewControllers[0];
            [vc.navigationController pushViewController:[MessageViewController new] animated:NO];
        }
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
