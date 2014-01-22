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

@end

@implementation ViewController


-(NSMutableArray *)getRandomNumbers {
    
        NSMutableArray *listOfNumbers = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < MAX_NUM ; ++i) {
            [listOfNumbers addObject:[NSNumber numberWithInt:i]];
        }
        NSMutableArray *uniqueNumbers = [[NSMutableArray alloc] init];
        int r;
        while ([uniqueNumbers count] < 25) {
            r = arc4random() % [listOfNumbers count];
            if (![uniqueNumbers containsObject:[listOfNumbers objectAtIndex:r]]) {
                [uniqueNumbers addObject:[listOfNumbers objectAtIndex:r]];
            }
        }
    
    
    NSUInteger i = 0;
    
    for (i = 0; i < 25 ; i++) {
        
        NSLog(@"RandomNumber:%d ",(NSUInteger)[[uniqueNumbers objectAtIndex:i] integerValue]);
        
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
