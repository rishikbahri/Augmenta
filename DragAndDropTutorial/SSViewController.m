//
//  SSViewController.m
//  DragAndDropTutorial
//
//  Created by Scott Sherwood on 06/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import "SSViewController.h"
@implementation SSViewController

@synthesize questionChecker,choicesViewController, selectedChoicesViewController;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
    
}

-(IBAction)nextQuestion:(id)sender{
    
  //  QuestionChecker *qc=[[QuestionChecker alloc] init];
   // ChoicesTableViewController *choice=[[ChoicesTableViewController alloc] init];
    
  //  NSLog(@"%@",[selectedChoicesViewController selectedChoices]);
    if([questionChecker isCorrect:[selectedChoicesViewController selectedChoices]]){
        if([questionChecker counter]+1>=[[questionChecker questions] count]){
            [incorrectTxt setText:@"No more questions"];

        }else{
        [incorrectTxt setText:@""];
        [questionChecker setCounter:[questionChecker counter]+1];
        [choicesViewController setQuestion:[questionChecker getQuestion:[questionChecker counter]] :[questionChecker getSelectedOptions:[questionChecker counter]]];
        [selectedChoicesViewController reloadData];
        }
    }else{
        [incorrectTxt setText:@"You Suck"];
        
    }
    
    
}

#pragma mark - DropableTableViewDelegate
-(void)dragAndDropTableViewController:(DragAndDropTableViewController *)ddtvc droppedGesture:(UIGestureRecognizer *)gesture{
    
    UIView *viewHit = [self.view hitTest:[gesture locationInView:self.view.superview] withEvent:nil];
    
    
    if([ddtvc isKindOfClass:[ChoicesTableViewController class]]){
        ChoicesTableViewController *fromTBCV=(ChoicesTableViewController *)ddtvc;
        id selectedChoice = fromTBCV.selectedChoice;
        
        if([fromTBCV.view isEqual:viewHit])
            [fromTBCV.choices addObject:selectedChoice];
        else if([viewHit.superview isKindOfClass:[UITableViewCell class]] && [fromTBCV.view isEqual:viewHit.superview.superview]){
            //we have dropped on a cell in our table
            NSIndexPath *ip = [fromTBCV.tableView indexPathForCell:(UITableViewCell *)viewHit.superview];
            [fromTBCV.choices insertObject:selectedChoice atIndex:ip.row];
        }
        else if([self.selectedChoicesViewController.view isEqual:viewHit]){
            [self.selectedChoicesViewController.selectedChoices addObject:selectedChoice];
            [self.selectedChoicesViewController.tableView reloadData];
        }
        else if([viewHit.superview isKindOfClass:[UITableViewCell class]] && [self.selectedChoicesViewController.view isEqual:viewHit.superview.superview]){
            //we have dropped on a cell in our table
            NSIndexPath *ip = [self.selectedChoicesViewController.tableView indexPathForCell:(UITableViewCell *)viewHit.superview];
            [self.selectedChoicesViewController.selectedChoices insertObject:selectedChoice atIndex:ip.row];
            [self.selectedChoicesViewController.tableView reloadData];
        }else{
            
            //[fromTBCV.choices addObject:selectedChoice];
        
            [fromTBCV.choices insertObject:selectedChoice atIndex:fromTBCV.selectedChoicePosition];
        }
        
        
    }
    else if([ddtvc isKindOfClass:[SelectedChoicesTableViewController class]]){
        SelectedChoicesTableViewController *fromSCTVC=(SelectedChoicesTableViewController *)ddtvc;
        id selectedChoice = fromSCTVC.selectedChoice;
        
        if([fromSCTVC.view isEqual:viewHit])
            [fromSCTVC.selectedChoices addObject:selectedChoice];
        else if([viewHit.superview isKindOfClass:[UITableViewCell class]] && [fromSCTVC.view isEqual:viewHit.superview.superview]){
            //we have dropped on a cell in our table
            NSIndexPath *ip = [fromSCTVC.tableView indexPathForCell:(UITableViewCell *)viewHit.superview];
            [fromSCTVC.selectedChoices insertObject:selectedChoice atIndex:ip.row];
        }
        else if([self.choicesViewController.view isEqual:viewHit]){
            [self.choicesViewController.choices addObject:selectedChoice];
            [self.choicesViewController.tableView reloadData];
        }
        else if([viewHit.superview isKindOfClass:[UITableViewCell class]] && [self.choicesViewController.view isEqual:viewHit.superview.superview]){
            //we have dropped on a cell in our table
            NSIndexPath *ip = [self.choicesViewController.tableView indexPathForCell:(UITableViewCell *)viewHit.superview];
            [self.choicesViewController.choices insertObject:selectedChoice atIndex:ip.row];
            [self.choicesViewController.tableView reloadData];
        }else{
           // [fromSCTVC.selectedChoices addObject:selectedChoice];
            [fromSCTVC.selectedChoices insertObject:selectedChoice atIndex:fromSCTVC.selectedChoicePosition];

        }
        
    }
    else
        NSLog(@"Item dropped on a non droppable area");
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.choicesViewController.dropableDelegate = self;
    self.selectedChoicesViewController.dropableDelegate =self;
    self.questionChecker=[[QuestionChecker alloc] init];
 //   [choicesViewController setQuestion:[questionChecker getQuestion:[questionChecker counter]] :[questionChecker getSelectedOptions:[questionChecker counter]]];
    
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



@end
