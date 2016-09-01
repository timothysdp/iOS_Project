//
//  ViewController.m
//  Country-UIPickerView
//
//  Created by Birdy on 16/9/1.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import "ViewController.h"
#import "CountryInfo.h"
#import "CountryFlagsView.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation ViewController

-(NSArray *)dataArray{
    
    if (!_dataArray) {
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"flags.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        
        for (NSDictionary *dict in array) {
            [arrayM addObject:[CountryInfo countryWithDict:dict]];
        }
        _dataArray = [arrayM copy];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerViewDataSource
//返回组成部分的个数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
//    因为只有一组
    return 1;
}
//cell的个数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
//    #warning noCode
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataArray[row % self.dataArray.count];
}

#pragma mark - UIPickerViewDelegate

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    CountryFlagsView *countryView = (CountryFlagsView *)view;
    if (!countryView) {
        countryView = [CountryFlagsView countryView];
    }
    countryView.countryModel = self.dataArray[row];
    
    return countryView;
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    NSLog(@"rowHeight is %f",[CountryFlagsView rowHeight]);
    return [CountryFlagsView rowHeight];
}

@end
