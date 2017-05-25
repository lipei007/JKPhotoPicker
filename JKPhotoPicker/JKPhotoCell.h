//
//  JKPhotoCell.h
//  JKPhotoPicker
//
//  Created by emerys on 16/9/6.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "JKPhotoModel.h"

#define PhotoCellIdentifier @"PhotoCell"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface JKPhotoCell : UICollectionViewCell

@property (nonatomic,strong) JKPhotoModel *photo;



@end

#pragma clang diagnostic pop