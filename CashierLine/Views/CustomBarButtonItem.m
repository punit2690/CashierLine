//
//  CustomBarButtonItem.m
//  CashierLine
//
//  Created by Punit Kulkarni on 9/17/16.
//  Copyright © 2016 Punit Kulkarni. All rights reserved.
//

#import "CustomBarButtonItem.h"

@implementation CustomBarButtonItem

- (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action {
    self = [super initWithTitle:title
                          style:style
                         target:target
                         action:action];
    [self setTitleTextAttributes:[self getAttributes] forState:UIControlStateNormal];
    return self;
}

- (NSDictionary *)getAttributes {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    return @{NSFontAttributeName:font};
}

@end
