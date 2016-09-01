//
//  CountryInfo.h
//  Country-UIPickerView
//
//  Created by Birdy on 16/9/1.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryInfo : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *icon;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)countryWithDict:(NSDictionary *)dict;

@end
