//
//  ViewController.m
//  Final
//
//  Created by Alejandro Rodriguez on 12/22/15.
//  Copyright © 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController () <PFLogInViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;

@property (weak, nonatomic) IBOutlet UILabel *lblWelcome;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    if (![PFUser currentUser]) {
        [self presentLoginViewController];
    }
    else{
        [self updateUI];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user{
    [self updateUI];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error{
    NSLog(@"Did fail login");
}
- (IBAction)didLogout:(id)sender {
    
    __weak ViewController *weakSelf = self;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        [weakSelf presentLoginViewController];
    }];
    
}

-(void) updateUI{
    
    [self.lblWelcome setText: NSLocalizedString(([NSString stringWithFormat:@"Bienvenido %@", [[PFUser currentUser] objectForKey:@"name"]]), nil)];
    [self.lblMessage setText:NSLocalizedString(@"Este es el trabajo final de Alejandro Rodríguez", nil)];
    self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.width/2;
    [self.imgProfile.layer setMasksToBounds:YES];
   
    
    
    __weak ViewController *weakSelf = self;
    [PFCloud callFunctionInBackground:@"facebookInfo" withParameters:nil block:^(id  _Nullable object, NSError * _Nullable error) {
        NSString * userID = [object objectForKey:@"id"] ;
        NSString *name = [object objectForKey:@"name"];
        [weakSelf.imgProfile sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=normal",userID]]];
        
        
        [[PFUser currentUser] setObject:name forKey:@"name"];
        [[PFUser currentUser] saveInBackground];
    }];

    
}

-(void) presentLoginViewController{
    PFLogInViewController *logInController = [[PFLogInViewController alloc] init];
    logInController.fields = (PFLogInFieldsFacebook);
    logInController.delegate = self;
    [self presentViewController:logInController animated:YES completion:nil];

}

@end
