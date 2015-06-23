//
//  UIImage+SJ.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/6.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "UIImage+SJ.h"

@implementation UIImage (SJ)
+ (UIImage *)imageWithName:(NSString *)name
{
    return [UIImage imageNamed:name];
}

+ (UIImage *)resizeImageWithName:(NSString *)name
{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
@end
