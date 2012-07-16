//
//  QuestionChecker.m
//  DragAndDropTutorial
//
//  Created by Rishik Bahri on 04/07/12.
//  Copyright (c) 2012 Scott Sherwood. All rights reserved.
//

#import "QuestionChecker.h"

@implementation QuestionChecker
@synthesize questions=questions,answers=answers,counter=counter,nonErrorResults=nonErrorResults,solved=solved;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"file" ofType:@"txt"];  
        NSData *data = [NSData dataWithContentsOfFile:filePath];  
        NSMutableArray *tempQuestions=[[NSMutableArray alloc] init];
        NSMutableArray *tempAnswers=[[NSMutableArray alloc] init];
        NSMutableArray *tempNonErrorResults=[[NSMutableArray alloc] init];
        NSMutableArray *tempSolved=[[NSMutableArray alloc] init];
        NSMutableArray *questionIndex=[[NSMutableArray alloc] init];
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization 
                              JSONObjectWithData:data //1
                              
                              options:kNilOptions 
                              error:&error];
        
        if (!json) {
            NSLog(@"Error parsing JSON: %@", error);
        } else {
            for(NSString *keyStr in [json allKeys]) {
                //   NSLog(@"%@",keyStr);
                
                NSDictionary *sub=[json valueForKey:keyStr];
                
                [tempQuestions addObject:[sub valueForKey:@"description"]];
                [questionIndex addObject:[sub valueForKey:@"problemsetorder"]];
                NSMutableArray *temp=[[NSMutableArray alloc] init];
                NSMutableArray *temp2=[[NSMutableArray alloc] init];
                NSMutableArray *temp3=[[NSMutableArray alloc] init];

                //self.choices=[sub valueForKey:@"lines"];
                for (NSString *strs in [sub valueForKey:@"lines"]) {
                    [temp addObject:strs];
                }
                NSMutableDictionary *objNonErrorResult=[sub objectForKey:@"nonErrorResults"];
                for(NSString *strs in objNonErrorResult){
                    [temp2 addObject:strs];
                    NSDictionary *tempStore=[objNonErrorResult objectForKey:strs];
                    [temp3 addObject:[tempStore valueForKey:@"solved"]];
                    //[temp2 addEntriesFromDictionary:strs];
                }
                [tempAnswers addObject:temp];
                [tempNonErrorResults addObject:temp2];
                [tempSolved addObject:temp3];
             //   [tempNonErrorResults addEntriesFromDictionary:temp2];
                
                temp=NULL;
                temp2=NULL;
                temp3=NULL;
                // NSMutableArray *bla=[item allValues];
                // NSLog(@"%@",bla);
            }
            NSLog(@"OLD %@",questionIndex);
            counter=0;
            for(int i=0;i<[questionIndex count]-1;i++){
                for(int j=i;j<[questionIndex count];j++){
                    id objIDi=[questionIndex objectAtIndex:i];
                    NSString *objSTRi= (@"%@",objIDi);
                    int objINTi=[objSTRi intValue];    
                    id objIDj=[questionIndex objectAtIndex:j];
                    NSString *objSTRj= (@"%@",objIDj);
                    int objINTj=[objSTRj intValue];    
                    
                  
                    if(objINTi>objINTj){
                        id tempIndex=[questionIndex objectAtIndex:i];
                        [questionIndex replaceObjectAtIndex:i withObject:[questionIndex objectAtIndex:j]];
                        [questionIndex replaceObjectAtIndex:j withObject:tempIndex];
                        
                        id tempQuestionIndex=[tempQuestions objectAtIndex:i];
                        [tempQuestions replaceObjectAtIndex:i withObject:[tempQuestions objectAtIndex:j]];
                        [tempQuestions replaceObjectAtIndex:j withObject:tempQuestionIndex];
                        
                        id tempAnswerIndex=[tempAnswers objectAtIndex:i];
                        [tempAnswers replaceObjectAtIndex:i withObject:[tempAnswers objectAtIndex:j]];
                        [tempAnswers replaceObjectAtIndex:j withObject:tempAnswerIndex];
                        
                        id tempNonErrorResultIndex=[tempNonErrorResults objectAtIndex:i];
                        [tempNonErrorResults replaceObjectAtIndex:i withObject:[tempNonErrorResults objectAtIndex:j]];
                        [tempNonErrorResults replaceObjectAtIndex:j withObject:tempNonErrorResultIndex];
                        
                        id tempSolvedIndex=[tempSolved objectAtIndex:i];
                        [tempSolved replaceObjectAtIndex:i withObject:[tempSolved objectAtIndex:j]];
                        [tempSolved replaceObjectAtIndex:j withObject:tempSolvedIndex];
                        
                    }
                }
            }
            NSLog(@"NEW %@",questionIndex);
            questions=tempQuestions;
            answers=tempAnswers;
            nonErrorResults=tempNonErrorResults;
            solved=tempSolved;
            
        }
        
    }
    return self;
}
- (NSMutableArray *)getSelectedOptions:(int)position{
    return [answers objectAtIndex:position];
}
- (NSString *)getQuestion:(int) position{
    return [questions objectAtIndex:position];
}

-(BOOL)isCorrect:(NSMutableArray *) selectedChoices{
   // NSLog(@"bla %@",selectedChoices);
    NSMutableArray *nonErrorResult=[nonErrorResults objectAtIndex:counter];
    NSMutableArray *isSolved=[solved objectAtIndex:counter];
    NSString *givenAnswer=[[NSString alloc] init];
   //
  //  NSLog(@"Selected choices %@",nonErrorResult);
    for(NSString *strs in selectedChoices){
   //     NSMutableArray *bla=[answers objectAtIndex:counter];
   //     NSLog(@"lala %i",[bla count]);
        for(int i=0;i<[[answers objectAtIndex:counter] count];i++){
            NSMutableArray *tempArr=[answers objectAtIndex:counter];
            if([[tempArr objectAtIndex:i] isEqualToString:strs]){
             //   NSString *tempStr=;
                givenAnswer=[NSString stringWithFormat:@"%@%@", givenAnswer,[NSString stringWithFormat:@"%d", (i+1)]];
              //  givenAnswer=@"%@ %@",givenAnswer,;
                break;
            }
        }
    }
    for(int i=0;i<[nonErrorResult count];i++){
        if([[nonErrorResult objectAtIndex:i] isEqualToString:givenAnswer]){
          //  NSInteger check=;
            if([[isSolved objectAtIndex:i]integerValue]==1 ){
                NSLog(@"ha %@",[isSolved objectAtIndex:i]);

                return TRUE;
            }
        }
    }/*
    for(NSString *strs in nonErrorResult){
        if([strs isEqualToString:givenAnswer]){
            NSString *check=[strs valueForKey:@"solved"];
            NSLog(@"%@",check);
            
            return TRUE;
        }
    }*/
    return FALSE;
}



@end
