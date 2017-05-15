//
//  DeviceViewController.h
//  MyStore
//
//  Created by Bhavin Gupta on 16/12/16.
//  Copyright © 2016 Bhavin Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "DeviceDetailViewController.h"

@interface DeviceViewController : UITableViewController

@property (strong) NSMutableArray *devices;
@property (strong, nonatomic) IBOutlet UILabel *lblNoDevice;

@end
