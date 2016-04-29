//
//  JDCallCarMessageViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/22.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDCallCarMessageViewController.h"

#import "JDCallCarMessageCell.h"

#import "JDCallCarData.h"
#import "JDCallCarMessageTotalView.h"
#import "JDCallCarMessageViewFrame.h"

#import "JDCallCarTool.h"

#import "MJRefresh.h"

#import "GetData.h"

@interface JDCallCarMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *modelArr;

@end

@implementation JDCallCarMessageViewController

-(NSMutableArray *)modelArr
{
    if (_modelArr == nil) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    
}

- (void)setUpTableView
{
    self.tableView.separatorStyle = 0;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 获取数据
-(void)getData
{
    
    [JDCallCarTool getCallCarListWithType:@"3" Success:^(NSMutableArray *modelArr, int orderCount) {
       
        [self.tableView.mj_header endRefreshing];
        if (modelArr.count==0) {
            
            [GetData addMBProgressWithView:self.view style:1];
            [GetData showMBWithTitle:@"当前没有消息!"];
            [GetData hiddenMB];
            
        }else{
            
            self.modelArr = modelArr;
            [self.tableView reloadData];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - tableView delegate & datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDCallCarMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[JDCallCarMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = 0;
    }
    
    JDCallCarData *data = self.modelArr[indexPath.row];
    
    JDCallCarMessageViewFrame *viewF = [[JDCallCarMessageViewFrame alloc] init];
    
    viewF.callCarData = data;
    
    cell.ViewFrame = viewF;
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDCallCarData *data = self.modelArr[indexPath.row];
    
    JDCallCarMessageViewFrame *viewF = [[JDCallCarMessageViewFrame alloc] init];
    
    viewF.callCarData = data;
    
    return viewF.cellHeight;
}

@end
