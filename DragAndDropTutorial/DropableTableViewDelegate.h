//
//  DropableDelegate.h
//  test
//
//  Created by Scott Sherwood on 06/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DropableTableViewDelegate <NSObject>

-(void)dragAndDropTableViewController:(DragAndDropTableViewController *)ddtvc droppedGesture:(UIGestureRecognizer *)gesture;

@end  
