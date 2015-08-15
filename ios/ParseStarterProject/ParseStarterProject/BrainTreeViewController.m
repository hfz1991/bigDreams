//
//  BrainTreeViewController.m
//  ParseStarterProject
//
//  Created by Fangzhou He on 15/08/2015.
//
//

#import "BrainTreeViewController.h"

@interface BrainTreeViewController ()<BTDropInViewControllerDelegate>

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
    [self.manager GET:@"http://c8c5e328.ngrok.io/token"
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
    dropInViewController.summaryTitle = @"A Braintree Mug";
    dropInViewController.summaryDescription = @"Enough for a good cup of coffee";
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
    [self.manager POST:@"http://c8c5e328.ngrok.io/payment"
            parameters:@{@"payment_method_nonce": paymentMethodNonce}
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   NSString *transactionID = responseObject[@"transaction"][@"id"];
                   self.transactionIDLabel.text = [[NSString alloc] initWithFormat:@"Transaction ID: %@", transactionID];
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
