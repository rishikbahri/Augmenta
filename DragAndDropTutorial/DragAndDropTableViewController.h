//
//  DragAndDropTableViewController.h
//  test
//
//  Created by Scott Sherwood on 05/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DraggableTableViewDelegate;
@protocol DropableTableViewDelegate;

@interface DragAndDropTableViewController : UITableViewController <UIGestureRecognizerDelegate>{
   
    id<DraggableTableViewDelegate> draggableDelegate;
    id<DropableTableViewDelegate> dropableDelegate;
    id dragAndDropItem;
  
}

@property(strong,nonatomic) id<DropableTableViewDelegate> dropableDelegate;
@property(strong,nonatomic) id<DraggableTableViewDelegate> draggableDelegate;
@property(strong,nonatomic) id dragAndDropItem;

@end

