//
//  CountryFlagsView.m
//  Country-UIPickerView
//
//  Created by Birdy on 16/9/1.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import "CountryFlagsView.h"
#import "CountryInfo.h"

@implementation CountryFlagsView

+(instancetype)countryView{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"CountryFlagsView" owner:nil options:nil]lastObject];
}

//复写set方法、并在set方法中赋值
-(void)setCountryModel:(CountryInfo *)countryModel{
    if (_countryModel != countryModel) {
        _countryModel = countryModel;
        self.name.text = _countryModel.name;
        self.flag.image = [UIImage imageNamed:_countryModel.icon];
    }
}

+(CGFloat)rowHeight{
    
    return 54;
}

@end
