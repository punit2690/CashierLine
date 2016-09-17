//
//  ViewController.m
//  CashierLine
//
//  Created by Punit Kulkarni on 9/10/16.
//  Copyright © 2016 Punit Kulkarni. All rights reserved.
//

#import "CashierLineViewController.h"
#import "CustomerViewCell.h"
#import "CustomerModel.h"
#import "AddCustomerViewController.h"
#import "CustomBarButtonItem.h"

@interface CashierLineViewController ()<UITableViewDelegate, UITableViewDataSource, AddCustomerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray *customerArray;
@property (strong, nonatomic) CustomerModel *selectedCustomer;

@end

@implementation CashierLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    CustomerModel *one = [[CustomerModel alloc] initWithType:CustomerTypeA
                                             startTime:3
                                      andNumberOfItems:4];
    CustomerModel *two = [[CustomerModel alloc] initWithType:CustomerTypeB
                                             startTime:1
                                      andNumberOfItems:5];
    CustomerModel *three = [[CustomerModel alloc] initWithType:CustomerTypeA
                                             startTime:8
                                      andNumberOfItems:5];
    CustomerModel *four = [[CustomerModel alloc] initWithType:CustomerTypeB
                                             startTime:2
                                      andNumberOfItems:9];
    CustomerModel *five = [[CustomerModel alloc] initWithType:CustomerTypeA
                                             startTime:9
                                      andNumberOfItems:1];
    self.customerArray = @[one, two, three, four, five];
    [self.tableView reloadData];
    [self setAddButton];
}

#pragma mark - UITableView DataSource/Delegate methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomerViewCell *customerViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    CustomerModel *customerModel = [self.customerArray objectAtIndex:indexPath.row];
    customerViewCell.customerModel = customerModel;
    
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
        NSMutableArray *array = [NSMutableArray arrayWithArray:self.customerArray];
        [array removeObjectAtIndex:indexPath.row];
        self.customerArray = array.copy;
        [self.tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedCustomer = [self.customerArray objectAtIndex:indexPath.row];
    [self goToEditCustomerVC];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - AddCustomerVCDelegate

- (void)addCustomerModel:(CustomerModel *)customerModel {
    NSMutableArray *mutableArray = [self.customerArray mutableCopy];
    [mutableArray addObject:customerModel];
    self.customerArray = mutableArray.copy;
    [self.tableView reloadData];
}

- (void)editCustomerModel:(CustomerModel *)customerModel atIndex:(NSUInteger)index {
    NSMutableArray *mutableArray = [self.customerArray mutableCopy];
    [mutableArray replaceObjectAtIndex:index withObject:customerModel];
    self.customerArray = mutableArray.copy;
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
        addCustomerVC.customerModel = self.selectedCustomer;
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
