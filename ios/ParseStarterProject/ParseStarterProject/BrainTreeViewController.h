//
//  BrainTreeViewController.h
//  ParseStarterProject
//
//  Created by Fangzhou He on 15/08/2015.
//
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "Braintree/Braintree.h"

@interface BrainTreeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *transactionIDLabel;
@property (strong, nonatomic) NSString *clientToken;
@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;
@property (weak, nonatomic) IBOutlet UIButton *startPaymentButton;

@property NSString *username;
@property NSString *userObjectId;

- (IBAction)startPayment:(id)sender;

@end
