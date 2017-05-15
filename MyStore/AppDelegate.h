//
//  AppDelegate.h
//  MyStore
//
//  Created by Bhavin Gupta on 16/12/16.
//  Copyright © 2016 Bhavin Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
+ (AppDelegate *)sharedAppDelegate;

@end

