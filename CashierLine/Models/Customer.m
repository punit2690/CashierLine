//
//  InputModel.m
//  CashierLine
//
//  Created by Punit Kulkarni on 9/13/16.
//  Copyright © 2016 Punit Kulkarni. All rights reserved.
//

#import "Customer.h"

@implementation Customer

- (id)copyWithZone:(NSZone *)zone {
    
    Customer *customer = [[Customer alloc] init];
    customer.startTime = self.startTime;
    customer.scheduledCheckoutBeginTime = self.scheduledCheckoutBeginTime;
    customer.numberOfItems = self.numberOfItems;
    customer.type = self.type;
    customer.remainingNumberOfItems = (double)self.remainingNumberOfItems;
    
    return customer;
}

- (instancetype)initWithType:(CustomerType)type startTime:(NSUInteger)time andNumberOfItems:(NSUInteger)numberOfItems {
    
    if (self = [super init]) {
        _type = type;
        _startTime = time;
        _numberOfItems = numberOfItems;
        _remainingNumberOfItems = (double)numberOfItems;
    }
    
    return self;
}

- (BOOL)performUpdatesTillTime:(NSUInteger)currentTime isInTrainingLine:(BOOL)isInTrainingLine {
    
    BOOL isStillInLine = YES;
    
    if (currentTime >= (self.scheduledCheckoutBeginTime + ((isInTrainingLine)?2:1)*self.numberOfItems)) {
        isStillInLine = NO;
    }
    else if (currentTime > self.scheduledCheckoutBeginTime){
        
        double timeSinceCheckoutStarted = ((double)(currentTime-self.scheduledCheckoutBeginTime));
        double checkoutSpeed = (double)((isInTrainingLine)?2:1);
        self.remainingNumberOfItems = self.remainingNumberOfItems - (timeSinceCheckoutStarted/checkoutSpeed);
    }
    
    NSLog(@"Current Time: %lu Customer type: %lu remaining items: %f startTime: %lu scheduledCheckoutBeginTime: %lu", currentTime, self.type, self.remainingNumberOfItems, self.startTime, self.scheduledCheckoutBeginTime);
    return isStillInLine;
}

- (void)setNumberOfItems:(NSUInteger)numberOfItems {
    _numberOfItems = numberOfItems;
    _remainingNumberOfItems = (double)numberOfItems;
}
@end
