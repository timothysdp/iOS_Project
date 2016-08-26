//
//  AppView.h
//  AppM
//
//  Created by Birdy on 16/8/25.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import <UIKit/UIKit.h>

//设置AppInfo的属性
@class AppInfo;

//这里用代理的方式实现类与类的通信，完成点击事件
@protocol AppViewDelegate <NSObject>

@optional

-(void)downLoadClickWithButton:(UIButton *)button;

@end


@interface AppView : UIView
//声明一个快速创建的方法
@property (strong, nonatomic) AppInfo *appInfo;

+(instancetype)appView;
// 通过属性来设置代理对象
//声明appView的代理,此处的delegate不需要加星号，是id类型的
@property (weak, nonatomic) id<AppViewDelegate> delegate;


@end
