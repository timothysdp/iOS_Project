//
//  ViewController.m
//  PicView
//
//  Created by Birdy on 16/8/11.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *dicLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

//一个索引
@property (nonatomic, assign) int index;
//图片数组
@property (nonatomic, weak) NSArray *imageDicts;
@end

@implementation ViewController

//懒加载方法
-(NSArray *)imageDicts{
    //保证数组只创建一次
    if (!_imageDicts) {
        
        //获取文件路径
        NSString *path = [[NSBundle mainBundle]pathForResource:@"imageDate.plist" ofType:nil];

        //将路径指定文件放到数组中
        _imageDicts = [NSArray arrayWithContentsOfFile:path];

    }
    return _imageDicts;
}

- (IBAction)leftButtonOnClick:(UIButton *)sender {

    self.index --;
    [self btnClickChange];
}
- (IBAction)rightButtonOnClick:(id)sender {

    self.index ++;
    [self btnClickChange];
}


-(void)btnClickChange{

    self.topLabel.text =[NSString stringWithFormat:@"%d/%d",(self.index+1),self.imageDicts.count];

//imageDicts是一个二维数组
    self.dicLabel.text = self.imageDicts[self.index][@"description"];

    self.imageView.image = [UIImage imageNamed:self.imageDicts[self.index][@"name"]];
    
    self.leftButton.enabled = (self.index != 0);
    self.rightButton.enabled = (self.index != self.imageDicts.count-1);
    
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
