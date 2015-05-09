//
//  HP_PageFlowView.h
//  common4ios
//
//  Created by Yi Xu on 12-11-15.
//  Copyright (c) 2012年 Yi Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HP_PageFlowViewDataSource;
@protocol HP_PageFlowViewDelegate;

/******************************
 名词解释:
 Page是指某一页
 Cell某一页对应的View
 Index是某一页的页码，从0开始
 _visibleRange 是指当前可见Page的页码范围
 _visibleCells 是指当前可见Page对应的Views
 
 说明:
 页面滚动的方向分为横向和纵向
 
 Version 0.1:
 本控件的目标是可以想使用UITableView那样使用翻页的View，且在显示当前页的同时，还可以看到与其相邻的页的部分内容
 可以实现诸如Mobie Safari预览所有打开页面或者App Store中截图查看的效果
 目前假设每一页的宽度都是一样的,每一页的View的类型也是一样的，如果后期需要修改，支持不同页的View类型不同，则需要对页面重用机制进行修改，需要为其页面的View创建一个基类View，添加reuseIdentifier属性
 ******************************/

typedef enum{
    HP_PageFlowViewOrientationHorizontal = 0,
    HP_PageFlowViewOrientationVertical
}HP_PageFlowViewOrientation;

@interface HP_PageFlowView : UIView<UIScrollViewDelegate>{
    HP_PageFlowViewOrientation orientation;//默认为横向
    
    UIScrollView        *_scrollView;
    BOOL                _needsReload;
    CGSize              _pageSize; //一页的尺寸
    NSInteger           _pageCount;  //总页数
    NSInteger           _currentPageIndex;
    
    NSMutableArray      *_cells;
    NSRange              _visibleRange;
    NSMutableArray      *_reusableCells;//如果以后需要支持reuseIdentifier，这边就得使用字典类型了
    
    UIPageControl       *pageControl; //可以是自己自定义的PageControl
    
    //如果希望非当前页的大小或者透明度发生变化可以设置这两个值
    CGFloat _minimumPageAlpha;
    CGFloat _minimumPageScale;
    
    
    id <HP_PageFlowViewDataSource> _dataSource;
    id <HP_PageFlowViewDelegate>   _delegate;
}

@property(nonatomic,strong)   id <HP_PageFlowViewDataSource> dataSource;
@property(nonatomic,strong)   id <HP_PageFlowViewDelegate>   delegate;
@property(nonatomic,retain)    UIPageControl       *pageControl;
@property (nonatomic, assign) CGFloat minimumPageAlpha;
@property (nonatomic, assign) CGFloat minimumPageScale;
@property (nonatomic, assign) HP_PageFlowViewOrientation orientation;
@property (nonatomic, assign, readonly) NSInteger currentPageIndex;

- (void)reloadData;

//获取可重复使用的Cell
- (UIView *)dequeueReusableCell;

- (void)scrollToPage:(NSUInteger)pageNumber;

@end


@protocol  HP_PageFlowViewDelegate<NSObject>

- (CGSize)sizeForPageInFlowView:(HP_PageFlowView *)flowView;

@optional

- (void)pageFlowViewDidScroll:(UIScrollView *)scrollView;

- (void)pageFlowViewDidEndScroll:(UIScrollView *)scrollView;

- (void)pageFlowViewDidEndScrollDragging :(UIScrollView *)scrollView;

- (void)willScrollFromPage:(NSInteger)pageNumber inFlowView:(HP_PageFlowView *)flowView;

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(HP_PageFlowView *)flowView;

- (void)didScrollToFirstPage:(NSInteger)pageNumber inFlowView:(HP_PageFlowView *)flowView;

- (void)didScrollToLastPage:(NSInteger)pageNumber inFlowView:(HP_PageFlowView *)flowView;

@end


@protocol HP_PageFlowViewDataSource <NSObject>

//返回显示View的个数
- (NSInteger)numberOfPagesInFlowView:(HP_PageFlowView *)flowView;

//返回给某列使用的View
- (UIView *)flowView:(HP_PageFlowView *)flowView cellForPageAtIndex:(NSInteger)index;

@end
