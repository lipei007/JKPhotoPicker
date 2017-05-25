//
//  JKAlbumCell.h
//  JKPhotoPicker
//
//  Created by emerys on 16/9/5.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "JKAlbumModel.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface JKAlbumCell : UICollectionViewCell


@property (nonatomic,strong) JKAlbumModel *album;


@end

#pragma clang diagnostic pop