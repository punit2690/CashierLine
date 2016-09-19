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
    self.customer = nil;
}

- (void)setCustomer:(Customer *)customer {
    _customer = customer;
    self.customerTypeLabel.text = (customer)? (customer.type == CustomerTypeA)? @"A" : @"B" : @"";
    self.timeLabel.text = [NSString stringWithFormat:@"%lu", customer.startTime];
    self.numberOfItemsLabel.text = [NSString stringWithFormat:@"%lu", customer.numberOfItems];
}
@end
