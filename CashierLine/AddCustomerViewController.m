//
//  AddCustomerViewController.m
//  CashierLine
//
//  Created by Punit Kulkarni on 9/15/16.
//  Copyright © 2016 Punit Kulkarni. All rights reserved.
//

#import "AddCustomerViewController.h"
#import "RoundedButton.h"
#import "CustomBarButtonItem.h"

@interface AddCustomerViewController ()

@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberOfItemsTextField;
@property (weak, nonatomic) IBOutlet RoundedButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *customerTypeSegmentedControl;

@end

@implementation AddCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isEditing) {
        self.closeButton.hidden = YES;
        [self.addButton setTitle:@"Confirm" forState:UIControlStateNormal];
        self.timeTextField.text = [NSString stringWithFormat:@"%lu", self.customer.startTime];
        self.numberOfItemsTextField.text = [NSString stringWithFormat:@"%lu", self.customer.numberOfItems];
        self.customerTypeSegmentedControl.selectedSegmentIndex = (self.customer.type == CustomerTypeA)? 0 : 1;
    } else {
        self.closeButton.hidden = NO;
        self.customer = [[Customer alloc] initWithType:CustomerTypeA
                                             startTime:0
                                      andNumberOfItems:0];
    }
}

- (void)dismissKeyboard {
    [self.timeTextField resignFirstResponder];
    [self.numberOfItemsTextField resignFirstResponder];
}

- (IBAction)dissmiss:(id)sender {
    if (self.timeTextField.isEditing || self.numberOfItemsTextField.isEditing) {
        [self dismissKeyboard];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)addCustomer:(id)sender {
    
    if (self.timeTextField.text.length && self.numberOfItemsTextField.text.length) {
        self.customer.startTime = self.timeTextField.text.integerValue;
        self.customer.numberOfItems = self.numberOfItemsTextField.text.integerValue;

        if (self.isEditing) {
            [self.delegate editCustomerModel:self.customer
                                     atIndex:self.customerModelIndex];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            [self.delegate addCustomerModel:self.customer];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    else {
        UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"Invalid input"
                                                                                message:@"None of the fields can be left blank"
                                                                         preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alerController
                           animated:YES
                         completion:nil];
    }
}

- (IBAction)customerTypeChanged:(UISegmentedControl *)sender {
    self.customer.type = (sender.selectedSegmentIndex == 1)? CustomerTypeB:CustomerTypeA;
}

- (IBAction)textfieldDidEndEditing:(id)sender {
    if (!self.isEditing) {
        self.closeButton.hidden = NO;
        [self.closeButton setTitle:@"Close"
                          forState:UIControlStateNormal];
    }
    else {
        self.navigationItem.rightBarButtonItems = @[];
    }
}

- (IBAction)textfieldDidBeginEditing:(id)sender {
    
    if (!self.isEditing) {
        self.closeButton.hidden = NO;
        [self.closeButton setTitle:@"Done"
                          forState:UIControlStateNormal];
    }
    else {
        [self setDoneButton];
    }
}

- (void)setDoneButton {
    CustomBarButtonItem *rightBarButtonItem = [[CustomBarButtonItem alloc] initWithTitle:@"Done"
                                                                                   style:UIBarButtonItemStyleDone
                                                                                  target:self
                                                                                  action:@selector(dismissKeyboard)];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
}

@end
