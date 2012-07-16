//
//  ChoicesTableViewController.m
//  test
//
//  Created by Scott Sherwood on 05/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import "ChoicesTableViewController.h"


@implementation ChoicesTableViewController

@synthesize choices = _choices, selectedChoice=_selectedChoice,selectedChoicePosition=_selectedChoicePosition, dragAndDropView = _dragAndDropView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.draggableDelegate = self;
    
    self.choices = [NSMutableArray array];
    

    QuestionChecker *qc=[[QuestionChecker alloc] init];
    
    int counter=[qc counter];
    [txtView setText:[qc getQuestion:counter]];
     for(NSString *strs in [qc getSelectedOptions:counter]){
         [self.choices addObject:strs];
     }


    
    
    /*  [self.choices addObject:@"Choices 1"];
    [self.choices addObject:@"Choices 2"];
    [self.choices addObject:@"Choices 3"];
    [self.choices addObject:@"Choices 4"];*/
}
-(void)setQuestion: (NSString *) question :(NSMutableArray *) options{

    [txtView setText:question];
    [self.choices removeAllObjects];
    for(NSString *strs in options){
       [self.choices addObject:strs];
        

    }
 //   NSLog(@"choices %@",self.choices);
    [self.tableView reloadData];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}




#pragma mark - Drag and Drop Delegate
-(void)dragAndDropTableViewController:(DragAndDropTableViewController *)ddtvc draggingGestureDidBegin:(UIGestureRecognizer *)gesture forCell:(UITableViewCell *)cell;
{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    self.selectedChoice =[self.choices objectAtIndex:indexPath.row];  
    self.selectedChoicePosition=[self.choices indexOfObject:self.selectedChoice];
  //  NSLog(@"Removing object at %i",self.selectedChoicePosition);

    [self.choices removeObjectAtIndex:[self.choices indexOfObject:self.selectedChoice]];
    
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
    
}



-(void)dragAndDropTableViewController:(DragAndDropTableViewController *)ddtvc draggingGestureWillBegin:(UIGestureRecognizer *)gesture forCell:(UITableViewCell *)cell{
    
    UIGraphicsBeginImageContext(cell.contentView.bounds.size);
    [cell.contentView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:img];
    self.dragAndDropView = [[UIView alloc]initWithFrame:iv.frame];
    [self.dragAndDropView addSubview:iv];
    [self.dragAndDropView setBackgroundColor:[UIColor blueColor]];
    [self.dragAndDropView setCenter:[gesture locationInView:self.view.superview]];
    
    [self.view.superview addSubview:self.dragAndDropView];
}

-(void)dragAndDropTableViewController:(DragAndDropTableViewController *)ddtvc draggingGestureDidMove:(UIGestureRecognizer *)gesture{
    [self.dragAndDropView setCenter:[gesture locationInView:self.view.superview]];
}


-(void)dragAndDropTableViewController:(DragAndDropTableViewController *)ddtvc draggingGestureDidEnd:(UIGestureRecognizer *)gesture{
    
    [self.dragAndDropView removeFromSuperview];
    self.dragAndDropView = nil;
}


-(UIView *)dragAndDropTableViewControllerView:(DragAndDropTableViewController *)ddtvc{
    return self.dragAndDropView;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.choices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:cell action:nil];
    longPress.delegate = self;
    [cell addGestureRecognizer:longPress];
   
    
    NSString *choice = [self.choices objectAtIndex:indexPath.row];
    
    cell.textLabel.text = choice;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
