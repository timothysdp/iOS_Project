//
//  AppView.m
//  AppM
//
//  Created by Birdy on 16/8/25.
//  Copyright © 2016年 Birdy. All rights reserved.
//

#import "AppView.h"
#import "AppInfo.h"

//删除 ：supercalss
@interface AppView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation AppView
- (IBAction)downloadOnClick:(UIButton *)sender {
    // 判断代理对象是否实现这个方法，没有实现会导致崩溃
    if ([self.delegate respondsToSelector:@selector(downLoadClickWithButton:)]) {
        [self.delegate downLoadClickWithButton:sender];
    }
}

+(instancetype)appView{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"AppView" owner:nil options:nil] lastObject];
}


//set方法
-(void)setAppInfo:(AppInfo *)appInfo{
    
    _appInfo = appInfo;
    self.iconView.image = appInfo.image;
    self.nameLabel.text = appInfo.name;
    
}

//点击事件：1：代理。2：通知。3:block??


@end
