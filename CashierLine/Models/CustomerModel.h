//
//  InputModel.h
//  CashierLine
//
//  Created by Punit Kulkarni on 9/13/16.
//  Copyright © 2016 Punit Kulkarni. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CustomerType) {
    CustomerTypeA,
    CustomerTypeB
};

@interface CustomerModel : NSObject

@property (nonatomic, assign) NSUInteger startTime;
@property (nonatomic, assign) NSUInteger numberOfItems;
@property (nonatomic, assign) CustomerType type;

- (instancetype)initWithType:(CustomerType)type
                   startTime:(NSUInteger)time
            andNumberOfItems:(NSUInteger)numberOfItems;
@end
