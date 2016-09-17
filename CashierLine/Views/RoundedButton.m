//
//  RoundedButton.m
//  CashierLine
//
//  Created by Punit Kulkarni on 9/10/16.
//  Copyright © 2016 Punit Kulkarni. All rights reserved.
//

#import "RoundedButton.h"

@implementation RoundedButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    self.clipsToBounds = YES;
}

- (void)setCornerRadiusValue:(NSUInteger)cornerRadiusValue {
    self.layer.cornerRadius = cornerRadiusValue;
}
@end
