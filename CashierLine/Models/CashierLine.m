//
//  CounterModel.m
//  CashierLine
//
//  Created by Punit Kulkarni on 9/17/16.
//  Copyright © 2016 Punit Kulkarni. All rights reserved.
//

#import "CashierLine.h"
#import "Customer.h"

@interface CashierLine()

@property (nonatomic, strong) NSMutableArray *customersArray;
@property (nonatomic, assign) NSUInteger currentTime;

@end

@implementation CashierLine

- (instancetype)initCashierIsTraining:(BOOL)isTrainingCahier {
    
    if (self = [super init]) {
        _isTrainingCashier = isTrainingCahier;
        _customersArray = [NSMutableArray new];
    }
    return self;
}

- (NSUInteger)numberOfCustomersInLine {
    return self.customersArray.count;
}

- (NSUInteger)numberOfItemsForLastCustomer {
    
    if (self.customersArray.count) {
        Customer *lastCustomerInLine = self.customersArray.lastObject;
        return lastCustomerInLine.remainingNumberOfItems;
    }
    
    return -1;
}

- (void)addCustomer:(Customer *)customer {
    customer.scheduledCheckoutBeginTime = self.totalTime;
    [self.customersArray addObject:customer];
}

- (NSUInteger)totalTime {
    
    NSUInteger totalTime = self.currentTime;
    for (Customer *customer in self.customersArray) {
        totalTime += customer.remainingNumberOfItems * ((self.isTrainingCashier)?2:1);
    }
    
    return totalTime;
}

- (void)performUpdatesTillTime:(NSUInteger)currentTime {
    
    NSMutableArray *objectsToBeDeleted = [NSMutableArray new];

    for (NSUInteger i=0; i<self.customersArray.count; i++) {
        
        Customer *customer = self.customersArray[i];
        BOOL isStillInLine = [customer performUpdatesTillTime:currentTime isInTrainingLine:self.isTrainingCashier];
        if (!isStillInLine) {
            [objectsToBeDeleted addObject:customer];
        }
    }
    
    [self.customersArray removeObjectsInArray:objectsToBeDeleted];
    _currentTime = currentTime;
}

@end
