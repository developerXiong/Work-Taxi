//
//  JDMoreView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/1/19.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDMoreViewController.h"
#import "HeadFile.pch"
#import "JDMessgeViewController.h"
#import "GetData.h"
#import "UIViewController+CustomModelView.h"

#import "JDGoodsShopViewController.h"

#define cellHeight 50

@interface JDMoreViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

/**
 *  提醒小点
 */
@property (nonatomic, strong)UIImageView *message;

@property (nonatomic, strong)NSMutableArray *pushArr;

@end

@implementation JDMoreViewController

-(NSMutableArray *)pushArr
{
    if (_pushArr == nil) {
        
        _pushArr = [NSMutableArray array];
        
        for (NSDictionary *dict in PUSHDATA) {
            
            [_pushArr addObject:dict];
            
        }
        
    }
    return _pushArr;
}

-(void)viewDidLoad
{
    self.navigationItem.title = @"更多";
    [super viewDidLoad];
    //设置子视图
    [self setupSubviews];
    
//    NSLog(@"pushArr%@-----pushdata%@",self.pushArr,PUSHDATA);
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

 //设置子视图
-(void)setupSubviews
{
    JDLog(@"%f",JDScreenSize.height);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, JDScreenSize.width, JDScreenSize.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消cell的下划线
    self.tableView.scrollEnabled = NO;//禁止滚动
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView delegate&datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //添加cell的下划线
    UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, cellHeight - 1, JDScreenSize.width, 1)];
    bottomLine.backgroundColor = LineBackgroundColor;
//    bottomLine.hidden = YES;
    [cell.contentView addSubview:bottomLine];
    
    NSArray *textArr = @[@"消息",@"积分商城"];
    //添加label
    CGFloat messH = [self getStringHeightWithOriginalString:textArr[indexPath.row] WithStringFontOfSize:15];
    CGFloat messY = (cellHeight - messH) / 2;
    
    UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake( 60, messY, 100, messH)];
    message.text = textArr[indexPath.row];
    message.textColor = BLACKCOLOR;
//    [message sizeToFit];
    [cell.contentView addSubview:message];
    
    NSArray *imageArr = @[@"更多-消息",@"更多-积分商场"];
    CGSize imageS = [[UIImage imageNamed:imageArr[indexPath.row]] size];
    
    //message 图片
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, (cellHeight - imageS.height)/2, imageS.width, imageS.height)];
    imageV.image = [UIImage imageNamed:imageArr[indexPath.row]];
    [cell.contentView addSubview:imageV];
    
    if (indexPath.row == 0) { // 消息栏
        
        CGSize pointS = [[UIImage imageNamed:@"提醒小点"] size];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20+imageS.width-3, CGRectGetMinY(message.frame) - 2, pointS.width, pointS.height)];
        _message = imageV;
        imageV.image = [UIImage imageNamed:@"提醒小点"];
        [cell.contentView addSubview:imageV];
        
        //如果没有消息的时候隐藏红色小点
        if (self.pushArr.count&&[self.pushArr[0][@"flag"] intValue]==0) {
            
            imageV.hidden = NO;
            
        }else{
            
            imageV.hidden = YES;
            
        }
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDGoodsShopViewController *inVC = [[JDGoodsShopViewController alloc] init];
//    JDIntegrateViewController *inVC = [[JDIntegrateViewController alloc] init];
    
    JDMessgeViewController *messVC = [[JDMessgeViewController alloc] init];
    
    switch (indexPath.row) {
        case 0:
        {
            
            NSMutableArray *newArr = [NSMutableArray array];
            
            for (NSDictionary *dict in self.pushArr) {
                
                
                NSMutableDictionary *dddd = [NSMutableDictionary dictionary];
                
                [dddd setValuesForKeysWithDictionary:dict];
                
                if ([dddd[@"flag"] intValue] == 0) {
                    
                    [dddd setValue:@"1" forKey:@"flag"];
                    
                }
                
                [newArr addObject:dddd];
                
            }

            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:newArr forKey:@"pushArr"];
            [user synchronize];
            
            messVC.dataArr = newArr;
            
            [self.navigationController pushViewController:messVC animated:YES];
            [messVC addNavigationBar:@"消息"];
            
            /**
             *  隐藏红色小点
             */
            self.message.hidden = YES;
            
        }
            break;
        case 1:
        {
            [self.navigationController pushViewController:inVC animated:YES];
        }
            
            break;
            
        default:
            break;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}


//根据输入的字符串来获取label的宽度
- (NSInteger)getStringWidthWithOriginalString:(NSString *)str WithStringFontOfSize:(CGFloat)size
{
    CGRect rect =[str boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size]} context:nil];
    CGFloat width=ceilf(rect.size.width);
    return width;
}

- (NSInteger)getStringHeightWithOriginalString:(NSString *)str WithStringFontOfSize:(CGFloat)size
{
    CGRect rect =[str boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size]} context:nil];
    CGFloat height=ceilf(rect.size.height);
    return height;
}

@end
