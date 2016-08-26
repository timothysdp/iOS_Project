//
//  AppInfo.m
//  AppM
//
//  Created by Birdy on 16/8/25.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo{
    
    UIImage *image;
}

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
//        KVC方法传值
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+(instancetype)appInfoWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}

-(UIImage *)image{
    
    if (!image) {
        
        image = [UIImage imageNamed:self.icon];
    }
    return image;
}

@end
