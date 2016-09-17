//
//  InputModel.m
//  CashierLine
//
//  Created by Punit Kulkarni on 9/13/16.
//  Copyright © 2016 Punit Kulkarni. All rights reserved.
//

#import "CustomerModel.h"

@implementation CustomerModel

- (instancetype)initWithType:(CustomerType)type startTime:(NSUInteger)time andNumberOfItems:(NSUInteger)numberOfItems {
    
    if (self = [super init]) {
        _type = type;
        _startTime = time;
        _numberOfItems = numberOfItems;
    }
    
    return self;
}
@end
