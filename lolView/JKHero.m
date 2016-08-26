//
//  JKHero.m
//  lolView
//
//  Created by Birdy on 16/8/18.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import "JKHero.h"

@implementation JKHero

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        //比较笨的方法
//        self.icon = [dict[@"icom"] copy];
//        self.name = [dict[@"name"] copy];
//        self.intro = [dict[@"intro"] copy];
        [self setValuesForKeysWithDictionary:dict];
        
        
    }
    return self;
}
+(instancetype)heroWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
