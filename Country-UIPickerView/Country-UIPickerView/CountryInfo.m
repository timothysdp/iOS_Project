//
//  CountryInfo.m
//  Country-UIPickerView
//
//  Created by Birdy on 16/9/1.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import "CountryInfo.h"

@implementation CountryInfo

-(instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)countryWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}

@end
