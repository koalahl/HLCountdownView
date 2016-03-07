//
//  timeView.m
//  BigMouthMall
//
//  Created by Han liu on 15/6/3.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "TimeView.h"

@implementation TimeView
{
    NSTimer * _timer;
    CGRect  _frame;
    NSInteger hour ;
    NSInteger min  ;
    NSInteger sed  ;
    dispatch_source_t timer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _frame = frame;
    if (self) {
        [self addLabels];
    }
    return self;
}

- (void)addLabels{


    CGFloat scaleWidth  = _frame.size.width/80;
    CGFloat scaleHeight = _frame.size.height/30;
    
    CGFloat hourWidth   = 30*scaleWidth;
    CGFloat minWidth    = 20*scaleWidth;
    CGFloat secondWidth = 20*scaleWidth;
    CGFloat myHeigth    = 16*scaleHeight;
 
    
    if (!_font) {
        _font = [UIFont systemFontOfSize:12];
    }

    
    _hours = [[UILabel alloc]initWithFrame:CGRectMake(2, 1, hourWidth, myHeigth)];
    _hours.font = _font;
    _hours.textAlignment = NSTextAlignmentCenter;
    _hours.layer.cornerRadius = 5;
    _hours.clipsToBounds = YES;
    
    UILabel * colon1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_hours.frame)+2, 1, 5, myHeigth)];
    colon1.text = @":";
    colon1.font = _font;
    
    _min = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(colon1.frame), 1, minWidth, myHeigth)];
    _min.font = _font;
    _min.textAlignment = NSTextAlignmentCenter;
    _min.layer.cornerRadius = 5;
    _min.clipsToBounds = YES;
    
    UILabel * colon2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_min.frame)+2, 1, 5, myHeigth)];
    colon2.text = @":";
    colon2.font = _font;
    
    _sec = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(colon2.frame), 1, secondWidth, myHeigth)];
    _sec.font = _font;
    _sec.textAlignment = NSTextAlignmentCenter;
    _sec.layer.cornerRadius = 5;
    _sec.clipsToBounds = YES;
    
    {
        _hours.backgroundColor = [UIColor redColor];
        _min.backgroundColor   = [UIColor redColor];
        _sec.backgroundColor   = [UIColor redColor];
        colon1.textColor       = [UIColor redColor];
        colon2.textColor       = [UIColor redColor];
    }
    
    _hours.textColor = [UIColor whiteColor];
    _min.textColor   = [UIColor whiteColor];
    _sec.textColor   = [UIColor whiteColor];
    
    [self addSubview:_hours];
    [self addSubview:colon1];
    [self addSubview:_min];
    [self addSubview:colon2];
    [self addSubview:_sec];

    
}

- (void)setBackColor:(UIColor *)backColor{
   
        _hours.backgroundColor = backColor;
        _min.backgroundColor   = backColor;
        _sec.backgroundColor   = backColor;

}

- (void)setRemainedTime:(NSInteger)remainedTime{
    if (_timer) {
        [self stopTimer];
    }

    if (remainedTime>0) {
        hour = remainedTime/3600;
        
        min  = (remainedTime-hour*3600)/60;
        
        sed  = remainedTime-hour*3600-min*60;
        
        _hours.text = [NSString stringWithFormat:@"%.2ld",(long)hour];
        _min.text   = [NSString stringWithFormat:@"%.2ld",(long)min];;
        _sec.text   = [NSString stringWithFormat:@"%.2ld",(long)sed];;
        
        __weak typeof(self)wself = self;
        __block NSInteger timeout = remainedTime;
        
        dispatch_queue_t timerQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);//dispatch_queue_create("timerQueue",0 );
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, timerQueue);
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        
        dispatch_source_set_event_handler(timer, ^{
            
            if (timeout <= 0) {
                [wself stopTimer];
                dispatch_async(dispatch_get_main_queue(), ^{
                    _hours.text = @"00";
                    _min.text   = @"00";
                    _sec.text   = @"00";
                });
            }else{
                hour = timeout/3600;
                
                min  = (timeout-hour*3600)/60;
                
                sed  = timeout-hour*3600-min*60;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [wself timeDown];
                    
                });
                timeout--;
            }
            
            
            
        });
        dispatch_resume(timer);
    }

}


- (void)timeDown{

    _hours.text = [NSString stringWithFormat:@"%.2ld",(long)hour];
    _min.text   = [NSString stringWithFormat:@"%.2ld",(long)min];;
    _sec.text   = [NSString stringWithFormat:@"%.2ld",(long)sed];;

    
}

- (void)stopTimer{
    [_timer invalidate];
    _timer = nil;
}

@end
