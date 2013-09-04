//
//  ViewController.m
//  TestApp
//
//  Created by ssukcha on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "ViewController.h"
#import "NSStringExt.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%d", [@[@"a", @"b", @"c"] isEqualToArray:[@"a b c" split:@" "]]);
    NSLog(@"%@", [@"a b c" split:@" "]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
