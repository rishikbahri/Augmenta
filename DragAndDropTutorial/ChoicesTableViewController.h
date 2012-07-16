//
//  ChoicesTableViewController.h
//  test
//
//  Created by Scott Sherwood on 05/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DragAndDropTableViewController.h"
#import "DraggableTableViewDelegate.h"
#import "DropableTableViewDelegate.h"
#import "QuestionChecker.h"

@interface ChoicesTableViewController : DragAndDropTableViewController <DraggableTableViewDelegate>
{
    NSMutableArray *_choices;
    id _selectedChoice;
    IBOutlet UILabel *txtView;
    UIView *_dragAndDropView;
    int _selectedChoicePosition;
    
}


@property(strong,nonatomic) UIView *dragAndDropView;
@property(strong,nonatomic) id selectedChoice;
@property(nonatomic) int selectedChoicePosition;
@property(strong,nonatomic) NSMutableArray *choices;
-(void)setQuestion: (NSString *) question :(NSArray *) options;


@end
