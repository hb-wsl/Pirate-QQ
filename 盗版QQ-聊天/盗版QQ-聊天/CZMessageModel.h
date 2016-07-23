//
//  CZMessageModel.h
//  盗版QQ-聊天
//
//  Created by czbk on 16/5/22.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZMessageModel : NSObject

@property(copy,nonatomic)NSString *text;
@property(copy,nonatomic)NSString *time;
@property(assign,nonatomic)NSInteger type;


@property(assign,nonatomic)BOOL hidenTime;

-(instancetype)initWithMessModel:(NSDictionary*)dict;
+(instancetype)MessModel:(NSDictionary*)dict;

@end
