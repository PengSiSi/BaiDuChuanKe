//
//  AppDelegate.m
//  BaiDuChuanKe
//
//  Created by 思 彭 on 16/6/15.
//  Copyright © 2016年 combanc. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "PSCourseViewController.h"
#import "PSDownLoadViewController.h"
#import "PSMIneViewController.h"
#import "Public.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 创建窗口
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    [self initRootVc];
    return YES;
    
}


- (void)initRootVc{
    
    // 创建控制器
    
    PSCourseViewController *courseVc = [[PSCourseViewController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:courseVc];
    PSMIneViewController *mineVc = [[PSMIneViewController alloc]init];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:mineVc];
    PSDownLoadViewController *downLoadVc = [[PSDownLoadViewController alloc]init];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:downLoadVc];
    
    //设置导航栏标题
    courseVc.title = @"课程推荐";
    mineVc.title = @"我的传课";
    downLoadVc.title = @"离线下载";
    
    NSArray *viewCtrls = @[nav1,nav2,nav3];
    self.rootTabBarVc = [[UITabBarController alloc]init];
    self.rootTabBarVc.viewControllers = viewCtrls;
    
    // 窗口的根控制器
    self.window.rootViewController = self.rootTabBarVc;

    // 设置Tabbar的属性
    UITabBar *tabbar = self.rootTabBarVc.tabBar;
    UITabBarItem *item0 = [tabbar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabbar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabbar.items objectAtIndex:2];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeTextColor: selectColor} forState:UIControlStateNormal];

    // 设置图片
    item0.selectedImage = [[UIImage imageNamed:@"bottom_tab1_pre"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.image = [[UIImage imageNamed:@"bottom_tab1_unpre"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.selectedImage = [[UIImage imageNamed:@"bottom_tab2_pre"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image = [[UIImage imageNamed:@"bottom_tab2_unpre"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item2.selectedImage = [[UIImage imageNamed:@"bottom_tab3_pre"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"bottom_tab3_unpre"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 修改字体颜色
    [[UITabBarItem appearance]setTitleTextAttributes:@{UITextAttributeFont: navigationBarColor} forState:UIControlStateSelected];
    
}

// 禁止横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    
    if (self.isFullScreen) {
        return UIInterfaceOrientationMaskAll;
        return UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskPortrait;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
