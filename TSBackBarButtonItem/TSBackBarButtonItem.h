//
//  TSBackBarButtonItem.h
//  BackButtons
//
//  Created by Nick Hodapp on 3/21/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSBackBarButtonItem : UIBarButtonItem

- (id) initWithTitle: (NSString *) title target: (id) target action: (SEL) action;

@end


@interface UIBarButtonItem (TS)

+ (UIBarButtonItem*) backBarButtonItemWithTitle: (NSString *) title target: (id) target action: (SEL) action;

- (id) initWithBackButtonShapeTitle: (NSString *) title target: (id) target action: (SEL) action;

@end
