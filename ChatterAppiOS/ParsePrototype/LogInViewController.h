//
//  LogInViewController.h
//  ParsePrototype
//
//  Created by Alex French on 4/26/15.
//  Copyright (c) 2015 french.chagrin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *areaCode;
@property (weak, nonatomic) IBOutlet UITextField *firstThree;
@property (weak, nonatomic) IBOutlet UITextField *lastFour;
@property (weak, nonatomic) IBOutlet UITextField * password;

- (IBAction)login:(id)sender;

@end