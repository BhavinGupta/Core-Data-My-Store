//
//  DeviceViewController.m
//  MyStore
//
//  Created by Bhavin Gupta on 16/12/16.
//  Copyright © 2016 Bhavin Gupta. All rights reserved.
//

#import "DeviceViewController.h"

@interface DeviceViewController ()

@end

@implementation DeviceViewController

#pragma mark - Retrieve the managed object context from the AppDelegate
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    if ([appDelegate performSelector:@selector(persistentContainer)]) {
        context = [appDelegate.persistentContainer viewContext];
    }
    return context;
}

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Device"];
    self.devices = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    if([self.devices count] == 0){
        _lblNoDevice.hidden = NO;
    }
    else{
        _lblNoDevice.hidden = YES;
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.devices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"idCellDevices";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSManagedObject *device = [self.devices objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@", [device valueForKey:@"name"], [device valueForKey:@"version"]]];
    [cell.detailTextLabel setText:[device valueForKey:@"company"]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.devices objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.devices removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        // Updating No Device Label
        if([self.devices count] == 0){
            _lblNoDevice.hidden = NO;
        }
        else{
            _lblNoDevice.hidden = YES;
        }
    }
}

#pragma mark - Sending the Device Information To Details View Controller For Review And Updation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"UpdateDevice"]) {
        NSManagedObject *selectedDevice = [self.devices objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        DeviceDetailViewController *destViewController = segue.destinationViewController;
        destViewController.device = selectedDevice;
    }
}

@end
