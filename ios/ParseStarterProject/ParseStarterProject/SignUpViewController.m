//
//  SignUpViewController.m
//  ParseStarterProject
//
//  Created by Fangzhou He on 15/08/2015.
//
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import <JGProgressHUD/JGProgressHUD.h>//;

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
    PFQuery *query = [PFQuery queryWithClassName:@"Account"];
    [query whereKey:@"username" equalTo:_usernameText.text];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
        
        if(object == nil){
            PFObject *accountObject = [PFObject objectWithClassName:@"Account"];
            accountObject[@"username"] = _usernameText.text;
            accountObject[@"password"] = _passwordText.text;
            [accountObject saveInBackground];
            JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
            HUD.textLabel.text = @"SignUp Success!";
            HUD.indicatorView = [[JGProgressHUDSuccessIndicatorView alloc] init]; //JGProgressHUDSuccessIndicatorView is also available
            [HUD showInView:self.view];
            [HUD dismissAfterDelay:2.0];
        }
        else{
            JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
            HUD.textLabel.text = @"Error: Username already exist!";
            HUD.indicatorView = [[JGProgressHUDErrorIndicatorView alloc] init]; //JGProgressHUDSuccessIndicatorView is also available
            [HUD showInView:self.view];
            [HUD dismissAfterDelay:2.0];
        }
    }];

    
    
    
}
@end
