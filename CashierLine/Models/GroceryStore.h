//
//  GroceryStoreModel.h
//  CashierLine
//
//  Created by Punit Kulkarni on 9/17/16.
//  Copyright © 2016 Punit Kulkarni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Customer.h"

@interface GroceryStore : NSObject

@property (nonatomic, readonly) NSUInteger finishTime;
- (instancetype)initWithNumberofCounters:(NSUInteger)numberOfCounters andCustomers:(NSArray *)customers;

@end
