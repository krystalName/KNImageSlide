//
//  ImageModel.m
//  KNImageSlide
//
//  Created by 刘凡 on 2017/10/30.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel

+(ImageModel *)initWithImageName:(NSString *)imageName WithImageHeiht:(NSString *)imageHeiht ImageWidth:(NSString *)imageWidth
{
    ImageModel *model = [ImageModel new];
    model.imageName = imageName;
    model.imageHeiht = imageHeiht;
    model.imageWidth = imageWidth;
    return model;
}
@end
