//
//  AppDelegate.h
//  ProjetoSecreto
//
//  Created by Cast Group on 05/01/18.
//  Copyright © 2018 Sig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

