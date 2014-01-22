//
//  ViewController.m
//  OneToFifty
//
//  Created by SDT-1 on 2014. 1. 22..
//  Copyright (c) 2014년 Maybe There. All rights reserved.
//

#import "ViewController.h"

#define MAX_NUM 25


@interface ViewController (){

    NSMutableArray *RandomNumbers;

}


@property (strong, nonatomic) NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate; // Stores the date of the click on the start button


@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

- (IBAction)onStartPressed:(id)sender;
- (IBAction)onStopPressed:(id)sender;
-(IBAction)onResetPressed:(id)sender;


@end

@implementation ViewController


- (IBAction)onStopPressed:(id)sender {
    [self.stopWatchTimer invalidate];
    self.stopWatchTimer = nil;
    [self updateTimer];
}


-(IBAction)onResetPressed:(id)sender{
    
    [self.stopWatchTimer invalidate];
    
    self.stopWatchTimer = nil;
    
    self.timerLabel.text = @"00:00:00.000";
    
}

- (IBAction)onStartPressed:(id)sender {
    self.startDate = [NSDate date];
    
    // Create the stop watch timer that fires every 100 ms
    self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];
}

     
- (void)updateTimer
{
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // Format the elapsed time and set it to the label
    
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    
    
    self.timerLabel.text = timeString;
}



-(NSMutableArray *)getRandomNumbers {
    
        NSMutableArray *listOfNumbers = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < MAX_NUM ; ++i) {
            [listOfNumbers addObject:[NSNumber numberWithInt:i]];
        }
        NSMutableArray *uniqueNumbers = [[NSMutableArray alloc] init];
        int r;
        while ([uniqueNumbers count] < MAX_NUM) {
            r = arc4random() % [listOfNumbers count];
            if (![uniqueNumbers containsObject:[listOfNumbers objectAtIndex:r]]) {
                [uniqueNumbers addObject:[listOfNumbers objectAtIndex:r]];
            }
        }
    
    
    NSUInteger i = 0;
    
    for (i = 1; i < MAX_NUM ; i++) {
        
        NSLog(@"RandomNumber:%d ",(int)[[uniqueNumbers objectAtIndex:i] integerValue]);
        
    }
    
    
    return uniqueNumbers;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RandomNumbers =  [self getRandomNumbers];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
