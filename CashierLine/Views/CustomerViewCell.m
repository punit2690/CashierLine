//
//  InputViewCell.m
//  CashierLine
//
//  Created by Punit Kulkarni on 9/13/16.
//  Copyright © 2016 Punit Kulkarni. All rights reserved.
//

#import "CustomerViewCell.h"

@interface CustomerViewCell()

@property (weak, nonatomic) IBOutlet UILabel *customerTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfItemsLabel;

@end

@implementation CustomerViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)prepareForReuse {
    self.customerModel = nil;
}

- (void)setCustomerModel:(CustomerModel *)customerModel {
    _customerModel = customerModel;
    self.customerTypeLabel.text = (customerModel)? (customerModel.type == CustomerTypeA)? @"A" : @"B" : @"";
    self.timeLabel.text = [NSString stringWithFormat:@"%lu", customerModel.startTime];
    self.numberOfItemsLabel.text = [NSString stringWithFormat:@"%lu", customerModel.numberOfItems];
}
@end
