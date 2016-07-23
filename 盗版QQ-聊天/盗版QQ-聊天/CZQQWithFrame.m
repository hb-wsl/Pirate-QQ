//
//  CZQQWithFrame.m
//  盗版QQ-聊天
//
//  Created by czbk on 16/5/22.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "CZQQWithFrame.h"
#import "CZMessageModel.h"

#define kSpance 10

@implementation CZQQWithFrame


-(void)setModel:(CZMessageModel *)model{
    _model = model;
    //设置frame;
    CGSize screSize = [UIScreen mainScreen].bounds.size;
    //时间
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    CGFloat timeWidth = screSize.width;
    CGFloat timeHeight = 20;
    //
    if(!model.hidenTime){
        _timeFrame = CGRectMake(timeX, timeY, timeWidth, timeHeight);
    }
    
    //头像
    CGFloat iconWidth = 40;
    CGFloat iconHeight = 40;
    CGFloat iconY = CGRectGetMaxY(_timeFrame) + kSpance;    //时间最大Y + 间距
    CGFloat iconX = 0;
    if(model.type){
        iconX = kSpance;    //别人
    }else{
        iconX = screSize.width - iconWidth - kSpance;  //总宽-图片宽-右间距     自己
    }
    //
    _iconFrame = CGRectMake(iconX, iconY, iconWidth, iconHeight);
    
    //内容
    CGSize textSize = [model.text boundingRectWithSize:CGSizeMake(200, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    CGFloat textY = iconY;
    CGFloat textX = 0;
    CGFloat textWith = textSize.width + 40;
    CGFloat textHeight = textSize.height + 30;
    if(model.type){
        textX = CGRectGetMaxX(_iconFrame);  //最大头像X
    }else{
        textX = iconX - textWith;  //头像的x - 文字的宽
    }
    //
    _textFrame = CGRectMake(textX, textY, textWith, textHeight);
    
    //求行高
    _rowHeight = MAX(CGRectGetMaxY(_textFrame), CGRectGetMaxY(_iconFrame)) + kSpance;
}

@end
