//
//  QuestionInfo.h
//  SuperGuessImage
//
//  Created by Birdy on 16/8/28.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QuestionInfo : NSObject

@property (copy, nonatomic) NSString *answer;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSArray *options;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)questionWithDict:(NSDictionary *)dict;

//icon 可以转化成一个image属性
@property (strong, nonatomic,readonly) UIImage *image;
//模型数组可以用一个类方法实现
+(NSArray *)questions;
@end
