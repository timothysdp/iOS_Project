//
//  ViewController.m
//  SuperGuessImage
//
//  Created by Birdy on 16/8/28.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import "ViewController.h"
#import "QuestionInfo.h"

@interface ViewController ()
/**
 *顶部索引
 */
@property (weak, nonatomic) IBOutlet UILabel *topIndexLabel;
/**
 *图片类型描述
 */
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
/**
 *得分
 */
@property (weak, nonatomic) IBOutlet UIButton *coinButton;
/**
 *显示中间图片的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *imageInsideButton;
/**
 *下一题
 */
//最后的时候要设置不可点击
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
/**
 *显示答案按钮的视图
 */
@property (weak, nonatomic) IBOutlet UIView *answerView;
/**
 *显示备选答案按钮的视图
 */
@property (weak, nonatomic) IBOutlet UIView *optionsView;

/**
 *创建一个模型数组
 */

@property (strong, nonatomic) NSArray *questions;
/**
 *创建一个记录索引
 */
@property (assign, nonatomic) int index;
/**
 *遮盖按钮
 */
@property (strong, nonatomic) UIButton *cover;

@end

@implementation ViewController

//懒加载，retuen 模型数组
-(NSArray *)questions{
    
    if (!_questions) {
        
        _questions = [QuestionInfo questions];
    }
    return _questions;
}

//懒加载 return 遮盖
-(UIButton *)cover{
    
    if (!_cover) {
        _cover = [[UIButton alloc]init];
        _cover.frame = self.view.bounds;
        _cover.alpha = 0.0;
        _cover.backgroundColor = [UIColor blackColor];
        //        点击事件
        [_cover addTarget:self action:@selector(imageButtonChangeOnClick) forControlEvents:UIControlEventTouchUpInside];
        //        按钮添加到view上
        [self.view addSubview:_cover];
    }
    return _cover;
}


/**
 *提示按钮点击事件
 */
- (IBAction)tipButtonOnClick {
}
/**
 *帮助按钮点击事件
 */
- (IBAction)helpButtonOnClick {
}
/**
 *大图、遮盖/中间，三个按钮的点击事件
 */
- (IBAction)imageButtonChangeOnClick {
}
/**
 *下一题点击事件
 */
- (IBAction)nextButtonOnClick {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
