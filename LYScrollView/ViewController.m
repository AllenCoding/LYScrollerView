//
//  ViewController.m
//  LYScrollView
//
//  Created by 刘勇 on 2017/2/23.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "ViewController.h"
#import "LYScrollView.h"

#define screen_H [UIScreen mainScreen].bounds.size.height
#define screen_W [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<LYScrollViewDelegate>

@property(nonatomic,strong)LYScrollView*lyscrollview;

@end

@implementation ViewController

-(LYScrollView *)lyscrollview{
    if (!_lyscrollview) {
        CGRect frame=CGRectMake(0, 0, screen_W, 240);
        NSArray*images=@[@"top1",@"top2",@"top3",@"top4",@"top5",@"top6"];
        _lyscrollview=[[LYScrollView alloc]initLYScrollViewWithFrame:frame imageNameArray:images isTouch:YES];
        _lyscrollview.scrollDelegate=self;
    }
    return _lyscrollview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.lyscrollview];
}

-(void)didTapOnImages:(NSInteger)imageIndex{
    NSLog(@"%ld",imageIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
