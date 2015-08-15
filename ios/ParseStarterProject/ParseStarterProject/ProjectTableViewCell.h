//
//  ProjectTableViewCell.h
//  ParseStarterProject
//
//  Created by Fangzhou He on 15/08/2015.
//
//

#import <UIKit/UIKit.h>

@interface ProjectTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *projectTitle;
@property (weak, nonatomic) IBOutlet UILabel *projectDescription;
@property (weak, nonatomic) IBOutlet UILabel *projectGoal;
@property (weak, nonatomic) IBOutlet UIImageView *projectImage;
@property (weak, nonatomic) IBOutlet UIProgressView *projectGoalProgressView;

@end
