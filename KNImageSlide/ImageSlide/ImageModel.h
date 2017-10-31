//
//  ImageModel.h
//  KNImageSlide
//
//  Created by 刘凡 on 2017/10/30.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject

@property(nonatomic, strong)NSString *imageName;

@property(nonatomic, strong)NSString *imageHeiht;

@property(nonatomic, strong)NSString *imageWidth;


+(ImageModel *)initWithImageName:(NSString *)imageName WithImageHeiht:(NSString *)imageHeiht ImageWidth:(NSString *)imageWidth;


@end
