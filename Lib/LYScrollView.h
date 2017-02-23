//
//  LYScrollView.h
//  LYScrollView
//
//  Created by 刘勇 on 2017/2/23.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 一句话实现一个轮播图  
 大概实现思路（写的简单，了解详细思路可以加我QQ：529293873）
 1.主要的实现控件有UIImageView和UIScollerView
 2.首先在视图中添加一个UIScrollView 设置它的尺寸和可偏移量 根据传入图片的张数确定 并开启它的page属性
 3.然后再将UIImageView添加到创建好的ScrollView 此处注意要添加images.count+2个view视图
 4.设置pageControl 添加到试图上
 5.实现UIScollerView的代理方法
 6.使用定时器实现其自动轮播的效果
 */

@protocol LYScrollViewDelegate <NSObject>

@optional
/**
 代理方法
 @param imageIndex 当前点击图片的位置（从0开始）
 */
-(void)didTapOnImages:(NSInteger)imageIndex;

@end

@interface LYScrollView : UIView

/**
 代理
 */
@property(nonatomic,weak)id<LYScrollViewDelegate>scrollDelegate;

/**
 初始化方法
 @param frame frame
 @param images 包含图片名字的数组
 @param isTouch 图片是否可点击 如果Yes 则实现didTapOnImages:代理方法 否则可以不实现
 @return 返回一个轮播视图
 */

-(id)initLYScrollViewWithFrame:(CGRect)frame imageNameArray:(NSArray*)images isTouch:(BOOL)isTouch;

@end
