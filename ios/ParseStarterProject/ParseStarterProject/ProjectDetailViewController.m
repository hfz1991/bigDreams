//
//  ProjectDetailViewController.m
//  ParseStarterProject
//
//  Created by Fangzhou He on 16/08/2015.
//
//

#import "ProjectDetailViewController.h"
#import <Parse/Parse.h>
#import <JGProgressHUD/JGProgressHUD.h>//;

@interface ProjectDetailViewController (){
}

@end

@implementation ProjectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    HUD.textLabel.text = @"Loading";
    [HUD showInView:self.view];

    // Do any additional setup after loading the view.
    PFQuery *query = [PFQuery queryWithClassName:@"Project"];
    [query whereKey:@"projectID" equalTo:_projectID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        NSLog(@"%@",objects);
        _projectTitle.text = [[objects objectAtIndex:0]objectForKey:@"projectName"];
        _projectDescrition.text = [[objects objectAtIndex:0]objectForKey:@"projectDescription"];
        _voteLabel.text = [[[objects objectAtIndex:0]objectForKey:@"votes"]stringValue];
        PFFile *originImage = [[objects objectAtIndex:0] objectForKey:@"projectImage"];
        if (originImage != NULL) {
            [originImage getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error){
                UIImage *image = [UIImage imageWithData:imageData];
                _projectImage.image = image;
            }];
        }
        [HUD dismissAfterDelay:0];
        
    }];
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

@end
