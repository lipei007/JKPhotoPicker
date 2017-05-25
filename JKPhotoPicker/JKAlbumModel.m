//
//  JKAlbumModel.m
//  JKPhotoPicker
//
//  Created by emerys on 16/9/7.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKAlbumModel.h"
#import "JKPhotoModel.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@implementation JKAlbumModel

- (void)setGroup:(ALAssetsGroup *)group {
    _group = group;
    
    _name = [group valueForProperty:ALAssetsGroupPropertyName];
    
    __block NSMutableArray *photos = [NSMutableArray array];
    
    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
        if (result) {
            
            JKPhotoModel *photo = [[JKPhotoModel alloc] init];
            photo.selected = NO;
            photo.asset = result;
            
            [photos addObject:photo];
            
        } else {
            // 遍历完成
            _photos = photos;
            ALAsset *asset = ((JKPhotoModel *)[photos lastObject]).asset;
            _cover = [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
            
        }
        
    }];
    
}

@end
#pragma clang diagnostic pop
