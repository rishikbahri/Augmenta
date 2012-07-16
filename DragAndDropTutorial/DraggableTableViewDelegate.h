//
//  DraggableTableViewDelegate.h
//  test
//
//  Created by Scott Sherwood on 06/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DragAndDropTableViewController.h"


@protocol DraggableTableViewDelegate <NSObject>

-(void)dragAndDropTableViewController:(DragAndDropTableViewController *)ddtvc draggingGestureWillBegin:(UIGestureRecognizer *)gesture forCell:(UITableViewCell *)cell;
-(void)dragAndDropTableViewController:(DragAndDropTableViewController *)ddtvc draggingGestureDidBegin:(UIGestureRecognizer *)gesture forCell:(UITableViewCell *)cell;
-(void)dragAndDropTableViewController:(DragAndDropTableViewController *)ddtvc draggingGestureDidMove:(UIGestureRecognizer *)gesture;
-(void)dragAndDropTableViewController:(DragAndDropTableViewController *)ddtvc draggingGestureDidEnd:(UIGestureRecognizer *)gesture;

-(UIView *)dragAndDropTableViewControllerView:(DragAndDropTableViewController *)ddtvc;
-(id)dragAndDropTableViewControllerSelectedItem:(DragAndDropTableViewController *)ddtvc;

@end  
