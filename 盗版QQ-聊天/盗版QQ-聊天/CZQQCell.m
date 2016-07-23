//
//  CZQQCell.m
//  盗版QQ-聊天
//
//  Created by czbk on 16/5/22.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "CZQQCell.h"
#import "CZQQWithFrame.h"
#import "CZMessageModel.h"
#import "UIImage+CZReize.h"


@interface CZQQCell()

@property(weak,nonatomic)UILabel *oldTimeLabel;
@property(weak,nonatomic)UIImageView *oldIcon;
@property(weak,nonatomic)UIButton *oldText;

@end


@implementation CZQQCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        //创建
        //时间
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        self.oldTimeLabel = timeLabel;
        timeLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:timeLabel];
        
        //头像
        UIImageView *iconView = [[UIImageView alloc]init];
        self.oldIcon = iconView;
        [self.contentView addSubview:iconView];
        
        //内容
        UIButton *btnText = [[UIButton alloc]init];
        [btnText setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        btnText.titleLabel.numberOfLines = 0;       //新方法,自动换行
        
        btnText.titleLabel.font = [UIFont systemFontOfSize:13];
        btnText.titleEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        
        
        
        self.oldText = btnText;
        [self.contentView addSubview:btnText];
        
        //设置聊天对话背景为透明
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setQqFrame:(CZQQWithFrame *)qqFrame{
    _qqFrame = qqFrame;
    //
    self.oldTimeLabel.frame = qqFrame.timeFrame;
    self.oldIcon.frame = qqFrame.iconFrame;
    self.oldText.frame = qqFrame.textFrame;
    
    //
    CZMessageModel *model = qqFrame.model;
    
    self.oldTimeLabel.text = model.time;
    if(model.type){
        self.oldIcon.image = [UIImage imageNamed:@"other"];
        
        [self.oldText setBackgroundImage:[UIImage resizeImageName:@"chat_recive_nor"] forState:UIControlStateNormal];
        [self.oldText setBackgroundImage:[UIImage resizeImageName:@"chat_recive_press_pic"] forState:UIControlStateHighlighted];
    }else{
        self.oldIcon.image = [UIImage imageNamed:@"me"];
        
        [self.oldText setBackgroundImage:[UIImage resizeImageName:@"chat_send_nor"] forState:UIControlStateNormal];
        [self.oldText setBackgroundImage:[UIImage resizeImageName:@"chat_send_press_pic"] forState:UIControlStateHighlighted];
    }
    
    [self.oldText setTitle:model.text forState:UIControlStateNormal];
    
}
@end
