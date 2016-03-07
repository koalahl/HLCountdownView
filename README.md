# HLCountdownView
倒计时控件。支持时分秒设置。

使用方式:
1.声明控件。
2.设置剩余时间。

```
    @property (nonatomic,strong)TimeView * timeV1;
    
    。。。
    
    self.timeV1.remainedTime  = [data[@"count_dowm_time"] integerValue];


- (TimeView *)timeV1{
    if (_timeV1 == nil) {
        CGRect timeViewBounds = CGRectMake(64, 42, 80, 24);
        _timeV1    = [[TimeView alloc]initWithFrame:timeViewBounds];
        _timeV1.backColor = [UIColor blackColor];
        [self addSubview:_timeV1];
    }
    return _timeV1;
}
```
