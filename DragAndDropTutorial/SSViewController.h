//
//  SSViewController.h
//  DragAndDropTutorial
//
//  Created by Scott Sherwood on 06/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DragAndDropTableViewController.h"
#import "ChoicesTableViewController.h"
#import "SelectedChoicesTableViewController.h"
#import "QuestionChecker.h"


@interface SSViewController : UIViewController<DropableTableViewDelegate>
{
    IBOutlet UILabel *incorrectTxt;
    

}

@property(strong,nonatomic) IBOutlet SelectedChoicesTableViewController *selectedChoicesViewController;
@property(strong,nonatomic) IBOutlet ChoicesTableViewController *choicesViewController;
@property(strong,nonatomic)  QuestionChecker *questionChecker;

-(IBAction)nextQuestion:(id)sender;
@end
