//
//  ViewController.m
//  SuperGuessImage
//
//  Created by Birdy on 16/8/28.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import "ViewController.h"
#import "QuestionInfo.h"

//写死的常量，就用const来定义，需要计算的，就用宏定义
//CGFloat const imageW = 150;
//图片宽度进行宏定义
#define imageW self.imageInsideButton.bounds.size.width
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kAnswerButtonTitleColor [UIColor blackColor]

/**
 *常量,
 */
CGFloat const kButtonW = 35;
CGFloat const kButtonH = 35;
CGFloat const kMarginBetweenButtons = 10;
NSInteger const kOptionViewTotalCol = 7;

NSInteger const kTrueAddScore = 200;
NSInteger const kFalseDecreaseScore = -200;
NSInteger const kTipDecreaseScore = -200;

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
@property (weak, nonatomic) IBOutlet UIButton *helpButton;


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
    
    if (nil == _questions) {
        
        _questions = [QuestionInfo questions];
    }
    return _questions;
}

//懒加载 return 遮盖
-(UIButton *)cover{
/**
 *这里有bug，第一次点击的时候，全屏都暗了
 */
    if (nil == _cover) {
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
 *这里还可以改进，提示的时候，只能提示第一个字，不够人性化，并且一道题可以多次提示，不符合逻辑
 *理想的提示是：判断第一个字是否正确，如果不正确就全部清空，显示第一个正确的；
 *当第一个字正确的时候，判断下一个时候正确，不正确清空当前的字包括后面的字，显示当前位置正确的字
 */
- (IBAction)tipButtonOnClick {
/**
*#warning noCode
*当方法没写完，可以先写一个警告，方便后期修改
*/
//    清空答案按钮内文字
//    一种是模拟按钮点击，清空
    for (UIButton *answerButton in self.answerView.subviews) {
        [self answerButtonOnClick:answerButton];
    }
//    取出答案中的第一个字
    NSString *answer = [self.questions[self.index]answer];
    NSString *firstrWord = [answer substringToIndex:1];
//    模拟点击optionView中第一个正确的按钮，扣分
    for (UIButton *optionButton in self.optionsView.subviews) {
        
        if ([optionButton.currentTitle isEqualToString:firstrWord]) {
            
            [self optionButtonOnClick:optionButton];
            [self coinChinge:kTipDecreaseScore];
            break;
        }
    }
}
/**
 *帮助按钮点击事件
 *这里还有个问题。扣分是固定的，后期升级按比例。
 *helpButton的enable能不能后期放到setupBaseInfo中？
 */
- (IBAction)helpButtonOnClick {
    for (UIButton *answerButton in self.answerView.subviews) {
        [self answerButtonOnClick:answerButton];
    }
    
    NSString *answer = [self.questions[self.index]answer];
    NSMutableArray *answerM = [NSMutableArray arrayWithCapacity:answer.length];
    for (int i = 0; i <= answer.length; i++) {
        [answerM addObject:[answer substringWithRange:NSMakeRange(i-1, 1)]];
    }
//    NSLog(@"answerM is :%@",answerM);
    for (NSString *string in answerM) {
        for (UIButton *optionButton in self.optionsView.subviews) {
            if ([optionButton.currentTitle isEqualToString:string]) {
//                [self tar]
                [self optionButtonOnClick:optionButton];
//                [self performSelector:@selector(optionButtonOnClick:) withObject:optionButton afterDelay:2.0];
                [self coinChinge:kTipDecreaseScore];
                break;
            }
        }
    }
}
/**
 *大图、遮盖/中间，三个按钮的点击事件
 */
- (IBAction)imageButtonChangeOnClick {
    
//    将中间图片按钮放置最顶层
    [self.view bringSubviewToFront:self.imageInsideButton];
    //        如果遮盖的透明度 =0，图片就是放大的
    if (0 == self.cover.alpha) {
        //        图片放大事件
        CGFloat scaleX = kScreenW / imageW;
        //        因为宽高是等比例变化
        CGFloat scaleY = scaleX;
        
//        Y方向上的偏移量
        CGFloat translateY = self.imageInsideButton.frame.origin.y / scaleX;
        
        //        因为形变是在动画中显现的
        [UIView animateWithDuration:1.0 animations:^{
            self.imageInsideButton.transform = CGAffineTransformMakeScale(scaleX, scaleY);
            
            self.imageInsideButton.transform = CGAffineTransformTranslate(self.imageInsideButton.transform, 0, translateY);
            //        遮盖显现
            self.cover.alpha = 0.5;
        }];
    }else{
        //        图片还原事件
        [UIView animateWithDuration:1.0 animations:^{
            self.imageInsideButton.transform = CGAffineTransformIdentity;
            self.cover.alpha = 0.0;
        }];
        
    }

}
/**
 *下一题点击事件
 */
- (IBAction)nextButtonOnClick {
//    此处写的是伪代码，后期需要新的view模块来升级
//    1.索引自增，并判断是否越界
    self.index ++;
    
    
    
    NSLog(@"index == %d", self.index);
    NSLog(@"self.questions.count == %d", self.questions.count);
    
    if (self.index >= self.questions.count) {
        NSLog(@"恭喜过关！");
        self.helpButton.enabled = NO;
        self.optionsView.userInteractionEnabled = NO;
        self.index --;
        return;
    }
//    2.取出模型
    QuestionInfo *question = self.questions[self.index];
//    3.设计基本信息
    [self setupBaseInfo:question];
//    4.创建答案按钮
    [self createAnswerButtons:question];
//    5.创建备选答案按钮
    [self createOptionButtons:question];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    这里可以让首页第一题就出现备选答案
    self.index = -1;
    [self nextButtonOnClick];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有方法
/**
 *设置基本信息
 */
-(void)setupBaseInfo:(QuestionInfo *)question{
////    恢复optionView的用户交互
//    self.optionsView.userInteractionEnabled = YES;
//    顶部图片索引改变
    self.topIndexLabel.text = [NSString stringWithFormat:@"%d/%d",self.index+1,self.questions.count];
//    图片种类描述改变
    self.descLabel.text = question.title;
//    图片改变
    [self.imageInsideButton setImage:question.image forState:UIControlStateNormal];
//    下一题点击按钮状态，当索引到最后的时候，按钮时不能点击的
    self.nextButton.enabled = (self.index != self.questions.count - 1);
}
/**
 *创建答案按钮
 */
-(void)createAnswerButtons:(QuestionInfo *)question{
//    创建答案按钮的时候，先要看之前是没有按钮的，所以要先清空一下,清空answerView
    for (UIButton * button in self.answerView.subviews) {
        [button removeFromSuperview];
    }
//    确定答案按钮的数量
    NSInteger answerButtonCount = question.answer.length;
//    第一个按钮和最后一个按钮与屏幕之间的间距
    CGFloat answerW = self.answerView.bounds.size.width;
//    计算间距
    CGFloat answerEdgeInset = (answerW - answerButtonCount * kButtonW - (answerButtonCount - 1) * kMarginBetweenButtons) * 0.5;
//    用for循环来创建按钮
    for (int i = 0; i < answerButtonCount; i++) {
        
        UIButton * button = [[UIButton alloc]init];
//        设置frame值，因为只有一行
//        先计算X的值
        CGFloat buttonX = answerEdgeInset + i * (kButtonW + kMarginBetweenButtons);
        button.frame = CGRectMake(buttonX, 0, kButtonW, kButtonH);
//        设置背景图片
        [button setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
//        设置字体颜色
        [button setTitleColor:kAnswerButtonTitleColor forState:UIControlStateNormal];
//        设置按钮的点击事件
        [button addTarget:self action:@selector(answerButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
//        将button添加到answerVIew上
        [self.answerView addSubview:button];
    }
}
/**
 *创建备选答案按钮
 */
-(void)createOptionButtons:(QuestionInfo *)question{
    
//    提取出来，相对严谨一些
    int optionsCount = question.options.count;
//    判断optionsView的subview的数量
    if (self.optionsView.subviews.count != optionsCount) {
//        若没有按钮，就创建
        CGFloat optionW = self.optionsView.bounds.size.width;
        //    计算间距
        CGFloat optionEdgeInset = (optionW - kOptionViewTotalCol * kButtonW - (kOptionViewTotalCol - 1) * kMarginBetweenButtons) * 0.5;
//        for虚幻创建按钮
//        算行数，列数
        for (int i = 0; i < optionsCount; i++) {
            int col = i % kOptionViewTotalCol;
            int row = i / kOptionViewTotalCol;
//            用类方法创建的按钮
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            计算X，Y
            CGFloat buttonX = optionEdgeInset + (kButtonW + kMarginBetweenButtons) * col;
            CGFloat buttonY = kMarginBetweenButtons + (kButtonH + kMarginBetweenButtons) * row;
            button.frame = CGRectMake(buttonX, buttonY, kButtonW, kButtonH);
            
            //        设置背景图片
            [button setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
            //        设置字体颜色
            [button setTitleColor:kAnswerButtonTitleColor forState:UIControlStateNormal];
            //        设置按钮的点击事件
            [button addTarget:self action:@selector(optionButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
            //        将button添加到answerVIew上
            [self.optionsView addSubview:button];

        }
//        如果有了，就没必要再重新创建，更改字符创就可以了
    }
    for (int i = 0; i < optionsCount; i++) {
        UIButton *optionButton = self.optionsView.subviews[i];
//        将字符串改变一下
        [optionButton setTitle:question.options[i] forState:UIControlStateNormal];
//        button的隐藏属性
        optionButton.hidden = NO;
    }
}

#pragma mark - 下面按钮的点击方法
//答案按钮点击方法
-(void)answerButtonOnClick:(UIButton *)answerButton{
    
    NSString *answerStr = answerButton.currentTitle;
//    先判断答案中时候有文字,若为空，直接返回
    if (nil == answerStr) {
        return;
    }
//    1.若不为空，去掉按钮内文字
    [answerButton setTitle:nil forState:UIControlStateNormal];
//    2.恢复optionView中隐藏的按钮
    for (UIButton *optionButton in self.optionsView.subviews) {
        if ([answerStr isEqualToString:optionButton.currentTitle] && optionButton.isHidden) {
            optionButton.hidden = NO;
            break;
        }
    }
//    3.若字体颜色不对，则恢复成黑色
    if (answerButton.currentTitleColor != kAnswerButtonTitleColor) {
        for (UIButton *answerButton in self.answerView.subviews) {
            [answerButton setTitleColor:kAnswerButtonTitleColor forState:UIControlStateNormal];
        }
        
//        恢复optionView的用户交互
        self.optionsView.userInteractionEnabled = YES;
    }
}
//备选答案按钮点击方法
-(void)optionButtonOnClick:(UIButton *)optionButton{
//    先把备选答案中的字拿出来
    NSString *optionStr = optionButton.currentTitle;
//    1.填字进answerView
    for (UIButton *answerButton in self.answerView.subviews) {
        if (nil == answerButton.currentTitle) {
            
            [answerButton setTitle:optionStr forState:UIControlStateNormal];
            break;
        }
    }
//    2.隐藏按钮
    optionButton.hidden = YES;
//    3.当字answerView中的字填满的时候
    BOOL isFull = YES;
    
    NSMutableString *stringM = [NSMutableString string];
    for (UIButton *answerButton in self.answerView.subviews) {
        if (nil == answerButton.currentTitle) {
            isFull = NO;
            break;
            
        }else{
//    将答案区中的字拼成一个字符串
            [stringM appendString:answerButton.currentTitle];
        }
    }

    if (YES == isFull) {
        self.optionsView.userInteractionEnabled = NO;
        
        NSString *answer = [self.questions[self.index] answer];
        if ([stringM isEqualToString:answer]) {
            for (UIButton *answerButton in self.answerView.subviews) {
                [answerButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            }
//    相同，全部变蓝，加分，一秒后进入下一题
                [self coinChinge:kTrueAddScore];
/**
 *恢复optionView的用户交互，重点，这里使用恢复用户交互，和setupBaseInfo方法在开头使用的都可以，但是具体有什么不同，再测
 */
                self.optionsView.userInteractionEnabled = YES;
                [self performSelector:@selector(nextButtonOnClick) withObject:nil afterDelay:1.0];
                
            
        }else{
//    与答案比较，不同，全部为红并扣分
            for (UIButton *answerButton in self.answerView.subviews) {
                [answerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                //    相同，全部变蓝，加分，一秒后进入下一题
                [self coinChinge:kFalseDecreaseScore];
        }
    }

}
}
    
#pragma mark - 分数变化
-(void)coinChinge:(NSInteger)delCoin{
    // 获取当前金钱数量
    NSInteger currentCoin = [self.coinButton.currentTitle integerValue];
    // 改变金钱数量
    currentCoin += delCoin;
    // 重置金钱数量
    NSString *coinStr = [NSString stringWithFormat:@"%d", currentCoin];
    [self.coinButton setTitle:coinStr forState:UIControlStateDisabled];}

@end
