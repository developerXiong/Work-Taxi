//
//  JDMessgeViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/2/15.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDMessgeViewController.h"

#import "HeadFile.pch"
#import "JDMessgeCell.h"

#import "JDPushDataTool.h"
#import "JDPushData.h"

@interface JDMessgeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation JDMessgeViewController

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addNavigationBar:@"消息"];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    JDLog(@"%@",[[JDPushDataTool new] query]);
    
    for (NSDictionary *dict in [[JDPushDataTool new] query]) {
        JDPushData *data = [JDPushData pushDataWithDictionary:dict];
        [self.dataArr addObject:data];
        [self.tableView reloadData];
    }
    
    if (self.dataArr.count) {
        
        [self addTableview];
        
    }else{
        /**
         *  设置没有消息的界面
         */
        [self showHaveNoMessage];
    }
    
}


/**
 *  设置没有消息的界面
 */
-(void)showHaveNoMessage
{
    
    /**
     *  图标的大小
     */
    CGSize imageS = [[UIImage imageNamed:@"喇叭"] size];
    
    /**
     *   没有消息的时候的图标
     */
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageS.width, imageS.height)];
    imageV.center = CGPointMake(JDScreenSize.width/2, JDScreenSize.height*2/5);
    [self.view addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"喇叭"];
    
    /**
     *  没有消息时候的label
     */
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake((JDScreenSize.width-150)/2, CGRectGetMaxY(imageV.frame)+10, 150, 30)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.text = @"您当前没有任何消息!";
    textLabel.textColor = TextLightColor;
    textLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:textLabel];
    
}

//添加tableView
-(void)addTableview
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, JDScreenSize.width, JDScreenSize.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - tableView delegate&datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSMutableArray *dataArr = self.dataArr;
    return dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JDPushData *data = self.dataArr[indexPath.section];
    
    static NSString *ID = @"messCell";
    JDMessgeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"JDMessgeCell" owner:nil options:nil]objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.title.text = data.title;
    cell.time.text = data.currentTime;
    cell.describe.text = data.content;
    
    
    return cell;
}

//头视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
//脚视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 11;
}
//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

@end
