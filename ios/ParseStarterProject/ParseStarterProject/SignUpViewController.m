//
//  SignUpViewController.m
//  ParseStarterProject
//
//  Created by Fangzhou He on 15/08/2015.
//
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()

@end

@implementation SignUpViewController

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

- (IBAction)signup:(id)sender {
    PFObject *accountObject = [PFObject objectWithClassName:@"Account"];
    accountObject[@"username"] = _usernameText.text;
    accountObject[@"password"] = _passwordText.text;
    [accountObject saveInBackground];
}
@end