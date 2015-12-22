//
//  ViewController.m
//  Final
//
//  Created by Alejandro Rodriguez on 12/22/15.
//  Copyright © 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ViewController.h"
#import <ParseUI/ParseUI.h>

@interface ViewController () <PFLogInViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    PFLogInViewController *logInController = [[PFLogInViewController alloc] init];
    logInController.fields = (PFLogInFieldsFacebook);
    logInController.delegate = self;
    [self presentViewController:logInController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user{
    NSLog(@"Did log in");
}

-(void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error{
    NSLog(@"Did fail login");
}

@end
