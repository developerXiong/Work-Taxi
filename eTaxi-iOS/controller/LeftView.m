//
//  LeftView.m
//  DrawerDemo
//
//  Created by jeader on 16/1/19.
//  Copyright © 2016年 yangjx. All rights reserved.
//

#import "LeftView.h"
#import "HeadFile.pch"
#import "MyCell.h"


@interface LeftView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LeftView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        
        self.frame=CGRectMake(0, 0, -300, JDScreenSize.height);
        self.backgroundColor=NavigationBarColor;
        
        UITableView * tabelVi =[[UITableView alloc]initWithFrame:CGRectMake(0, 60, 300, JDScreenSize.height) style:UITableViewStylePlain];
        tabelVi.delegate=self;
        tabelVi.dataSource=self;
        tabelVi.separatorStyle=UITableViewCellSeparatorStyleNone;
        tabelVi.backgroundColor=[UIColor clearColor];
        [self addSubview:tabelVi];
       
    }
    
    return self;
}

#pragma mark- UITable View DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     NSArray * titles =[NSArray arrayWithObjects:@"我\t的\t积\t分",@"我\t的\t预\t约",@"我\t的\t营\t收",@"邀\t请\t副\t驾\t注\t册",@"设\t置",@"关\t于", nil];
    static NSString * cellID1 =@"cell2";
    static NSString * cellID2 =@"cell4";
    MyCell * cell =nil;
    
    if (indexPath.row==0)
    {
        cell=[tableView dequeueReusableCellWithIdentifier:cellID2];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"MyCell" owner:nil options:nil]objectAtIndex:3];
            cell.backgroundColor=[UIColor clearColor];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.imageHead.layer.cornerRadius=35;
        cell.imageHead.clipsToBounds=YES;
        cell.imageHead.image =[UIImage imageNamed:@"0606"];
        cell.teleLabel.text=@"13555555555";
        cell.teleLabel.textColor=[UIColor whiteColor];
        cell.teleLabel.font=[UIFont systemFontOfSize:19];
        
        cell.nameLabel.text=@"张三丰";
        cell.nameLabel.textColor=[UIColor whiteColor];
        cell.nameLabel.font=[UIFont systemFontOfSize:13];
        
    }
    else
    {
        cell=[tableView dequeueReusableCellWithIdentifier:cellID1];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"MyCell" owner:nil options:nil]objectAtIndex:4];
            cell.backgroundColor=[UIColor clearColor];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.infoLabel.text=[titles objectAtIndex:indexPath.row-1];
        cell.infoLabel.textColor=[UIColor whiteColor];
        cell.infoLabel.font=[UIFont systemFontOfSize:15];
        cell.imageIcon.image=[UIImage imageNamed:@"0606"];
        cell.imageIcon.clipsToBounds=YES;
        cell.imageIcon.layer.cornerRadius=17;
    }
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return 80;
    }
    return 60;
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
