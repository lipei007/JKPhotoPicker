//
//  JKPhotoCell.m
//  JKPhotoPicker
//
//  Created by emerys on 16/9/6.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKPhotoCell.h"
#import "UIImage+ColorImage.h"
#import "JKPhotoView.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface JKPhotoCell ()

@property (nonatomic,strong) JKPhotoView *photoButton;

@property (nonatomic,strong) UIButton *checkedButton;

@property (nonatomic,strong) ALAsset *asset;

@end

@implementation JKPhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
     
        [self addSubview:self.photoButton];
        [self addSubview:self.checkedButton];
        
    }
    return self;
}



#pragma mark - View

- (JKPhotoView *)photoButton {
    if (!_photoButton) {
        _photoButton = [JKPhotoView buttonWithType:UIButtonTypeCustom];
        
        _photoButton.frame = self.bounds;
    }
    return _photoButton;
}

- (UIButton *)checkedButton {
    if (!_checkedButton) {
        CGFloat x = CGRectGetWidth(self.bounds) - 27;
        CGFloat y = 5;
        _checkedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkedButton.frame = CGRectMake(x, y, 24, 24);
        [_checkedButton setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        [_checkedButton setImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
        _checkedButton.layer.cornerRadius = 11;
        _checkedButton.layer.masksToBounds = YES;
        
        [_checkedButton addTarget:self action:@selector(checkedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_checkedButton addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _checkedButton;
}

- (void)setCheckButtonFrame:(CGRect)frame {
    self.checkedButton.frame = frame;
    
    CGFloat w = frame.size.width;
    
    _checkedButton.layer.cornerRadius = w / 2;
    _checkedButton.layer.masksToBounds = YES;
    
}


#pragma mark - Data

- (void)setAsset:(ALAsset *)asset {
    _asset = asset;
    
    // 加载全尺寸图片，耗时
//    ALAssetRepresentation *representation = [asset defaultRepresentation];
    // 获取资源图片的 fullScreenImage
//    UIImage *contentImage = [UIImage imageWithCGImage:[representation fullScreenImage]];
    
    // 一般来说，展示资源列表都会使用缩略图（result.thumbnail）
//    UIImage *contentImage = [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
//     UIImage *contentImage = [UIImage imageWithCGImage:asset.thumbnail];
//    
//    [self.photoButton setImage:contentImage forState:UIControlStateNormal];
//    [self.photoButton setImage:contentImage forState:UIControlStateSelected];
//    [self.photoButton setImage:contentImage forState:UIControlStateHighlighted];
    
    self.photoButton.asset = asset;
}

- (void)setPhoto:(JKPhotoModel *)photo {
    _photo = photo;
    self.asset = photo.asset;
    self.checkedButton.selected = photo.selected;
}

#pragma mark - action

- (void)checkedButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.photo.selected = sender.selected;
}

#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([object isKindOfClass:[UIButton class]] &&[keyPath isEqualToString:@"selected"]) {
        
        UIButton *sender = (UIButton *)object;
        UIColor *selectedColor = [UIColor colorWithRed:0.1034 green:0.5510 blue:0.1756 alpha:1];
        
        if (sender.selected) {
            
            CGSize size = CGSizeMake(CGRectGetWidth(sender.bounds), CGRectGetWidth(sender.bounds));
            UIImage *selectedImage = [UIImage imageWithColor:selectedColor size:size];
            
            [sender setBackgroundImage:selectedImage forState:UIControlStateNormal];
            
            //        CGRect frame = sender.frame;
            
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
                
                //            CGRect tmpFrame = frame;
                //            tmpFrame.size.width += 3;
                //            tmpFrame.size.height += 3;
                //
                //            [self setCheckButtonFrame:tmpFrame];
                
                sender.transform = CGAffineTransformScale(sender.transform, 1.2, 1.2);
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
                    
                    //                [self setCheckButtonFrame:frame];
                    sender.transform = CGAffineTransformIdentity;
                    
                } completion:^(BOOL finished) {
                    
                }];
                
            }];
            
        } else {
            
            UIImage *normalImage = nil;
            
            [sender setBackgroundImage:normalImage forState:UIControlStateNormal];
            
        }

        
    }
}

- (void)dealloc {
    [self.checkedButton removeObserver:self forKeyPath:@"selected"];
}

@end

#pragma clang diagnostic pop
