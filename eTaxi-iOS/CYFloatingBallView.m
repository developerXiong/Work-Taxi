//
//  CYFloatingBallView.m
//  CYFloatingBall
//
//  Created by jeader on 16/6/3.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "CYFloatingBallView.h"

#import "UIView+CYViewFram.h"
#import "JDCallCarTool.h"

#import "UIView+CYViewFram.h"

#define BallBtnX @"floatingBallX"
#define BallBtnY @"floatingBallY"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

#define FloatingBall_opaque [UIImage imageNamed:@"floatingBall_opaque"] // 不透明的悬浮窗
#define FloatingBall_translucent [UIImage imageNamed:@"floatingBall_translucent"] // 半透明的悬浮窗

@interface CYFloatingBallView ()<UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIButton *floatBtn;

@property (nonatomic, weak) UILabel *callCarNumber;

/**
 *  做动画的视图
 */
@property (nonatomic, weak) UILabel *animationView;

@end

@implementation CYFloatingBallView

+(instancetype)shareInstance
{
    static id floatingBall;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 从系统偏好设置中取x y
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        CGFloat x = [defaults floatForKey:BallBtnX];
        CGFloat y = [defaults floatForKey:BallBtnY];
//        NSLog(@"%f---%f",x,y);
        if (!x||!y) {
            x=10, y=100;
            [defaults setFloat:x forKey:BallBtnX];
            [defaults setFloat:y forKey:BallBtnY];
        }
        
        // 获取图片size
        CGSize size = [FloatingBall_opaque size];
        floatingBall = [[self alloc] initWithFrame:CGRectMake(x, y, size.width, size.height)];
        
    });
    
    return floatingBall;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpChildViews];
    }
    return self;
}

#pragma mark 设置所有的子视图
-(void)setUpChildViews
{
    
    // 悬浮按钮
    UIButton *floatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:floatBtn];
    _floatBtn = floatBtn;
    [floatBtn addTarget:self action:@selector(clickFloatBall:) forControlEvents:UIControlEventTouchUpInside];
    [floatBtn addTarget:self action:@selector(clickFloatBallDown:) forControlEvents:UIControlEventTouchDown];
    [floatBtn setBackgroundImage:FloatingBall_translucent forState:UIControlStateNormal];
    [floatBtn setBackgroundImage:FloatingBall_opaque forState:UIControlStateHighlighted];
    
    // 添加数字
    UILabel *callCarNumber = [[UILabel alloc] init];
    [floatBtn addSubview:callCarNumber];
    _callCarNumber = callCarNumber;
    callCarNumber.font = [UIFont systemFontOfSize:12];
    callCarNumber.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    callCarNumber.text = @"0";
    callCarNumber.textAlignment = NSTextAlignmentRight;
    [self setUpNumber];
    
    // 添加手势
    [self addGesture];
    
    // 动画视图
    UILabel *animationView = [[UILabel alloc] init];
    [self addSubview:animationView];
    animationView.text = @"+1";
    animationView.textColor = [UIColor whiteColor];
    animationView.alpha = 0;
    animationView.font = [UIFont systemFontOfSize:27];
    animationView.textAlignment = NSTextAlignmentCenter;
    _animationView = animationView;
    
}

#pragma mark public method 共有方法实现
//-(void)setNumber:(int)number
//{
//    _number = number;
//    
//    if (number>99) {
//        _callCarNumber.text = @"...";
//    }
//    _callCarNumber.text = [NSString stringWithFormat:@"%d",number];
//    
//}

-(void)setUpNumber
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [JDCallCarTool getCallCarInfoWithType:@"0" inVC:nil Num:nil Success:^(NSMutableArray *modelArr, int status) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
//                [CYFloatingBallView shareInstance].number = (int)modelArr.count;
                
                int number = (int)modelArr.count;
                
                if (number>99) {
                    _callCarNumber.text = @"...";
                }
                _callCarNumber.text = [NSString stringWithFormat:@"%d",number];
                
            });
            
        } failure:^(NSError *error) {
            
        }];
        
    });
}

-(void)startAnimation
{
//    [self show];
    
    [UIView animateWithDuration:0.5 animations:^{
       
        _animationView.alpha ++;
//        _animationView.transform = CGAffineTransformMakeScale(1.5, 1.5);
//        _animationView.y = -40;
        _animationView.transform = CGAffineTransformMakeTranslation(0, -40);
        
    } completion:^(BOOL finished) {
        
//        [UIView animateWithDuration:0.3 animations:^{
            _animationView.alpha = 0;
//
//        } completion:^(BOOL finished) {
            _animationView.transform = CGAffineTransformIdentity;
//        _animationView.y = 0;
//        }];
        
    }];
    
}

-(void)setEnble:(BOOL)enble
{
    _enble = enble;
    
    _floatBtn.enabled = enble;
    
}

#pragma mark 添加手势
-(void)addGesture
{
    // 拖动手势
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    gesture.delegate = self;
    [self addGestureRecognizer:gesture];
}

-(void)handler:(UIPanGestureRecognizer *)recognizer
{
    // 从系统偏好设置中取x y
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat x = [defaults floatForKey:BallBtnX];
    CGFloat y = [defaults floatForKey:BallBtnY];
    
//    NSLog(@"----%f---%f",x,y);
    
    CGPoint point = [recognizer translationInView:self];
    CGFloat newX = x+point.x, newY = y+point.y;
    
    self.x = newX;
    self.y = newY;
    
    // 拖动结束
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        if (self.x<=Width/2-self.bounds.size.width/2){ // 只要小于一半的屏幕
            
            [UIView animateWithDuration:0.1 animations:^{
                
                self.x = 5;
                
            }];
            
        }
        if (self.x>Width/2-self.bounds.size.width/2) {
            [UIView animateWithDuration:0.1 animations:^{
                
                self.x = Width-self.bounds.size.width-5 ;
                
            }];
        }
        
        if (self.y<=20) {
            [UIView animateWithDuration:0.1 animations:^{
                
                self.y = 20 ;
                
            }];
        }
        if (self.y>=Height-self.bounds.size.height-5) {
            [UIView animateWithDuration:0.1 animations:^{
                
                self.y = Height-self.bounds.size.height-5 ;
                
            }];
        }
        
        // 将最后一次的悬浮按钮的位置记录在系统偏好设置中
        [defaults setFloat:self.x forKey:BallBtnX];
        [defaults setFloat:self.y forKey:BallBtnY];
    }
    
}


#pragma mark 点击悬浮按钮
-(void)clickFloatBallDown:(UIButton *)sender
{
    [sender setBackgroundImage:FloatingBall_opaque forState:UIControlStateNormal];
    _callCarNumber.textColor = [UIColor whiteColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sender setBackgroundImage:FloatingBall_translucent forState:UIControlStateNormal];
        _callCarNumber.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    });
}

-(void)clickFloatBall:(UIButton *)sender
{
    [sender setBackgroundImage:FloatingBall_translucent forState:UIControlStateNormal];
    _callCarNumber.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    
    if (self.floatBall) {
        self.floatBall(sender);
    }
}

#pragma mark 界面布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_floatBtn setFrame:self.bounds];
    
    _callCarNumber.frame = CGRectMake(0, 5, _floatBtn.bounds.size.width-11, 11);
    
    _animationView.frame = CGRectMake(0, 0, 58, 15);
}

/**
 *  显示
 */
-(void)show
{
    [self makeKeyAndVisible];
    self.hidden = NO;
}
// 隐藏
-(void)hidden
{
    [self resignKeyWindow];
    self.hidden = YES;
}

@end
