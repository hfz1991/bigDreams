//
//  ProjectViewController.h
//  ParseStarterProject
//
//  Created by Fangzhou He on 15/08/2015.
//
//

#import <UIKit/UIKit.h>

@interface ProjectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *projectTableView;
@property (weak, nonatomic) IBOutlet UILabel *myVote;
@property NSString *username;

@end
