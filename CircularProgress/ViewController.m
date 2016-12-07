//
//  ViewController.m
//  CircularProgress
//
//  Created by shenzhenshihua on 2016/11/21.
//  Copyright © 2016年 shenzhenshihua. All rights reserved.
//

#import "ViewController.h"
#import "LZProgressView.h"
@interface ViewController ()
@property(nonatomic,strong)LZProgressView *progress;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _progress = [[LZProgressView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];//frame是方形
    [self.view addSubview:_progress];
    _progress.center = self.view.center;
//    progress.progress = 40;
    
    
    UISlider * sloder = [[UISlider alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, CGRectGetMaxY(_progress.frame)+10, 300, 20)];
    
    [self.view addSubview:sloder];
    [sloder addTarget:self action:@selector(sloderAction:) forControlEvents:UIControlEventValueChanged];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)sloderAction:(UISlider *)sloder{
    NSLog(@"%f",sloder.value);
    _progress.progress = sloder.value;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
