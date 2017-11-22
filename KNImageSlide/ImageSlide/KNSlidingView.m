//
//  KNSlidingView.m
//  KNImageSlide
//
//  Created by 刘凡 on 2017/10/30.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "KNSlidingView.h"

#import "ImageModel.h"

@interface KNSlidingView()<UIScrollViewDelegate>

@property(nonatomic, strong)NSLayoutConstraint *imageHeightConstraint;
//左后的滑动坐标
@property(nonatomic, assign)CGFloat lastPosition;
//当前页
@property(nonatomic, assign)NSInteger currentpage;

@property(nonatomic, strong)NSMutableArray <ImageModel *> *imageArray;

@end;


@implementation KNSlidingView

- (instancetype)initWithFrame:(CGRect)frame WithMutableArray:(NSMutableArray <ImageModel *> *)imageArray
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置分页
        self.pagingEnabled = YES;
        //设置弹簧效果为NO
        self.bounces = NO;
        self.delegate = self;
        //关闭自动布局
        self.translatesAutoresizingMaskIntoConstraints = NO;
        //隐藏滚动条
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        //获取到数组
        self.imageArray = imageArray;
        
        [self initViews];
        
    }
    return self;
}

-(void)initViews{
    CGFloat imageHeight = 0.0f;
    for (NSUInteger i = 0; i < self.imageArray.count ; i++) {
        ImageModel *model = [self.imageArray objectAtIndex:i];
        //获取到宽高比例的高度
        imageHeight = [self heightformodel:model];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH * i, 0, KSCREEN_WIDTH, imageHeight)];
        //多余部分不显示
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.tag = 100 +i;
        imageView.image = [UIImage imageNamed:model.imageName];
        [self addSubview:imageView];
    }
    //获取到第一张图片
    UIImageView *imageView = (UIImageView *)[self viewWithTag:100];
    //设置刚开始的数据
    self.contentSize = CGSizeMake(self.imageArray.count * KSCREEN_WIDTH, imageView.height);

    
    //修改成图片的高度
    CGRect frame = self.frame;
    frame.size.height = imageView.height;
    self.frame = frame;
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //拿到移动中的x
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat currentPostion = offsetX;
    //当前页数
    int page = offsetX / KSCREEN_WIDTH;

    BOOL isleft;
    if (currentPostion > _lastPosition) {
        isleft = YES;
        if (page > 0  && offsetX - page * KSCREEN_WIDTH <0.01) {
            page = page -1;
        }
    }else{
        isleft = NO;
    }

    UIImageView *firstImageView = (UIImageView *)[self viewWithTag:100+page];
    UIImageView *nextImageView = (UIImageView *)[self viewWithTag:100+page+1];
    ImageModel *firstModel = [self.imageArray objectAtIndex:page];
    ImageModel *nextModel = [self.imageArray objectAtIndex:page+1];
    
    CGFloat firtstImageHeiht = [self heightformodel:firstModel];
    CGFloat nextImageHeiht = [self heightformodel:nextModel];
    
    //设置Y
    CGFloat distanceY = isleft ? nextImageHeiht - firstImageView.height :firtstImageHeiht - firstImageView.height;
    CGFloat leftDistaceX = (page +1) * KSCREEN_WIDTH - _lastPosition;
    CGFloat rightDistanceX = KSCREEN_WIDTH - leftDistaceX;
    CGFloat distanceX = isleft ? leftDistaceX :rightDistanceX;
    
    
    //移动值
    CGFloat movingDistance = 0.0;
    if (distanceX != 0 && fabs(_lastPosition - currentPostion) > 0) {
        movingDistance = distanceY / distanceX * (fabs(_lastPosition - currentPostion));
    }
    
    CGFloat firstScale = [firstModel.imageWidth floatValue] / [firstModel.imageHeiht floatValue];
    CGFloat nextScale = [nextModel.imageWidth floatValue] / [nextModel.imageHeiht floatValue];
    
    
    firstImageView.frame = CGRectMake((firstImageView.frame.origin.x- movingDistance * firstScale), 0, (firstImageView.height+movingDistance)*firstScale, firstImageView.height+movingDistance);
    
    nextImageView.frame = CGRectMake(KSCREEN_WIDTH*(page+1), 0, firstImageView.height * nextScale, firstImageView.height);
    //重新设置大小
    self.contentSize = CGSizeMake( KSCREEN_WIDTH * self.imageArray.count, firstImageView.height);
    
    //重新设置高度
    CGRect frame = self.frame;
    frame.size.height = firstImageView.height;
    self.frame = frame;
    
    
    int newpage = offsetX / KSCREEN_WIDTH;
    if ( offsetX - newpage * KSCREEN_WIDTH < 0.01) {
        _currentpage = newpage+1;
    }
    
    _lastPosition = currentPostion;
}

- (CGFloat)heightformodel:(ImageModel *)model{
    CGFloat width = KSCREEN_WIDTH;
    CGFloat scale = [model.imageWidth floatValue] / width;
    CGFloat height =  [model.imageHeiht floatValue] / scale;
    return height;
}

                                                          


@end
