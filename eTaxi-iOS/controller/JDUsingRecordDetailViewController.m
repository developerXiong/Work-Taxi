//
//  JDUsingRecordDetailViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/5/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDUsingRecordDetailViewController.h"

#import "JDUsingRecordData.h"

#import "HeadFile.pch"

#import "JDUsingRecordViewModel.h"

#import "JDUsingRecordMainView.h"

@interface JDUsingRecordDetailViewController ()

/**
 *   放模型的数组
 */
@property (nonatomic, strong) JDUsingRecordData *usingRecordData;

@end

@implementation JDUsingRecordDetailViewController

-(instancetype)initWithRecordData:(JDUsingRecordData *)usingRecordData
{
    if (self=[super init]) {
        self.usingRecordData = usingRecordData;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNavigationBar:@"兑换详情"];
    
    JDLog(@"----=%@",self.usingRecordData.costName);
    JDUsingRecordViewModel *viewModel = [[JDUsingRecordViewModel alloc] init];
    viewModel.data = self.usingRecordData;
 
    JDUsingRecordMainView *mainView = [[JDUsingRecordMainView alloc] initWithFrame:CGRectMake(0, 64, JDScreenSize.width, JDScreenSize.height-64)];
    mainView.viewModel = viewModel;
    [self.view addSubview:mainView];
    
}



@end
