//
//  ViewController.m
//  CWCCATransition
//
//  Created by CWC on 15/12/16.
//  Copyright © 2015年 SouFun. All rights reserved.
//

#import "ViewController.h"
#define IMAGE_COUNT 6


@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self drawUI];
    
}

//定义控件并添加手势
- (void)drawUI{

    //定义控件
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
//    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = [UIImage imageNamed:@"0.jpg"];
    [self.view addSubview:self.imageView];
    
    //添加手势
    UISwipeGestureRecognizer *leftSwip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwip:)];
    leftSwip.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwip];
    
    UISwipeGestureRecognizer *rightSwip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwip:)];
    rightSwip.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwip];
    
    
}
#pragma mark=滑动视图
- (void)leftSwip:(UISwipeGestureRecognizer *)sender{

    [self transitionAnimation:YES];
    
}

- (void)rightSwip:(UISwipeGestureRecognizer *)sender{

    [self transitionAnimation:NO];
    
}

#pragma mark=转场动画
- (void)transitionAnimation:(BOOL)isNext{

    //创建转场动画对象
    CATransition *transiaction = [[CATransition alloc] init];
    //设置动画类型，注意对于苹果官方没有公开的动画类型只能使用字符串，并没有对应的常量定义
    transiaction.type = @"cube";
    
    //设置子类型
    if (isNext) {
        transiaction.subtype = kCATransitionFromRight;
    }else{
    
        transiaction.subtype = kCATransitionFromLeft;
    }
    
    //设置动画时长
    transiaction.duration = 1.0f;
    
    //设置转场后的新视图添加转场动画
    self.imageView.image = [self getImage:isNext];
    [self.imageView.layer addAnimation:transiaction forKey:@"KCATransitionAnimation"];
    
}

#pragma mark=取得当前图片
- (UIImage *)getImage:(BOOL)isNext{

    if (isNext) {
        self.currentIndex = (self.currentIndex + 1)%IMAGE_COUNT;
    }else{
    
        self.currentIndex = (self.currentIndex - 1 + IMAGE_COUNT)%IMAGE_COUNT;
    }
    
    NSString *imageName = [NSString stringWithFormat:@"%ld.jpg",(long)self.currentIndex];
    
    return [UIImage imageNamed:imageName];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
