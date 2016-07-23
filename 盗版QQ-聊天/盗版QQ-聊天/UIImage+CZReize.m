//
//  UIImage+CZReize.m
//  盗版QQ-聊天
//
//  Created by czbk on 16/5/22.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "UIImage+CZReize.h"

@implementation UIImage (CZReize)

+(instancetype)resizeImageName:(NSString*)name{
    UIImage *image = [UIImage imageNamed:name];
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2, image.size.width/2, image.size.height/2, image.size.width/2) resizingMode:UIImageResizingModeTile];
}

@end
