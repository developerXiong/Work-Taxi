//
//  JDUserManualViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/5/16.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDUserManualViewController.h"

#import "HeadFile.pch"
#import "JDUserManualView.h"

@interface JDUserManualViewController ()

@end

@implementation JDUserManualViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNavigationBar:@"使用说明"];
    
    [self setUpMainView];
}

-(void)setUpMainView
{
    JDUserManualView *mainView = [[JDUserManualView alloc] init];
    
    [self.view addSubview:mainView];
    
}


@end
