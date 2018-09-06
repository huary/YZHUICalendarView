//
//  ViewController.m
//  YZHUICalendarViewDemo
//
//  Created by yuan on 2018/8/8.
//  Copyright © 2018年 yuan. All rights reserved.
//

#import "ViewController.h"
#import "YZHUICalendarView.h"
#import "YZHUIButton.h"

@interface ViewController () <YZHUICalendarViewDelegate>

/*  */
@property (nonatomic, strong) YZHUICalendarView *calendarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setupChildView];
}

-(void)_setupChildView
{
    CGFloat x = 0;
    CGFloat y = 100;
    CGFloat w = SAFE_WIDTH;
    CGFloat h = 500;
    self.calendarView = [[YZHUICalendarView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.calendarView.delegate = self;
    self.calendarView.backgroundColor = WHITE_COLOR;
    [self.view addSubview:self.calendarView];
    

//    [self.calendarView addObserver:self forKeyPath:@"dateComponents" options:NSKeyValueObservingOptionNew context:nil];
    
//    [self _test2];

//    [self _test3];

}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
//{
//    NSLog(@"keyPath=%@",keyPath);
//}

-(void)test1
{
    NSCalendar *calendar = [NSCalendar currentCalendar];//[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [NSDate date];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    NSLog(@"days=%ld",range.length);
    
    
    NSLog(@"calendar=%@,firstWeekDay=%ld",calendar,calendar.firstWeekday);
    
    
    //    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekdayOrdinal fromDate:date];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.year = 2018;
    comps.month = 8;
    comps.day = 8;
    //    comps.weekdayOrdinal = 1;
    //    comps.weekday = 4;
    //    comps.calendar = calendar;
    
    NSDate *dateT = [calendar dateFromComponents:comps];
    
    BOOL isToday = [calendar isDateInToday:dateT];
    NSLog(@"isToday=%@",@(isToday));
    
    
    NSDateComponents *compsT = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekdayOrdinal fromDate:dateT];
    
    NSLog(@"compsT=%ld.%ld.%ld",compsT.year,compsT.month,compsT.day);
    
    
    //    NSLog(@"calender=%@,firstWeekDay-2=%ld",comps.calendar,comps.calendar.firstWeekday);
    
    NSLog(@"weakday=%ld,weekdayOrdinal=%ld",compsT.weekday,compsT.weekdayOrdinal);
}

-(void)_test2
{
    CGFloat w = 5;
    UIImage *image = [YZHUIGraphicsImageContext createImageWithSize:CGSizeMake(w, w) cornerRadius:w/2 borderWidth:0 borderColor:nil backgroundColor:RGB_WITH_INT_WITH_NO_ALPHA(0x388CFF)];
    
    YZHUIButton *btn = [YZHUIButton buttonWithType:UIButtonTypeCustom];
    btn.layoutStyle = NSButtonLayoutStyleCustomInset;
    btn.titleEdgeInsetsRatio = UIEdgeInsetsMake(0, 0, 20, 0);
    btn.imageEdgeInsetsRatio = UIEdgeInsetsMake(40, 0, 0, 0);
    btn.backgroundColor = PURPLE_COLOR;
    [btn setTitle:@"hello" forState:UIControlStateNormal];
//    [btn setImage:image forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.backgroundColor = RED_COLOR;
    btn.imageView.backgroundColor = BROWN_COLOR;
    btn.imageView.contentMode = UIViewContentModeCenter;
    
    btn.frame = CGRectMake(100, 100, 100, 60);
    [self.view addSubview:btn];
    
    YZHUIButton *btn2 = [YZHUIButton buttonWithType:UIButtonTypeCustom];
    btn2.layoutStyle = NSButtonLayoutStyleCustomInset;
    btn2.titleEdgeInsetsRatio = UIEdgeInsetsMake(0, 0, 20, 0);
    btn2.imageEdgeInsetsRatio = UIEdgeInsetsMake(40, 0, 0, 0);
    btn2.backgroundColor = PURPLE_COLOR;
//    [btn2 setTitle:@"hello" forState:UIControlStateNormal];
    [btn2 setImage:image forState:UIControlStateNormal];
    btn2.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn2.titleLabel.backgroundColor = RED_COLOR;
    btn2.imageView.backgroundColor = BROWN_COLOR;
    btn2.imageView.contentMode = UIViewContentModeCenter;
    
    btn2.frame = CGRectMake(200, 100, 100, 60);
    [self.view addSubview:btn2];
}

-(void)_test3
{
    UIButton *rePlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rePlayButton.titleLabel.font = FONT(14);
    [rePlayButton setTitle:@"重放" forState:UIControlStateNormal];
    [rePlayButton setTitleColor:RedSpecialColor forState:UIControlStateNormal];
    UIImage *bgImage = [YZHUIGraphicsImageContext createImageWithSize:CGSizeMake(51, 26) cornerRadius:2 borderWidth:1 borderColor:RedSpecialColor backgroundColor:WHITE_COLOR];
    [rePlayButton setBackgroundImage:bgImage forState:UIControlStateNormal];
    
    [rePlayButton sizeToFit];
    rePlayButton.origin = CGPointMake(100, 100);
    [self.view addSubview:rePlayButton];
    
    
}

#pragma mark YZHUICalendarViewDelegate
-(BOOL)calendarView:(YZHUICalendarView *)calendarView shouldShowDotForDateComponents:(NSDateComponents*)dateComponents
{
    return (arc4random() & 1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
