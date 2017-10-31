//
//  KNSlidingView.h
//  KNImageSlide
//
//  Created by 刘凡 on 2017/10/30.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+KNViewExtend.h"

@class ImageModel;

@interface KNSlidingView : UIScrollView

-(instancetype)initWithFrame:(CGRect)frame WithMutableArray:(NSMutableArray <ImageModel *> *)imageArray;


@end
