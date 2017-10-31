# KNImageSlide

仿小红书的详情 图片滑动

### 不知道的可以下载一个小红书看看实际效果。  我先上效果图

![](https://github.com/krystalName/KNImageSlide/blob/master/ImageSlide.gif)

#### 原理解析
1.首先要了解的是。scrollView的高度是由内部元素去撑
2.要先拿到所有图片的高宽。 这样才能更好。更高效的实现高宽比例计算（需要你上传图片的时候，同时上传给后台上传高宽数值）
3.为什么不用修改约束。因为改一个组件的高度 和全改，性能是一样的，这个组件都要重新布局，但是frame不需要考虑其他组件
4.核心代码在scrollView的代理里面.上核心代码～

```objc 
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
```
