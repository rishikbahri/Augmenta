//
//  QuestionChecker.h
//  DragAndDropTutorial
//
//  Created by Rishik Bahri on 04/07/12.
//  Copyright (c) 2012 Scott Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionChecker : UIViewController
{
    NSMutableArray *questions;
    NSMutableArray *answers;
    NSMutableArray *nonErrorResults;
    NSMutableArray *solved;

    int counter;
    
}
@property(strong,nonatomic) NSMutableArray *questions;
@property(strong,nonatomic) NSMutableArray *answers;
@property(strong,nonatomic) NSMutableArray *solved;
@property(strong,nonatomic) NSMutableArray *nonErrorResults;
@property(nonatomic) int counter;

- (NSMutableArray *)getSelectedOptions:(int)position;
- (NSString *)getQuestion:(int) position;
- (BOOL)isCorrect:(NSMutableArray *) selectedChoices;

@end
