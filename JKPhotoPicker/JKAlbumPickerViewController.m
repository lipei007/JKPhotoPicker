//
//  JKAlbumPickerViewController.m
//  JKPhotoPicker
//
//  Created by emerys on 16/8/22.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKAlbumPickerViewController.h"
#import "JKCommon.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "JKAlbumCell.h"
#import "JKPhotoPickerController.h"
#import "JKAlbumModel.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#define albumCellIdentifier @"albumCellIdentifier"

@interface JKAlbumPickerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *albumCollectionView;
@property (nonatomic,strong) __block NSMutableArray *albumArray;
@property (nonatomic,strong) ALAssetsLibrary *library;

@property (nonatomic,strong) __block UILabel *lab;

@end

@implementation JKAlbumPickerViewController

+ (ALAssetsLibrary *)sharedLibrary {
    static ALAssetsLibrary *library = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.albumCollectionView];
    
    [self loadAlbum];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self configureNavigationBar];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureNavigationBar {
//    self.navigationController.navigationBar.translucent = YES;
    self.title = @"相册列表";
    self.navigationController.navigationBar.hidden = NO;
}

- (UICollectionView *)albumCollectionView {
    if (!_albumCollectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _albumCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, JK_ScreenWidth, JK_ScreenHeigh - JK_NAVIGATIONBAR_HEIGHT) collectionViewLayout:flowLayout];
        
        _albumCollectionView.backgroundColor = [UIColor whiteColor];
        _albumCollectionView.alwaysBounceVertical = YES;
        _albumCollectionView.dataSource = self;
        _albumCollectionView.delegate = self;
        
        [_albumCollectionView registerClass:[JKAlbumCell class] forCellWithReuseIdentifier:albumCellIdentifier];
        
    }
    return _albumCollectionView;
}

- (NSMutableArray *)albumArray {
    
    if (!_albumArray) {
        _albumArray = [[NSMutableArray alloc] init];
    }
    
    return _albumArray;
}

- (ALAssetsLibrary *)library {
    
    return [JKAlbumPickerViewController sharedLibrary];
}

- (void)loadAlbum {
    
    /*****************************************************************************************
     *
     * 整个 AssetsLibrary 中对相册、资源的获取和保存都是使用异步处理
     *
     * 相册的结果使用 block 输出，如果相册遍历完毕，则最后一次输出的 block 中的 group 参数值为 nil。
     * 而 stop 参数则是用于手工停止遍历，只要把 *stop 置 YES，则会停止下一次的遍历.
     *
     * ALAssetsGroup 有一个 setAssetsFilter 的方法，可以传入一个过滤器，控制只获取相册中的照片或只获取视频。
     * 一旦设置过滤，ALAssetsGroup 中资源列表和资源数量的获取也会被自动更新。
     *
     *****************************************************************************************/
    
    
    [self.library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        //            Album             相册
        //            Saved Photos      相机胶卷
        //            Photo Stream      照片流
        if (group) {
            
            JKAlbumModel *album = [[JKAlbumModel alloc] init];
            album.group = group;
            
            [_albumArray addObject:album];
            
        } else {
            // 最后一个为空
            dispatch_async(dispatch_get_main_queue(), ^{
               [self.albumCollectionView reloadData]; 
            });
        }
        
        
    } failureBlock:^(NSError *error) {
        NSLog(@"album error:%@",error);
    }];
}


#pragma mark - data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.albumArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JKAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:albumCellIdentifier forIndexPath:indexPath];
    
    JKAlbumModel *album = [self.albumArray objectAtIndex:indexPath.row];
    
    cell.album = album;
    
    cell.backgroundView.backgroundColor = [UIColor redColor];
    
    
    return cell;
}


#pragma mark - delegate 

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JKAlbumModel *album = [self.albumArray objectAtIndex:indexPath.row];

    JKPhotoPickerController *photoPicker = [[JKPhotoPickerController alloc] init];
    
    photoPicker.album = album;
    
    [self.navigationController pushViewController:photoPicker animated:YES];
}

#pragma mark - delegate flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(JK_ScreenWidth, 60);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return  0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma clang diagnostic pop

@end
