//
//  ViewController.m
//  lolView
//
//  Created by Birdy on 16/8/17.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import "ViewController.h"
#import "JKHero.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *heros;

@end

@implementation ViewController
//懒加载
-(NSArray *)heros{
    if (!_heros) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"heros.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
//        NSLog(@"array is %@",array);
        //可变数组
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        
        for (NSDictionary *dict in array) {
            //创建模型
            JKHero *hero = [JKHero heroWithDict:dict];
            [arrayM addObject:hero];
        }
        //这里是深拷贝,我看_heros和arrayM的输出%@是相同的,%p是不同的
        _heros = [arrayM copy];
        
    }
    return _heros;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -UITableViewDataSource
//每个section有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.heros.count;
}

//默认可以不写
//-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
//    
//    return 1;
//}

//这里涉及到数据源方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"heroCell";
//第一步，创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //防止复用
    if (!cell) {
        //初始化同时设定样式
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    //定义cell格式
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //提取模型(对于模型的理解，还是不好)
    JKHero *hero = self.heros[indexPath.row];
//第二步，fill it with contents
    cell.textLabel.text = hero.name;
    cell.detailTextLabel.text = hero.intro;
    cell.detailTextLabel.textColor = [UIColor orangeColor];
    cell.imageView.image = [UIImage imageNamed:hero.icon];
    
//第三步，return it
    return cell;
}

#pragma mark -UITableViewDelegate
//行高，默认是44
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 44;
//}

//防止和顶部状态栏重叠以全屏
-(BOOL)prefersStatusBarHidden{
    return YES;
}


@end
