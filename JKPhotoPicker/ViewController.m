//
//  ViewController.m
//  JKPhotoPicker
//
//  Created by emerys on 16/8/22.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "ViewController.h"
#import "JKAlbumPickerViewController.h"
#import <Photos/Photos.h>

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    
    self.navigationController.navigationBar.translucent = NO;
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    JKAlbumPickerViewController *albumVC = [[JKAlbumPickerViewController alloc] init];

    [self.navigationController pushViewController:albumVC animated:YES];
    
}

@end
