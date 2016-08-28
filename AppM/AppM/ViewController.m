//
//  ViewController.m
//  AppM
//
//  Created by Birdy on 16/8/25.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import "ViewController.h"
#import "AppInfo.h"
#import "AppView.h"



//进行宏定义
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kAppViewH [AppView appView].bounds.size.height
#define kAppViewW [AppView appView].bounds.size.width
//定义每一行有多少列
#define kTotalCol 3

@interface ViewController ()<AppViewDelegate>

//创建自定义视图数组
@property(strong,nonatomic)NSArray *appViews;

@end

@implementation ViewController

//懒加载
-(NSArray *)appViews{
    
    if (!_appViews) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"app.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        
        for (NSDictionary *dict in array) {
            AppInfo *appInfo = [AppInfo appInfoWithDict:dict];
//            这里是重点
            AppView *appView = [AppView appView];
            
            appView.appInfo = appInfo;
//            委托方的代理属性本质上就是代理对象自身
            appView.delegate = self;
            
            [arrayM addObject:appView];
        }
        
        _appViews = [arrayM copy];
    }
    
    return _appViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [UIScreen mainScreen].bounds.size.height;
    
    //计算视图间距
    CGFloat margin = (kScreenW-kTotalCol*kAppViewW)/(kTotalCol+1);
    //布局
    for (int i = 0; i<self.appViews.count; i++) {
        AppView *appView = self.appViews[i];
        
        int col = i % kTotalCol;
        int row = i / kTotalCol;
        
//        设置每个viewCenter的中心点位置
        CGFloat centerX = (margin + kAppViewW * 0.5) + (margin+ kAppViewW) * col;
//        计算中心点外的位置
        CGFloat centerY = (margin + kAppViewH * 0.5) + (margin+ kAppViewH) * row;
        
        appView.center = CGPointMake(centerX, centerY);
//        将自定义的视图添加到View上
        [self.view addSubview:appView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AppViewDelegate

-(void)downLoadClickWithButton:(UIButton *)button{
    
//通过强转，从button的父视图拿到
    AppView *appView = (AppView *)button.superview;
//    拿到应用的名字
    NSString *appName = appView.appInfo.name;
//    创建等待菊花
//    给主控制器的view加了一个遮挡
    UIActivityIndicatorView *juhua = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    juhua.frame = self.view.bounds;
    
//    juhua.hidesWhenStopped = YES;默认是YES的，可以不用写
    [juhua startAnimating];
    [self.view addSubview:juhua];
    
//    创建说明Label，添加在菊花上
    UILabel *downLoadLabel = [[UILabel alloc]init];
    downLoadLabel.frame = CGRectMake(0, kScreenH * 0.5+10, kScreenW, 20);
    
    downLoadLabel.textColor = [UIColor whiteColor];
    downLoadLabel.textAlignment = NSTextAlignmentCenter;
    downLoadLabel.text = [NSString stringWithFormat:@"%@正在下载。。。",appName];
//    设置字体大小
    downLoadLabel.font = [UIFont systemFontOfSize:15.0];
    downLoadLabel.backgroundColor = [UIColor blackColor];
    downLoadLabel.alpha = 0.5;
    
    [juhua addSubview:downLoadLabel];
    
//    使用gcd的方式显示效果
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        菊花停止转动并且自动隐藏
        [juhua stopAnimating];
        
//        下载完成提示
        UILabel *noteLabel = [[UILabel alloc]init];
        noteLabel.frame = CGRectMake(0, kScreenH * 0.5+20, kScreenW, 30);
        
        noteLabel.textColor = [UIColor whiteColor];
        noteLabel.textAlignment = NSTextAlignmentCenter;
        noteLabel.text = [NSString stringWithFormat:@"%@下载完成",appName];
        //    设置字体大小
        noteLabel.font = [UIFont systemFontOfSize:15.0];
        noteLabel.backgroundColor = [UIColor blackColor];
        noteLabel.alpha = 1;
        
        [self.view addSubview:noteLabel];

        [UIView animateWithDuration:2.0 animations:^{
//        执行动画
            noteLabel.alpha = 0;
        }completion:^(BOOL finished){
//            动画完成后要做的事情
            button.enabled = NO;
            [button setTitle:@"已下载" forState:UIControlStateDisabled];
            
            [noteLabel removeFromSuperview];
        }];
        
    });
}

@end
