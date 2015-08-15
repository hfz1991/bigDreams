//
//  LoginViewController.m
//  ParseStarterProject
//
//  Created by Fangzhou He on 15/08/2015.
//
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <JGProgressHUD/JGProgressHUD.h>//;

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
    __block NSString *passwordFromServer;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Account"];
    [query whereKey:@"username" equalTo:_usernameText.text];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
        passwordFromServer = (NSString *)[object objectForKey:@"password"];
        NSLog(@"RETURNED USERNAME:%@ RETURNED PASSWORD:%@",[object objectForKey:@"username"],passwordFromServer);
        NSLog(@"Typed password:%@", _passwordText.text);
        if(object == nil){
            JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
            HUD.textLabel.text = @"Error: Username";
            HUD.indicatorView = [[JGProgressHUDErrorIndicatorView alloc] init]; //JGProgressHUDSuccessIndicatorView is also available
            [HUD showInView:self.view];
            [HUD dismissAfterDelay:2.0];
        }
        else if(![passwordFromServer isEqualToString:_passwordText.text]){
            JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
            HUD.textLabel.text = @"Error: Password";
            HUD.indicatorView = [[JGProgressHUDErrorIndicatorView alloc] init]; //JGProgressHUDSuccessIndicatorView is also available
            [HUD showInView:self.view];
            [HUD dismissAfterDelay:2.0];
        }
        else{
            JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
            HUD.textLabel.text = @"Success!";
            HUD.indicatorView = [[JGProgressHUDSuccessIndicatorView alloc] init]; //JGProgressHUDSuccessIndicatorView is also available
            [HUD showInView:self.view];
            [HUD dismissAfterDelay:2.0];
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(loginSuccess:) userInfo:nil repeats:NO];
        }
    }];
    
}

- (void)loginSuccess: (id)sender{
    [self performSegueWithIdentifier:@"login" sender:self];
}

@end
