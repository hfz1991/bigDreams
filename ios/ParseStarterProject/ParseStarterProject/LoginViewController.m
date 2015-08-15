//
//  LoginViewController.m
//  ParseStarterProject
//
//  Created by Fangzhou He on 15/08/2015.
//
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButton:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Account"];
    [query whereKey:@"username" equalTo:_usernameText.text];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
        NSLog(@"RETURNED USERNAME:%@",[object objectForKey:@"username"]);
        NSLog(@"RETURNED PASSWORD:%@",[object objectForKey:@"password"]);
    }];
    
}
@end
