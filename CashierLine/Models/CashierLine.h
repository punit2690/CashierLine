//
//  CounterModel.h
//  CashierLine
//
//  Created by Punit Kulkarni on 9/17/16.
//  Copyright © 2016 Punit Kulkarni. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Customer;

@interface CashierLine:NSObject

@property (nonatomic, assign) BOOL isTrainingCashier;

//Current time is set via Grocery Store whenever new customer arrives, before adding him we perform updates 
- (void)performUpdatesTillTime:(NSUInteger)currentTime;
- (NSUInteger)numberOfCustomersInLine;
- (NSUInteger)numberOfItemsForLastCustomer;
- (void)addCustomer:(Customer *)customerModel;
- (NSUInteger)totalTime;
- (instancetype)initCashierIsTraining:(BOOL)isTrainingCahier;

@end
