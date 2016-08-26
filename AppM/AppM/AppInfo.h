//
//  AppInfo.h
//  AppM
//
//  Created by Birdy on 16/8/25.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AppInfo : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *icon;

//image不想被修改，所以添加readnoly
@property (copy, nonatomic,readonly) UIImage *image;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)appInfoWithDict:(NSDictionary *)dict;

@end
