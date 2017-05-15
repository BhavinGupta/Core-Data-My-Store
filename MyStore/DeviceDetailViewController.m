//
//  DeviceDetailViewController.m
//  MyStore
//
//  Created by Bhavin Gupta on 16/12/16.
//  Copyright © 2016 Bhavin Gupta. All rights reserved.
//

#import "DeviceDetailViewController.h"

@interface DeviceDetailViewController ()

@end

@implementation DeviceDetailViewController

@synthesize txtNameField,txtCompanyField,txtVersionsField,device;

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
    
    if (self.device) {
        [self.txtNameField setText:[self.device valueForKey:@"name"]];
        [self.txtVersionsField setText:[self.device valueForKey:@"version"]];
        [self.txtCompanyField setText:[self.device valueForKey:@"company"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Actions Methods
- (IBAction)actionCancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)actionSave:(id)sender{
    if([txtNameField.text length] != 0 && [txtVersionsField.text length] != 0 && [txtCompanyField.text length] != 0){
        NSManagedObjectContext *context = [self managedObjectContext];
        
        if (self.device) {
            // Update existing device
            [self.device setValue:self.txtNameField.text forKey:@"name"];
            [self.device setValue:self.txtVersionsField.text forKey:@"version"];
            [self.device setValue:self.txtCompanyField.text forKey:@"company"];
            
        } else {
            // Create a new device
            NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
            [newDevice setValue:self.txtNameField.text forKey:@"name"];
            [newDevice setValue:self.txtVersionsField.text forKey:@"version"];
            [newDevice setValue:self.txtCompanyField.text forKey:@"company"];
        }
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"My Store" message:@"Please fill all the details before you save your work" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
