//
//  LeftTransparentView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/2/15.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "LeftTransparentView.h"
#import "HeadFile.pch"
#import "MyCell.h"
#import "UIImageView+AFNetworking.h"

#import "JDGetVipinfoTools.h"
#import "JDVipInfoData.h"

@implementation LeftTransparentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        //设置view的基本属性
        CGFloat selfW =JDScreenSize.width * 0.618;
        self.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:0.95];
        
        //设置UITable view
        UITableView * tabelVi =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, selfW, JDScreenSize.height) style:UITableViewStylePlain];
        tabelVi.delegate=self;
        tabelVi.dataSource=self;
        tabelVi.backgroundColor=[UIColor clearColor];
        tabelVi.showsVerticalScrollIndicator=NO;
        tabelVi.separatorColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
        tabelVi.tableFooterView=[[UIView alloc]init];
        [self addSubview:tabelVi];
        [MyData getPersonInfoWithCompletion:^(NSString *returnCode, NSString *msg, NSMutableDictionary *dic) {
            NSLog(@"1111%@---%@",PLATE,ENGINE);
            self.data =[dic objectForKey:@"info"];
            [tabelVi reloadData];
        }];
        
        // 请求并设置
        [JDGetVipinfoTools GetVipInfoSuccess:^(NSMutableDictionary *dictArr) {
           
            JDVipInfoData *data = dictArr[@"vipInfo"];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            MyCell *cell = [tabelVi cellForRowAtIndexPath:indexPath];
            cell.vipLab.text = data.grade;
            
        } failure:^(NSError *error) {
            
        }];
        
    }
    return self;
}
#pragma mark- UITable View DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * titles =[NSArray arrayWithObjects:@"积 分 明 细",@"会 员 中 心",@"我 的 预 约",@"我 的 营 收",@"邀 请 副 驾",@"使 用 说 明",@"设 置",@"关 于", nil];
    NSArray * imgNames =[NSArray arrayWithObjects:@"积分明细1",@"会员",@"预约",@"营收",@"邀请副驾",@"使用说明icon",@"设置",@"关于我们", nil];
    static NSString * cellID1 =@"cell2";
    static NSString * cellID2 =@"cell4";
    MyCell * cell =nil;
     
    if (indexPath.row==0)
    {
        cell=[tableView dequeueReusableCellWithIdentifier:cellID2];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"MyCell" owner:nil options:nil]objectAtIndex:3];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
        }

        cell.imageHead.layer.cornerRadius=30;
        cell.imageHead.clipsToBounds=YES;
        [cell.imageHead setImageWithURL:[NSURL URLWithString:self.data.avataraUrl] placeholderImage:[UIImage imageNamed:@"个人信息头像"]];
        if ([NAME length])
        {
            cell.nameLabel.text=NAME;
            cell.vipLab.hidden=NO;
        }
        else
        {
            cell.nameLabel.text=@"(未审核)";
            cell.vipLab.hidden=YES;
        }
        
    }
    else
    {
        cell=[tableView dequeueReusableCellWithIdentifier:cellID1];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"MyCell" owner:nil options:nil]objectAtIndex:4];
            cell.backgroundColor=[UIColor clearColor];
        }
        cell.infoLabel.text=[titles objectAtIndex:indexPath.row-1];
        
        cell.imageIcon.image=[UIImage imageNamed:[imgNames objectAtIndex:indexPath.row-1]];
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return 80;
    }
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * vw =[[UIView alloc]init];
    vw.backgroundColor=[UIColor clearColor];
    return vw;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
#pragma mark- UITable View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([_delegate respondsToSelector:@selector(selectRow:)])
    {
        [_delegate selectRow:indexPath.row];
    }
    
}
@end
