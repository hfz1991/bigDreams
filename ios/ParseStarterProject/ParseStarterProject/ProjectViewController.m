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

@interface ProjectViewController (){
    NSMutableArray *allProjectsArray;
}

@end

@implementation ProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    //Parse
    PFQuery *query = [PFQuery queryWithClassName:@"Project"];
    [query whereKey:@"projectName" matchesQuery:query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        [allProjectsArray addObjectsFromArray:objects];
    }];
    
    _projectTableView.delegate = self;
    _projectTableView.dataSource = self;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"cell";
    
    ProjectTableViewCell *cell=(ProjectTableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell=[[ProjectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
//    cell.textLabel.text=[accountTypeArray objectAtIndex:indexPath.row];
    
    return cell;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu", (unsigned long)allProjectsArray.count);
    return allProjectsArray.count;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
