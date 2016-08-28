//
//  QuestionInfo.m
//  SuperGuessImage
//
//  Created by Birdy on 16/8/28.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import "QuestionInfo.h"

@implementation QuestionInfo{
    
    UIImage *_image;
}

-(instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)questionWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}

-(UIImage *)image{
    
    if (!_image) {
        
        _image = [UIImage imageNamed:self.icon];
    }
    return _image;
}

//快速创建模型的方法
+(NSArray *)questions{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"questions" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSDictionary *dict in array) {
        
        [arrayM addObject:[self questionWithDict:dict]];
    }
    return [arrayM copy];
}
@end
