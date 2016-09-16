//
//  ViewController.m
//  PictureAutoShow
//
//  Created by Birdy on 16/9/1.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import "ViewController.h"
#define  kScreenHeight [UIScreen mainScreen].bounds.size.height
#define  kScreenWidth [UIScreen mainScreen].bounds.size.width
CGFloat kImageCount = 10;
CGFloat scrollY = 20;
CGFloat pageCtrlWidth = 200;

@interface ViewController ()<UIScrollViewDelegate>

@property(strong,nonatomic)UIScrollView *scrollView;
@property(strong,nonatomic)UIPageControl *pageCtrl;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initScrollView];
    [self initPageContrl];
    [self addTimer];
}
//创建UIScrollView
-(void)initScrollView{
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, scrollY, kScreenWidth, kScreenHeight - scrollY)];
    self.scrollView.delegate = self;
    
    for (int i = 0; i < kImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * i, scrollY, kScreenWidth, kScreenHeight - scrollY)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"huoying%d",i + 1]];
        [self.scrollView addSubview:imageView];
    }
//    要大于宽度才会出现滑动效果
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * kImageCount, kScreenHeight - scrollY);
//    设置分页功能
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
}

-(void)initPageContrl{
    
    self.pageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake((kScreenWidth - pageCtrlWidth) / 2, kScreenHeight - scrollY, pageCtrlWidth, scrollY)];
    self.pageCtrl.numberOfPages = kImageCount;
    self.pageCtrl.pageIndicatorTintColor = [UIColor greenColor];
    self.pageCtrl.currentPageIndicatorTintColor = [UIColor yellowColor];
//    这里添加试图是在view上，而不是在ScrollView上，所以使用插入视图
    [self.view insertSubview:self.pageCtrl aboveSubview:self.scrollView];
}
//添加一个定时器
-(void)addTimer{

    self.timer = [NSTimer scheduledTimerWithTimeInterval: 2.0 target:self selector: @selector(nextPage) userInfo:nil repeats:YES];
//    消息机制，用来管理多线程
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
-(void)nextPage{
//    拿到当前的页码数
    NSInteger page = self.pageCtrl.currentPage;
    page++;
    if (page == kImageCount) {
        page = 0;
    }
//    通过当前的页码数，改变ScrollView的偏移量，从而实现ScrollView的滑动效果
    CGPoint point = CGPointMake(kScreenWidth * page, 0);
    [self.scrollView setContentOffset:point animated:YES];
    
    
}
#pragma mark - UIScrollView delegate
//当滑动视图滑动的时候:pageCtrl同步
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    加上0.5是让页面滑动到一般的时候，到下一张(偏移量！！)
    NSInteger page = scrollView.contentOffset.x / kScreenWidth + 0.5;
    self.pageCtrl.currentPage = page;
}
//自动滑动和手动滑动还有冲突需要代理方法解决
//当视图拖动的时候，关掉定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self removeTimer];
}
//当停止手动滑动的时候，开启定时器采用GCD的方式
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    采用下面的方法
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(<#delayInSeconds#> * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            <#code to be executed after a specified delay#>
    //        });
    //如果这里不重新关掉定时器，会有跑马灯现象出现，应该是有bug，但是重新关掉定时器，能解决问题
    [self removeTimer];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addTimer];
    });
}
//关掉定时器的方法
-(void)removeTimer{
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
