//
//  AddCustomerViewController.h
//  CashierLine
//
//  Created by Punit Kulkarni on 9/15/16.
//  Copyright © 2016 Punit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerModel.h"

@protocol AddCustomerViewControllerDelegate

@required
- (void)addCustomerModel:(CustomerModel *)customerModel;
- (void)editCustomerModel:(CustomerModel *)customerModel atIndex:(NSUInteger)index;

@end

@interface AddCustomerViewController : UIViewController

@property (nonatomic, weak) id<AddCustomerViewControllerDelegate> delegate;
@property (nonatomic, strong) CustomerModel *customerModel;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, assign) NSUInteger customerModelIndex;

@end
