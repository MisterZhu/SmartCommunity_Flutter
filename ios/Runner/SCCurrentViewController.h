//
//  SCCurrentViewController.h
//  SCBaseFramework
//
//  Created by MCDuff on 16/4/5.
//  Copyright © 2016年 LHP. All rights reserved.
/// 获取控制器

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SCCurrentViewController : NSObject

/**
 *  获取当前view所在的ViewController
 *
 *  @param view 当前View
 *
 *  @return ViewController
 */
+ (UIViewController *)currentViewController:(UIView *)view;

/**
 *  获取当前屏幕显示的ViewController
 *
 *  @return UIViewController
 */
+ (UIViewController *)currentViewController;


/**
 获取当前屏幕显示的ViewController(新的方法，之前的方法有风险，会导致崩溃)

 @return UIViewController
 */
+ (UIViewController *)presentViewController;

@end
