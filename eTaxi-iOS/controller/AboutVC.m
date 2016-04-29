//
//  AboutVC.m
//  eTaxi-iOS
//
//  Created by jeader on 15/12/31.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import "AboutVC.h"
#import "MMParallaxPresenter.h"
#import "MMParallaxPage.h"

@interface AboutVC ()

@property (weak, nonatomic) IBOutlet MMParallaxPresenter *mmParallaxPresenter;
@property (weak, nonatomic) IBOutlet UIButton *resetPresenter;

@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    [self setAboutView];
}
- (void)setAboutView
{
    [self.mmParallaxPresenter setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    
//    PageViewController *pageThreeViewController = [[PageViewController alloc] init];
    MMParallaxPage *page1 = [[MMParallaxPage alloc] initWithScrollFrame:self.mmParallaxPresenter.frame withHeaderHeight:150 andContentText:[self sampleText]];
    [page1.headerLabel setText:@"科技影响力 巨擘"];
    [page1.headerView addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stars.jpeg"]]];
    
    MMParallaxPage *page2 = [[MMParallaxPage alloc] initWithScrollFrame:self.mmParallaxPresenter.frame withHeaderHeight:150 withContentText:[self sampleText] andContextImage:[UIImage imageNamed:@"icon.png"]];
    [page2.headerLabel setText:@"金融影响力 慎独"];
    [page2.headerView addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mountains.jpg"]]];
    
    MMParallaxPage *page3 = [[MMParallaxPage alloc] initWithScrollFrame:self.mmParallaxPresenter.frame withHeaderHeight:150 andContentText:[self sampleText] ];
    [page3.headerLabel setText:@"营销影响力 信誉"];
    [page3 setTitleAlignment:MMParallaxPageTitleBottomLeftAlignment];
    [page3.headerView addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dock.jpg"]]];
    
    [self.mmParallaxPresenter addParallaxPageArray:@[page1, page2, page3]];
}

- (IBAction)resetPresenter:(id)sender
{
    [self.mmParallaxPresenter reset];
    
    MMParallaxPage *page1 = [[MMParallaxPage alloc] initWithScrollFrame:self.mmParallaxPresenter.frame withHeaderHeight:150 andContentText:[self sampleText]];
    [page1.headerLabel setText:@"朝气蓬勃 韧性"];
    [page1.headerView addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forest.jpg"]]];
    
    MMParallaxPage *page2 = [[MMParallaxPage alloc] initWithScrollFrame:self.mmParallaxPresenter.frame withHeaderHeight:150 withContentText:[self sampleText] andContextImage:[UIImage imageNamed:@"icon.png"]];
    [page2.headerLabel setText:@"目标宏远 睿智"];
    [page2.headerView addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mountains.jpg"]]];
    
    [self.mmParallaxPresenter addParallaxPageArray:@[page1, page2]];
}
- (NSString *)sampleText
{
    return @"\n       南京嘉易德信息科技有限公司位于南京市奥体中心。专业致力于为交通行业提供计算机软件研发、系统集成、企业信息化咨询和实施、服务为一体的高新科技企业和信息化服务供应商。专业致力于把基于先进信息技术（包括通信和网络技术）的最佳管理与业务实践普及到交通行业客户的管理与业务创新活动中， 全面提供具有自主知识产权的互联网+智慧出行管理软件-流媒体系列软件、门户网络信息化服务与解决方案，是中国交通行业最专业的管理软件及网络信息化服务提供商之一。服务遍及南京及江苏省内各个区域. \n \n       南京嘉易德信息科技有限公司 该公司其他职位 南京嘉易德信息科技有限公司位于南京市奥体中心。专业致力于为交通行业提供计算机软件研发、系统集成、企业信息化咨询和实施、服务为一体的高新科技企业和信息化服务供应商。专业致力于把基于先进信息技术（包括通信和网络技术）的最佳管理与业务实践普及到交通行业客户的管理与业务创新活动中， 全面提供具有自主知识产权的互联网+智慧出行管理软件-流媒体系列软件、门户网络信息化服务与解决方案，是中国交通行业最专业的管理软件及网络信息化服务提供商之一。服务遍及南京及江苏省内各个区域. \n \n       南京嘉易德信息科技有限公司 该公司其他职位 南京嘉易德信息科技有限公司位于南京市奥体中心。专业致力于为交通行业提供计算机软件研发、系统集成、企业信息化咨询和实施、服务为一体的高新科技企业和信息化服务供应商。专业致力于把基于先进信息技术（包括通信和网络技术）的最佳管理与业务实践普及到交通行业客户的管理与业务创新活动中， 全面提供具有自主知识产权的互联网+智慧出行管理软件-流媒体系列软件、门户网络信息化服务与解决方案，是中国交通行业最专业的管理软件及网络信息化服务提供商之一。服务遍及南京及江苏省内各个区域. \n \n       南京嘉易德信息科技有限公司 该公司其他职位 南京嘉易德信息科技有限公司位于南京市奥体中心。专业致力于为交通行业提供计算机软件研发、系统集成、企业信息化咨询和实施、服务为一体的高新科技企业和信息化服务供应商。专业致力于把基于先进信息技术（包括通信和网络技术）的最佳管理与业务实践普及到交通行业客户的管理与业务创新活动中， 全面提供具有自主知识产权的互联网+智慧出行管理软件-流媒体系列软件、门户网络信息化服务与解决方案，是中国交通行业最专业的管理软件及网络信息化服务提供商之一。服务遍及南京及江苏省内各个区域.";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
@end
