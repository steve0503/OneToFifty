//
//  ViewController.m
//  OneToFifty
//
//  Created by SDT-1 on 2014. 1. 22..
//  Copyright (c) 2014년 Maybe There. All rights reserved.
//

#import "ViewController.h"

#import "NumberCell.h"

#define MAX_NUM 25


@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{

    NSMutableArray *RandomNumbers;

}



@property (strong, nonatomic) NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate; // Stores the date of the click on the start button


@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

- (IBAction)onStartPressed:(id)sender;
- (IBAction)onStopPressed:(id)sender;
- (IBAction)onResetPressed:(id)sender;

@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}


//DataSource

// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
  
    return 5;
}


// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 5;
}


// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NumberCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"CELL_ID" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    //cell.numberLabel.text = RandomNumbers[indexPath.row];
    
    
      cell.numberLabel.text = [NSString stringWithFormat:@"%d", [[RandomNumbers objectAtIndex:indexPath.row] integerValue]];
    
    //cell.numberLabel.text = ;
    
 //   [[cell numberLabel] setText:RandomNumbers[indexPath.row]];
    
    
    
   // cell.numberLabel.text = @"Text";
    
    return cell;
}




// CollectionViewLayOut

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGSize retval =  CGSizeMake(20, 20);
    
    retval.height += 20;
    
    retval.width += 20;
    
    return retval;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}



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



-(NSMutableArray *)updateRandomNumbers {
    
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
    
    
    
    
    
  //  NSUInteger i = 0;
    
  // for (i = 0; i < MAX_NUM ; i++) {
   
 //       NSLog(@"RandomNumber:%d ",(int)([[uniqueNumbers objectAtIndex:i] integerValue]+1));
        
//    }
    
    
    return uniqueNumbers;
}

-(void)viewWillAppear:(BOOL)animated{
    
       [super viewWillAppear:YES];
    
  
   
    
    [self.collectionView registerClass:[NumberCell class] forCellWithReuseIdentifier:@"CELL_ID"];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
  
    RandomNumbers =  [self updateRandomNumbers];
    
    NSInteger i = 0;
    
    for (i = 0; i < MAX_NUM ; i++) {
    
    NSLog(@"RandomNumber:%d ",(int)([[RandomNumbers objectAtIndex:i] integerValue]+1));
        
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_cork@2x.png"]];
    
    }
    
    
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
