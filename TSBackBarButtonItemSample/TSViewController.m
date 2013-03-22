//
//  TSViewController.m
//  TSBackBarButtonItemSample
//
//  Created by Nick Hodapp on 3/21/13.
//  Copyright (c) 2013 CoDeveloper LLC. All rights reserved.
//

#import "TSViewController.h"
#import "TSBackBarButtonItem.h"

@interface TSViewController ()

@end

@implementation TSViewController
{
    IBOutlet UILabel* _label;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem* a = [[UIBarButtonItem alloc] initWithBackButtonShapeTitle: @"Category" target: self action: @selector( onPress: )];
    
    TSBackBarButtonItem* b = [[TSBackBarButtonItem alloc] initWithBackButtonShapeTitle: @"TSBackBarButtonItem" target: self action: @selector( onPress: )];
    
    NSMutableArray* items = [self.toolbarItems mutableCopy];
    [items addObjectsFromArray: @[ a, b ]];
    [self setToolbarItems: items];
}

- (IBAction) onPress: (UIBarButtonItem*) sender
{
    _label.text = [NSString stringWithFormat: @"You pressed '%@'", sender.title];
}

@end
