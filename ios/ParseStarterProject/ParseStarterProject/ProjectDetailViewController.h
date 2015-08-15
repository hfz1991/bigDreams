//
//  ProjectDetailViewController.h
//  ParseStarterProject
//
//  Created by Fangzhou He on 16/08/2015.
//
//

#import <UIKit/UIKit.h>

@interface ProjectDetailViewController : UIViewController
@property NSString *username;
@property NSString *projectID;
@property (weak, nonatomic) IBOutlet UIImageView *projectImage;
@property (weak, nonatomic) IBOutlet UILabel *projectTitle;
@property (weak, nonatomic) IBOutlet UITextView *projectDescrition;
@property (weak, nonatomic) IBOutlet UILabel *voteLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectGoalLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *projectProgress;
@property (weak, nonatomic) IBOutlet UILabel *voteUserRemaining;
- (IBAction)voteButton:(id)sender;
@end
