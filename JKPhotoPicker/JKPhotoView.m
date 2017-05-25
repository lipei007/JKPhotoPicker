//
//  JKPhotoView.m
//  JKPhotoPicker
//
//  Created by emerys on 16/9/7.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKPhotoView.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@implementation JKPhotoView




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    if (self.asset) {
        
        UIImage *image = [UIImage imageWithCGImage:self.asset.aspectRatioThumbnail];
        CGSize imgSize = image.size;
        
        UIGraphicsBeginImageContextWithOptions(imgSize, NO, image.scale);

        
        [image drawAtPoint:CGPointMake(0, 0)];
        
        UIImage *drawImage = UIGraphicsGetImageFromCurrentImageContext();
        
        [self setImage:drawImage forState:UIControlStateNormal];
        [self setImage:drawImage forState:UIControlStateSelected];
        [self setImage:drawImage forState:UIControlStateHighlighted];
    }
    
    
}


- (void)setAsset:(ALAsset *)asset {
    _asset = asset;
    
    [self setNeedsDisplay];
}

@end

#pragma clang diagnostic pop