//
//  JKHero.h
//  lolView
//
//  Created by Birdy on 16/8/18.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKHero : NSObject
//要用copy
//@property (copy, nonatomic) <#type#> *<#name#>;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *intro;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)heroWithDict:(NSDictionary *)dict;

@end
