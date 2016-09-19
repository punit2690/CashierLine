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

@interface Customer : NSObject<NSCopying>

//This is the time customer enters in Grocery store
@property (nonatomic, assign) NSUInteger startTime;
//This property is set whenever a Customer is added to a queue, it indicates time he is expected to begin checkout in the line he is added to
@property (nonatomic, assign) NSUInteger scheduledCheckoutBeginTime;
@property (nonatomic, assign) NSUInteger numberOfItems;
@property (nonatomic, assign) double remainingNumberOfItems;
@property (nonatomic, assign) CustomerType type;

- (instancetype)initWithType:(CustomerType)type
                   startTime:(NSUInteger)time
            andNumberOfItems:(NSUInteger)numberOfItems;

- (BOOL)performUpdatesTillTime:(NSUInteger)currentTime isInTrainingLine:(BOOL)isInTrainingLine;

@end
