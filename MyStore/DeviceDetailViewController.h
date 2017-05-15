//
//  DeviceDetailViewController.h
//  MyStore
//
//  Created by Bhavin Gupta on 16/12/16.
//  Copyright © 2016 Bhavin Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface DeviceDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtNameField;
@property (weak, nonatomic) IBOutlet UITextField *txtVersionsField;
@property (weak, nonatomic) IBOutlet UITextField *txtCompanyField;
@property (strong) NSManagedObject *device;

- (IBAction)actionCancel:(id)sender;
- (IBAction)actionSave:(id)sender;

@end
