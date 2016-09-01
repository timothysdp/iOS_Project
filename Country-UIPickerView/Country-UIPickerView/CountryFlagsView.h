//
//  CountryFlagsView.h
//  Country-UIPickerView
//
//  Created by Birdy on 16/9/1.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import <UIKit/UIKit.h>
//这里用@class是防止循环导入
@class  CountryInfo;
@interface CountryFlagsView : UIView
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *flag;

@property (strong, nonatomic) CountryInfo *countryModel;

+(instancetype)countryView;
+(CGFloat)rowHeight;
@end
