//
//  TSBackBarButtonItem.m
//  BackButtons
//
//  Created by Nick Hodapp on 3/21/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import "TSBackBarButtonItem.h"

@implementation TSBackBarButtonItem

- (id) initWithTitle: (NSString *) title target: (id) target action: (SEL)action
{
    UIButton* b = [UIButton buttonWithType: UIButtonTypeCustom];
    
    UIImage* normalImage = [[UIImage imageNamed:@"UINavigationBarDefaultBack"] resizableImageWithCapInsets: UIEdgeInsetsMake(0, 15, 0, 5)];
    
    UIImage* highlightedImage = [[UIImage imageNamed:@"UINavigationBarDefaultBackPressed"] resizableImageWithCapInsets: UIEdgeInsetsMake(0, 15, 0, 5)];
            
    [b setBackgroundImage: normalImage forState:UIControlStateNormal];
    
    [b setBackgroundImage: highlightedImage forState:UIControlStateHighlighted];
    
    [b setTitle: title forState: UIControlStateNormal];

    [b.titleLabel setFont: [UIFont boldSystemFontOfSize: [UIFont smallSystemFontSize]]];

    [b setTitleEdgeInsets: UIEdgeInsetsMake( 0, 10, 0, 5 )];

    [b sizeToFit];
    
    CGRect r = b.frame;
    r.size.width += 20;
    b.frame = r;
    
    [b addTarget: self action: @selector( onPress: ) forControlEvents: UIControlEventTouchUpInside];
    
    self = [super initWithCustomView: b];
    if ( nil != self )
    {
        [super setTarget: target];
        [super setAction: action];
    }
    return self;
}

- (id) initWithCoder: (NSCoder *) aDecoder
{
    UIBarButtonItem* bbi = [[UIBarButtonItem alloc] initWithCoder: aDecoder];
    
    return [self initWithTitle: bbi.title target: bbi.target action: bbi.action];
}

- (void) onPress: (UIButton*) sender 
{
    if ( nil == self.target || NULL == self.action )
        return;
    
    // $ why not use performSelector?  because of the performSelector leak warning when the selector is dynamically specified...
    
    NSMethodSignature * methodSig = [[self.target class]
                                       instanceMethodSignatureForSelector: self.action];
    
    NSInvocation * invocation = [NSInvocation
                                   invocationWithMethodSignature: methodSig];
    
    [invocation setTarget: self.target];
    
    [invocation setSelector: self.action];
    
    NSString* selector = NSStringFromSelector( self.action );
    if ( [selector hasSuffix: @":" ] )
    {
        TSBackBarButtonItem* self_param = self;
        [invocation setArgument: &self_param atIndex:2];
    }

    [invocation invoke];
}

- (NSString*) title
{
    UIButton* b = (UIButton*)self.customView;
    
    return [b titleForState: UIControlStateNormal];
}

- (void) setTitle:(NSString *)title
{
    // does nothing since we're customView
    //[super setTitle: title]; 
    
    UIButton* b = (UIButton*)self.customView;

    [b setTitle: title forState: UIControlStateNormal];

    [b sizeToFit];
    
    CGRect r = b.frame;
    r.size.width += 20;
    b.frame = r;
    
    self.width = r.size.width;
}

@end


@implementation UIBarButtonItem (TS)

+ (UIBarButtonItem*) backBarButtonItemWithTitle: (NSString *) title target: (id) target action: (SEL) action
{
    return [[TSBackBarButtonItem alloc] initWithTitle: title target: target action: action];
}

- (id) initWithBackButtonShapeTitle: (NSString *) title target: (id) target action: (SEL) action
{
    // replace self with new object:
    self = [[TSBackBarButtonItem alloc] initWithTitle: title target: target action: action];
    
    return self;
}

@end
