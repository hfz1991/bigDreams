//
//  BrainTreeViewController.m
//  ParseStarterProject
//
//  Created by Fangzhou He on 15/08/2015.
//
//

#import "BrainTreeViewController.h"
#import <Parse/Parse.h>
#import <JGProgressHUD/JGProgressHUD.h>//;

@interface BrainTreeViewController ()<BTDropInViewControllerDelegate>{
    NSNumber *currentUserVote;
}

@end

@implementation BrainTreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    // Do any additional setup after loading the view.
    self.manager = [AFHTTPRequestOperationManager manager];
    [self getToken];
}

- (void)getToken {
    [self.manager GET:@"http://692198eb.ngrok.io/token"
           parameters: nil
              success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                  self.clientToken = responseObject[@"clientToken"];
                  self.startPaymentButton.enabled = TRUE;
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"Error: %@", error);
              }];
}

- (IBAction)startPayment:(id)sender {
    Braintree *braintree = [Braintree braintreeWithClientToken:self.clientToken];
    BTDropInViewController *dropInViewController = [braintree dropInViewControllerWithDelegate:self];
    
    dropInViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                                             initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                             target:self
                                                             action:@selector(userDidCancelPayment)];
    
    //Customize the UI
    dropInViewController.summaryTitle = @"Donate to dream big";
    dropInViewController.summaryDescription = @"For every dollor you get a vote on project";
    dropInViewController.displayAmount = @"$10";
    
    
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:dropInViewController];
    [self presentViewController:navigationController
                       animated:YES
                     completion:nil];
    
    
}

- (void)dropInViewController:(__unused BTDropInViewController *)viewController didSucceedWithPaymentMethod:(BTPaymentMethod *)paymentMethod {
    [self postNonceToServer:paymentMethod.nonce];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dropInViewControllerDidCancel:(__unused BTDropInViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) userDidCancelPayment{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark POST NONCE TO SERVER method
- (void)postNonceToServer:(NSString *)paymentMethodNonce {
    [self.manager POST:@"http://692198eb.ngrok.io/payment"
            parameters:@{@"payment_method_nonce": paymentMethodNonce}
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   NSString *transactionID = responseObject[@"transaction"][@"id"];
                   self.transactionIDLabel.text = [[NSString alloc] initWithFormat:@"Transaction ID: %@", transactionID];
                   
                   //
                   PFQuery *query2 = [PFQuery queryWithClassName:@"Account"];
                   [query2 whereKey:@"username" equalTo:_username];
                   [query2 getFirstObjectInBackgroundWithBlock:^(PFObject *object2, NSError *error){
                       currentUserVote = [object2 objectForKey:@"votesRemaining"];
                       
                       int currentUserVoteValue = [currentUserVote intValue];
                       NSNumber *postUserVote = [NSNumber numberWithInt:currentUserVoteValue+10];
                       
                       PFQuery *query = [PFQuery queryWithClassName:@"Account"];
                       [query getObjectInBackgroundWithId:_userObjectId block:^(PFObject *object, NSError *error){
                           object[@"votesRemaining"] = postUserVote;
                           [object saveInBackground];
                       }];
                   }];
                   
                   
                   //
                   JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
                   HUD.textLabel.text = @"Success! 10 votes Added.";
                   HUD.indicatorView = [[JGProgressHUDSuccessIndicatorView alloc] init]; //JGProgressHUDSuccessIndicatorView is also available
                   [HUD showInView:self.view];
                   [HUD dismissAfterDelay:2.0];
               }
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   NSLog(@"Error: %@", error);
               }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
