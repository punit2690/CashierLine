//
//  CashierViewController.m
//  CashierLine
//
//  Created by Punit Kulkarni on 9/17/16.
//  Copyright © 2016 Punit Kulkarni. All rights reserved.
//

#import "CashierViewController.h"
#import "CashierLineViewController.h"
#import "CustomBarButtonItem.h"

@interface CashierViewController ()

@property (strong, nonatomic) UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *numberOfLinesTextfield;

@end

@implementation CashierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)beginSimulation:(id)sender {
    [self performSegueWithIdentifier:@"showCashierLineVC" sender:self];
}

#pragma mark - TextField methods

- (void)dismissKeyboard {
    [self.numberOfLinesTextfield resignFirstResponder];
}

- (IBAction)textfieldDidEndEditing:(id)sender {
    self.navigationItem.rightBarButtonItems = @[];
}

- (IBAction)textfieldDidBeginEditing:(id)sender {
    self.numberOfLinesTextfield.text = @"";
    [self addDoneButton];
}

#pragma mark - Miscellaneous

- (void)addDoneButton {
    self.doneButton = [[CustomBarButtonItem alloc] initWithTitle:@"Done"
                                                       style:UIBarButtonItemStyleDone
                                                      target:self
                                                      action:@selector(dismissKeyboard)];
    [self.navigationItem setRightBarButtonItem:self.doneButton];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CashierLineViewController *cashierLineVC = [segue destinationViewController];
    cashierLineVC.numberOfCashierLines = self.numberOfLinesTextfield.text.longLongValue;
}
@end
