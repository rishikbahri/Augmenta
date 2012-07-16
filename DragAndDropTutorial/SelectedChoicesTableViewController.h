//
//  SelectedChoicesTableViewController.h
//  test
//
//  Created by Scott Sherwood on 05/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DragAndDropTableViewController.h"
#import "DraggableTableViewDelegate.h"

@interface SelectedChoicesTableViewController : DragAndDropTableViewController <DraggableTableViewDelegate>
{
    NSMutableArray *_selectedChoices;
    
    id _selectedChoice;
    
    UIView *_dragAndDropView;
    int _selectedChoicePosition;


}


@property(strong,nonatomic) UIView *dragAndDropView;
@property(strong,nonatomic) id selectedChoice;
@property(strong,nonatomic)NSMutableArray *selectedChoices;
@property(nonatomic) int selectedChoicePosition;

-(void)reloadData;


@end
