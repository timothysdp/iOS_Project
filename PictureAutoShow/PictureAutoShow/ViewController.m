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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initScrollView];
}
-(void)initScrollView{
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, scrollY, kScreenWidth, kScreenHeight)];
    self.scrollView.delegate = self;
    
    for (int i = 0; i < kImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * i, scrollY, kScreenWidth, kScreenHeight - scrollY)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"huoying%d",i + 1]];
        [self.scrollView addSubview:imageView];
    }
//    要大于宽度才会出现滑动效果
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * kImageCount, kScreenHeight - 20);
//    设置分页功能
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
