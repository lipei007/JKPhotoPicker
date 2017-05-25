//
//  JKPhotoPickerController.m
//  JKPhotoPicker
//
//  Created by emerys on 16/9/6.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKPhotoPickerController.h"
#import "JKPhotoCell.h"
#import "JKCommon.h"
#import "JKPhotoModel.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface JKPhotoPickerController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *photoContainer;

@property (nonatomic,strong) NSMutableArray<JKPhotoModel *> *photos;

@property (nonatomic,strong) UIView *phtoNavigationBar;

@property (nonatomic,strong) UIView *bottomToolBar;

@end

@implementation JKPhotoPickerController

- (void)dealloc {
    for (JKPhotoModel *photo in self.photos) {
        photo.selected = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureNavigationBar];
    
    [self.view addSubview:self.photoContainer];
    [self.view addSubview:self.phtoNavigationBar];
    [self.view addSubview:self.bottomToolBar];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureNavigationBar {
    self.title = self.album.name;
    self.navigationController.navigationBar.hidden = YES;
//    self.navigationController.navigationBar.translucent = YES;
}

#pragma mark - data

- (NSMutableArray<JKPhotoModel *> *)photos {
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

- (void)setAlbum:(JKAlbumModel *)album {
    _album = album;
    
    if (!album.photos) {
        [album.group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            
            if (result) {
                
                JKPhotoModel *photo = [[JKPhotoModel alloc] init];
                photo.selected = NO;
                photo.asset = result;
                
                [self.photos addObject:photo];
                
            } else {
                // 遍历完成
                album.photos = self.photos;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.photoContainer reloadData];
                });
            }
            
        }];
    } else {
        self.photos = album.photos;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.photoContainer reloadData];
        });
    }
    
}

#pragma mark - view

- (UIView *)phtoNavigationBar {
    if (!_phtoNavigationBar) {
        _phtoNavigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JK_ScreenWidth, JK_NAVIGATIONBAR_HEIGHT)];
        _phtoNavigationBar.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8];
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(12, 27, 40, 30)];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(returnButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_phtoNavigationBar addSubview:backButton];

        
    }
    return _phtoNavigationBar;
}

- (UICollectionView *)photoContainer {
    if (!_photoContainer) {
        
        CGFloat spacing = 5;
        NSInteger cols = 4;
        CGFloat w = (JK_ScreenWidth - spacing * (cols + 1)) / cols;
        CGFloat h = w;
        
        // collectionView 自动就把status bar 空出来了。所以只算导航条高度44
        // flow layout
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(w, h);
        flowLayout.minimumLineSpacing = spacing;
        flowLayout.minimumInteritemSpacing = spacing;
        flowLayout.sectionInset = UIEdgeInsetsMake(44 + spacing, spacing, JK_TABBAR_HEIGHT + spacing, spacing);


        _photoContainer = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _photoContainer.backgroundColor = [UIColor whiteColor];
        _photoContainer.alwaysBounceVertical = YES;
        _photoContainer.dataSource = self;
        _photoContainer.delegate = self;
        _photoContainer.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, JK_TABBAR_HEIGHT, 0);
        
        [_photoContainer registerClass:[JKPhotoCell class] forCellWithReuseIdentifier:PhotoCellIdentifier];

        
    }
    return _photoContainer;
}

- (UIView *)bottomToolBar {
    if (!_bottomToolBar) {
        _bottomToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, JK_ScreenHeigh - JK_TABBAR_HEIGHT, JK_ScreenWidth, JK_TABBAR_HEIGHT)];
        _bottomToolBar.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.9];
    }
    return _bottomToolBar;
}

#pragma mark - datasource

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JKPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellIdentifier forIndexPath:indexPath];
    
    JKPhotoModel *model = [self.photos objectAtIndex:indexPath.row];
    cell.photo = model;
    
    return cell;
    
}





#pragma mark - delegate


#pragma mark - touch event

- (void)returnButtonClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end

#pragma clang diagnostic pop

