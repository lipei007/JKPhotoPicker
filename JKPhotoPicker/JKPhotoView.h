//
//  JKPhotoView.h
//  JKPhotoPicker
//
//  Created by emerys on 16/9/7.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@interface JKPhotoView : UIButton

@property (nonatomic,strong) ALAsset *asset;

@end
#pragma clang diagnostic pop