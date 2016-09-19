//
//  ViewController.m
//  CashierLine
//
//  Created by Punit Kulkarni on 9/10/16.
//  Copyright © 2016 Punit Kulkarni. All rights reserved.
//

#import "GroceryStoreViewController.h"
#import "CustomerViewCell.h"
#import "Customer.h"
#import "AddCustomerViewController.h"
#import "CustomBarButtonItem.h"
#import "GroceryStore.h"

@interface GroceryStoreViewController ()<UITableViewDelegate, UITableViewDataSource, AddCustomerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *customerArray;
@property (strong, nonatomic) Customer *selectedCustomer;

@end

@implementation GroceryStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    /*Customer *customer1 = [[Customer alloc] initWithType:CustomerTypeA
                                               startTime:1
                                        andNumberOfItems:5];
    Customer *customer2 = [[Customer alloc] initWithType:CustomerTypeB
                                               startTime:2
                                        andNumberOfItems:1];
    Customer *customer3 = [[Customer alloc] initWithType:CustomerTypeA
                                               startTime:3
                                        andNumberOfItems:5];
    Customer *customer4 = [[Customer alloc] initWithType:CustomerTypeB
                                               startTime:5
                                        andNumberOfItems:3];
    Customer *customer5 = [[Customer alloc] initWithType:CustomerTypeA
                                               startTime:8
                                        andNumberOfItems:2];
    self.customerArray = @[customer1, customer2, customer3, customer4, customer5];*/
    
    [self.tableView reloadData];
    [self setAddButton];
}

- (IBAction)calculate:(id)sender {
    
    GroceryStore *groceryStore = [[GroceryStore alloc] initWithNumberofCounters:self.numberOfCashierLines
                                                                   andCustomers:[self.customerArray copy]];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Result"
                                                                   message:[NSString stringWithFormat:@"All customers will be done checking out at t=%lu", groceryStore.finishTime]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Dismiss"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil]];
    
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

#pragma mark - UITableView DataSource/Delegate methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomerViewCell *customerViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    Customer *customer = [self.customerArray objectAtIndex:indexPath.row];
    customerViewCell.customer = customer;
    
    return customerViewCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.customerArray.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.customerArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedCustomer = [self.customerArray objectAtIndex:indexPath.row];
    [self goToEditCustomerVC];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - AddCustomerVCDelegate

- (void)addCustomerModel:(Customer *)customer {
    if (!self.customerArray) {
        self.customerArray = [NSMutableArray new];
    }
    [self.customerArray addObject:customer];
    [self.tableView reloadData];
}

- (void)editCustomerModel:(Customer *)customer atIndex:(NSUInteger)index {
    [self.customerArray replaceObjectAtIndex:index withObject:customer];
    [self.tableView reloadData];
}

#pragma mark - Miscellaneous

- (void)goToAddCustomerVC {
        [self performSegueWithIdentifier:@"addCustomer" sender:self];
}

- (void)goToEditCustomerVC {
    [self performSegueWithIdentifier:@"editCustomer" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    AddCustomerViewController *addCustomerVC = [segue destinationViewController];
    
    if ([segue.identifier isEqualToString:@"editCustomer"]) {
        addCustomerVC.customer = self.selectedCustomer;
        addCustomerVC.isEditing = YES;
        addCustomerVC.customerModelIndex = [self.tableView indexPathForSelectedRow].row;
    }
    
    addCustomerVC.delegate = self;
    [super prepareForSegue:segue sender:sender];
}

- (void)setAddButton {
    CustomBarButtonItem *rightBarButtonItem = [[CustomBarButtonItem alloc] initWithTitle:@"Add"
                                                                           style:UIBarButtonItemStyleDone
                                                                          target:self
                                                                          action:@selector(goToAddCustomerVC)];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
}

@end
