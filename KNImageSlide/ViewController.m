//
//  ViewController.m
//  KNImageSlide
//
//  Created by 刘凡 on 2017/10/30.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "ViewController.h"
#import "KNSlidingView.h"
#import "ImageModel.h"


@interface ViewController ()

@property(nonatomic, strong)NSMutableArray *modeArray;

@property(nonatomic, strong)KNSlidingView *SlidingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initdata];
    
    [self initView];
 
}

-(void)initdata{
    
    self.modeArray = [[NSMutableArray alloc]init];
    
    NSArray *imgaeNameArray = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg"];
    NSArray *heightArray  = @[@"300",@"200",@"432",@"332",@"444"];
    NSArray *widhtArray = @[@"555",@"666",@"444",@"423",@"375"];
    
    for (int i = 0; i<imgaeNameArray.count; i++ ) {
        ImageModel *mode =[ImageModel initWithImageName:imgaeNameArray[i] WithImageHeiht:heightArray[i] ImageWidth:widhtArray[i]];
        [self.modeArray addObject:mode];
    }
}


-(void)initView{

    //设置frame,不用设置高度。因为这个View 里面是拿图片的高度重新设置
    self.SlidingView = [[KNSlidingView alloc]initWithFrame:CGRectMake(0, 20, KSCREEN_WIDTH, 0)
                                          WithMutableArray:self.modeArray];
    
    [self.view addSubview:self.SlidingView];


}



@end
