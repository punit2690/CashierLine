//
//  AddCustomerViewController.h
//  CashierLine
//
//  Created by Punit Kulkarni on 9/15/16.
//  Copyright © 2016 Punit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customer.h"

@protocol AddCustomerViewControllerDelegate

@required
- (void)addCustomerModel:(Customer *)customer;
- (void)editCustomerModel:(Customer *)customer atIndex:(NSUInteger)index;

@end

@interface AddCustomerViewController : UIViewController

@property (nonatomic, weak) id<AddCustomerViewControllerDelegate> delegate;
@property (nonatomic, strong) Customer *customer;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, assign) NSUInteger customerModelIndex;

@end
