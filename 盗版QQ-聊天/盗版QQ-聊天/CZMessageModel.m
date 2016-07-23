//
//  CZMessageModel.m
//  盗版QQ-聊天
//
//  Created by czbk on 16/5/22.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "CZMessageModel.h"

@implementation CZMessageModel

-(instancetype)initWithMessModel:(NSDictionary*)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)MessModel:(NSDictionary*)dict{
    return [[self alloc]initWithMessModel:dict];
}

@end
