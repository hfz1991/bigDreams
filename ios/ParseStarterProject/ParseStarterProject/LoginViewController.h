//
//  LoginViewController.h
//  ParseStarterProject
//
//  Created by Fangzhou He on 15/08/2015.
//
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

- (IBAction)loginButton:(id)sender;
@end
