//
//  LYScrollView.m
//  LYScrollView
//
//  Created by 刘勇 on 2017/2/23.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "LYScrollView.h"
#define screen_H [UIScreen mainScreen].bounds.size.height
#define screen_W [UIScreen mainScreen].bounds.size.width
#define view_Height CGRectGetHeight(_Vframe)
#define view_Width CGRectGetWidth(_Vframe)

@interface LYScrollView ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView*scroller;
@property(nonatomic,strong)UIImageView*imageV;
@property(nonatomic,strong)UIPageControl*pageControl;
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,strong)NSMutableArray*imageNames;
@property(nonatomic,assign)CGRect Vframe;
@property(nonatomic,assign)BOOL isTouch;
@property(nonatomic,assign)NSTimer *timer;
@end

@implementation LYScrollView

-(NSMutableArray *)imageNames{
    if (!_imageNames) {
        _imageNames=[NSMutableArray array];
    }
    return _imageNames;
}
-(UIScrollView *)scroller{
    if (!_scroller) {
        _scroller=[[UIScrollView alloc]initWithFrame:_Vframe];
        _scroller.delegate=self;
        _scroller.pagingEnabled=YES;
        _scroller.showsHorizontalScrollIndicator=NO;
        _scroller.showsVerticalScrollIndicator=NO;
        _scroller.scrollEnabled=YES;
        _scroller.contentSize =CGSizeMake((self.imageNames.count + 2)*view_Width, view_Height);
        _scroller.contentOffset = CGPointMake(CGRectGetWidth(_Vframe), 0);
        [self addSubview:_scroller];

    }
    return _scroller;
}

-(UIImageView *)imageV{
    if (!_imageV) {
        for (int i = 0; i < self.imageNames.count + 2; i ++) {
            UIImageView *imageview = [[UIImageView alloc]init];
            imageview.frame = CGRectMake(i *view_Width, 0, view_Width, view_Height);
            imageview.userInteractionEnabled=YES;
            if (i == 0) {
                imageview.image = [UIImage imageNamed:[self.imageNames lastObject]];
            }else if (i == self.imageNames.count + 1) {
                imageview.image = [UIImage imageNamed:[self.imageNames firstObject]];
            }else{
                imageview.image = [UIImage imageNamed:[self.imageNames objectAtIndex:i - 1]];
            }
            _imageV=imageview;
            UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
            [_imageV addGestureRecognizer:tap];
            [self.scroller addSubview:_imageV];
        }
    }
    return _imageV;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(_Vframe)-30 , CGRectGetWidth(_Vframe), 30)];
        _pageControl.numberOfPages = self.imageNames.count;
        _pageControl.tintColor = [UIColor redColor];
    }
    return _pageControl;
}

-(id)initLYScrollViewWithFrame:(CGRect)frame imageNameArray:(NSArray*)images isTouch:(BOOL)isTouch{
    self=[super initWithFrame:frame];
    if (self) {
        self.imageNames=[NSMutableArray arrayWithArray:images];
        self.isTouch=isTouch;
        self.Vframe=frame;
        [self setUpViews];
    }
    return self;
}
-(void)setUpViews{
    [self.scroller addSubview:self.imageV];
    [self addSubview:self.pageControl];
    [self runTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.scroller.contentOffset.x == 0) {
        self.scroller.contentOffset = CGPointMake(self.scroller.contentSize.width - 2 *screen_W, 0);
    }else if (self.scroller.contentOffset.x >= self.scroller.contentSize.width - CGRectGetWidth(self.scroller.frame)){
        self.scroller.contentOffset = CGPointMake(CGRectGetWidth(_Vframe), 0);
    }
    int page = self.scroller.contentOffset.x / CGRectGetWidth(_Vframe) - 1;
    self.pageControl.currentPage = page;
    self.currentIndex=page;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (![_timer isValid]) {
        [self runTimer];
    }
}
-(void)runTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(runScroller) userInfo:nil repeats:YES];
}

- (void)runScroller{
    CGPoint point= self.scroller.contentOffset;
    point.x += self.scroller.frame.size.width;
    [UIView animateWithDuration:0.25 animations:^{
        self.scroller.contentOffset = point;
    } completion:^(BOOL finished) {
        if (finished) {
            [self scrollViewDidEndDecelerating:self.scroller];
        }
    }];
    self.currentIndex=point.x/CGRectGetWidth(_Vframe);
}

-(void)dealloc{
    _timer=nil;
    [_timer invalidate];
}

#pragma mark Custom Method
-(void)click:(id)sender{
    if (self.isTouch&&self.scrollDelegate&&[self.scrollDelegate respondsToSelector:@selector(didTapOnImages:)]){
        [self.scrollDelegate didTapOnImages:self.currentIndex];
        }else{
        return;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
