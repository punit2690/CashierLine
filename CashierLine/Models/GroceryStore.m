//
//  GroceryStoreModel.m
//  CashierLine
//
//  Created by Punit Kulkarni on 9/17/16.
//  Copyright © 2016 Punit Kulkarni. All rights reserved.
//

#import "GroceryStore.h"
#import "CashierLine.h"

@interface GroceryStore()

@property (nonatomic, assign) NSUInteger numberOfCounters;
@property (nonatomic, strong) NSMutableArray *cashierArray;
@property (nonatomic, copy) NSArray *customers;
@end

@implementation GroceryStore

- (instancetype)initWithNumberofCounters:(NSUInteger)numberOfCounters andCustomers:(NSArray *)customers {
    
    if (self = [super init]) {
        
        _numberOfCounters = numberOfCounters;
        _cashierArray = [NSMutableArray new];
        
        NSMutableArray *customersArray = customers.mutableCopy;
        [customersArray sortUsingDescriptors:
         @[
           [NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:YES],
           [NSSortDescriptor sortDescriptorWithKey:@"numberOfItems" ascending:YES],
           [NSSortDescriptor sortDescriptorWithKey:@"type" ascending:YES],
        ]];
        self.customers = customersArray.copy;
        
        for (NSUInteger i=0; i<numberOfCounters; i++) {
            
            CashierLine *cashierLine = [[CashierLine alloc] initCashierIsTraining:(numberOfCounters-i==1)];
            [self.cashierArray addObject:cashierLine];
        }
        
        for (Customer *customer in self.customers) {
            
            for (CashierLine *line in self.cashierArray) {
                [line performUpdatesTillTime:customer.startTime];
            }
            
            if (customer.type == CustomerTypeA) {
                NSUInteger lineForCustomerA = [self getShortestLine];
                CashierLine *line = self.cashierArray[lineForCustomerA];
                [line addCustomer:customer];
                NSLog(@"Customer %lu with begin time %lu assigned to register %lu", customer.type, customer.startTime, lineForCustomerA);
            }
            else {
                NSUInteger lineForCustomerB = [self getLineWithLeastItemForLastCustomer];
                CashierLine *line = self.cashierArray[lineForCustomerB];
                [line addCustomer:customer];
                NSLog(@"Customer %lu with begin time %lu assigned to register %lu", customer.type, customer.startTime, lineForCustomerB);

            }
        }
    }
    return self;
}

- (void)addCustomer:(Customer *)customer {
    
    for (CashierLine *line in self.cashierArray) {
        [line performUpdatesTillTime:customer.startTime];
    }
}

- (NSUInteger)finishTime {

    NSUInteger highestFinishTime = 0;
    for (CashierLine *line in self.cashierArray) {
        if (line.totalTime > highestFinishTime) {
            highestFinishTime = line.totalTime;
        }
    }
    return highestFinishTime;
}

//This method is used to add Customer Type A
- (NSUInteger)getShortestLine {
    
    NSUInteger lineNumberToUse = 0;
    
    if (self.cashierArray.count) {
        
        CashierLine *lineToUse = self.cashierArray[lineNumberToUse];

        for (NSUInteger i=1;i<self.cashierArray.count;i++) {
            //We make an assumtion here that Customer type A wont prefer to join an empty line since it hasn't been explicitely mentioned as in the case of Cutomer type B
            CashierLine *line = self.cashierArray[i];
            if ((line.numberOfCustomersInLine > 0) && line.numberOfCustomersInLine < lineToUse.numberOfCustomersInLine) {
                lineToUse = line;
                lineNumberToUse = i;
            }
        }
    }
    
    return lineNumberToUse;
}

//This method is used to add Customer Type B
- (NSUInteger)getLineWithLeastItemForLastCustomer {
    
    NSUInteger lineNumberToUse = 0;
    
    if (self.cashierArray.count) {
        
        CashierLine *lineToUse = self.cashierArray[lineNumberToUse];
        
        if (lineToUse.numberOfCustomersInLine) {
            for (NSUInteger i=1;i<self.cashierArray.count;i++) {
                CashierLine *line = self.cashierArray[i];
                if (line.numberOfCustomersInLine == 0 ) {
                    lineToUse = line;
                    lineNumberToUse = i;
                    break;
                }
                else {
                    if (line.numberOfItemsForLastCustomer < lineToUse.numberOfItemsForLastCustomer) {
                        lineNumberToUse = i;
                        lineToUse = line;
                    }
                }
            }
        }
    }
    
    return lineNumberToUse;
}

@end
