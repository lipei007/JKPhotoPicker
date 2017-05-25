//
//  JKAlbumModel.h
//  JKPhotoPicker
//
//  Created by emerys on 16/9/7.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface JKAlbumModel : NSObject

@property (nonatomic,strong) ALAssetsGroup *group;

@property (nonatomic,readonly,copy) NSString *name;

@property (nonatomic,strong) NSMutableArray *photos;

@property (nonatomic,readonly,strong) UIImage *cover;

@end

#pragma clang diagnostic pop
