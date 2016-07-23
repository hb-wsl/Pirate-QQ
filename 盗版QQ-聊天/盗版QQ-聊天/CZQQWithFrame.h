//
//  CZQQWithFrame.h
//  盗版QQ-聊天
//
//  Created by czbk on 16/5/22.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZMessageModel;
@interface CZQQWithFrame : NSObject

@property(assign,nonatomic,readonly)CGRect timeFrame;   //时间
@property(assign,nonatomic,readonly)CGRect iconFrame;   //头像
@property(assign,nonatomic,readonly)CGRect textFrame;   //内容


@property(assign,nonatomic,readonly)CGFloat rowHeight;  //行高

@property(strong,nonatomic)CZMessageModel *model;

@end
