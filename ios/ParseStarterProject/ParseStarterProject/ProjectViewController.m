//
//  ProjectViewController.m
//  ParseStarterProject
//
//  Created by Fangzhou He on 15/08/2015.
//
//

#import "ProjectViewController.h"
#import "ProjectTableViewCell.h"
#import <Parse/Parse.h>
#import <JGProgressHUD/JGProgressHUD.h>//;

@interface ProjectViewController (){
    NSMutableArray *allProjectsArray;
}

@end

@implementation ProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    HUD.textLabel.text = @"Loading";
    [HUD showInView:self.view];
    
    allProjectsArray = [[NSMutableArray alloc]init];
    //Parse
    PFQuery *query = [PFQuery queryWithClassName:@"Project"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
//        NSLog(@"%@",objects);
        [allProjectsArray addObjectsFromArray:objects];
        [_projectTableView reloadData];
        [HUD dismissAfterDelay:0];

    }];
    _projectTableView.dataSource = self;
    _projectTableView.delegate = self;

    
}

- (void)viewDidAppear:(BOOL)animated{

}
- (void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"cell";
    
    ProjectTableViewCell *cell=(ProjectTableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell=[[ProjectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    NSDictionary *currentDictionary = [allProjectsArray objectAtIndex:indexPath.row];
    cell.projectTitle.text = [currentDictionary objectForKey:@"projectName"];
    cell.projectDescription.text = [currentDictionary objectForKey:@"projectDescription"];
    cell.projectGoal.text = [[currentDictionary objectForKey:@"projectGoal"] stringValue];
    cell.projectGoalProgressView.progress = [[currentDictionary objectForKey:@"projectGoal"]floatValue]/100;
    PFFile *originImage = [currentDictionary objectForKey:@"projectImage"];
    if (originImage != NULL) {
        [originImage getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error){
            UIImage *image = [UIImage imageWithData:imageData];
            cell.projectImage.image = image;
        }];
    }
    
    return cell;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"%lu", (unsigned long)allProjectsArray.count);
    return allProjectsArray.count;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
}

@end
