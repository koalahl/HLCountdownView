//
//  TimeView.h
//  BigMouthMall
//
//  Created by Han liu on 15/6/3.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeView : UIView
@property (nonatomic,strong)UILabel * hours;
@property (nonatomic,strong)UILabel * min;
@property (nonatomic,strong)UILabel * sec;
@property (nonatomic,strong)UIColor * backColor;//外观颜色
@property (nonatomic,strong)UIFont  * font;
@property (nonatomic,assign,setter=setRemainedTime:)NSInteger remainedTime;//从start_time到end_time间的差值
@property (nonatomic,assign)NSInteger currentTimeLefted;//当前剩余时间/秒

- (instancetype)initWithFrame:(CGRect)frame;
@end
