//
//  JKAlbumCell.m
//  JKPhotoPicker
//
//  Created by emerys on 16/9/5.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKAlbumCell.h"
#import "JKCommon.h"

@interface JKAlbumCell ()

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@property (nonatomic,strong) UIImageView *coverView;

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation JKAlbumCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.coverView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

#pragma mark - view

- (UIImageView *)coverView {
    if (!_coverView) {
        
        CGFloat x = 10;
        CGFloat y = (CGRectGetHeight(self.bounds) - 50) / 2;
        CGFloat w = 50;
        CGFloat h = 50;
        
        _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _coverView.backgroundColor = [UIColor whiteColor];
        
        _coverView.userInteractionEnabled = YES;
    }
    return _coverView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        
        CGFloat x = CGRectGetMaxX(self.coverView.frame) + 20;
        CGFloat y = (CGRectGetHeight(self.bounds) - 30) / 2;
        CGFloat w = JK_ScreenWidth - x;
        CGFloat h = 30;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _titleLabel.numberOfLines = 1;
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

#pragma mark - set

- (void)setAlbum:(JKAlbumModel *)album {
    _album = album;
    
    self.titleLabel.text = album.name;
    self.coverView.image = album.cover;

}

#pragma clang diagnostic pop

@end
