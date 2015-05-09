//
//  BussArray.m
//  ipaycard
//
//  Created by RenLongfei on 13-12-10.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import "BussArray.h"

@implementation BussArray

@synthesize bussMutArray;

@synthesize bussArray;

@synthesize lifeArray;

@synthesize finaceArray;

@synthesize entertainmentArray;

@synthesize allArray;

@synthesize arrayUserInfo;

@synthesize historyArray;

@synthesize beginTime;

@synthesize endTime;

- (id)init
{
    self = [super init];
    
    arrayUserInfo = [NSUserDefaults standardUserDefaults];

    if (self) {
        
        bussArray = [[NSArray alloc]initWithObjects:@"1005",@"1004",@"1013" , nil]; //@"1017"
        
        lifeArray  = [[NSArray alloc]initWithObjects:@"1001",@"1012",@"1007",@"1009",@"1008",@"1015",@"1010",@"1011", @"1017",nil];
        finaceArray = [[NSArray alloc]initWithObjects:@"1004",@"1005",@"1006",@"1013", nil]; //2001 @"1018"
        
        entertainmentArray = [[NSArray alloc]initWithObjects:@"1002",@"1003",@"1014",@"1016", nil];
        
        if ([[arrayUserInfo objectForKey:@"allArray"] count] <=0){
            NSMutableArray *allArr = [[NSMutableArray alloc]init];
            for (int i =0; i<17; i++) {
                if (i!=3&&i!=12&&i!=4) { //i!=16
                    NSString *temStr = [NSString stringWithFormat:@"%d",1001+i];
 
                    NSMutableDictionary *temDic= [NSMutableDictionary dictionaryWithObject:@"0" forKey:temStr];
                    [allArr addObject:temDic];
                }
            }
            [arrayUserInfo setObject:allArr forKey:@"allArray"];

        }
        [arrayUserInfo synchronize];
        
        allArray = [[NSMutableArray alloc]init];
        for (int i =0; i< [[arrayUserInfo objectForKey:@"allArray"] count]; i++) {
            NSMutableDictionary *addDict = [[NSMutableDictionary alloc]initWithDictionary:[[arrayUserInfo objectForKey:@"allArray"] objectAtIndex:i]];
            [allArray addObject:addDict];
        }
        
        for (NSDictionary *temdic in [arrayUserInfo objectForKey:@"allArray"]) {
            if ([[temdic objectForKey:@"1003"] isEqualToString:@"0"]) {
                [self  changeArraySort:@"1017"];
                [self  changeArraySort:@"1003"];
                [self  changeArraySort:@"1001"];
                //[self  changeArraySort:@"1005"];
            }
        }
        
        bussMutArray = [[NSMutableArray alloc]initWithArray:[arrayUserInfo objectForKey:@"allArray"]];

        if ([[arrayUserInfo objectForKey:@"historyArray"] count] <=0){
            historyArray = [NSMutableArray array];
        }else{
            historyArray = [NSMutableArray arrayWithArray:[arrayUserInfo objectForKey:@"historyArray"]];
        }
        

    }
    
    return self;
}

+ (BussArray *)sharedInstance
{
    // 1
    static BussArray *_sharedInstance = nil;
    // 2
    static dispatch_once_t oncePredicate;
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[BussArray alloc] init];
    });
    return _sharedInstance;
}

-(void)changeArraySort:(NSString *)bussTypeString{
    for (int i = 0; i< allArray.count; i++) {
        NSMutableDictionary *temDict = [allArray objectAtIndex:i];

        if ([[[temDict allKeys] objectAtIndex:0] isEqualToString:bussTypeString]) {
            NSString *temCount = [NSString stringWithFormat:@"%d",[[[temDict allValues]objectAtIndex:0] intValue]+1];
            [temDict setObject:temCount forKey:bussTypeString];
            break;
        }
    }
    //[self QuickSort:allArray StartIndex:0 EndIndex:allArray.count-1];
    
    //[self BubbleSort:allArray];
    [self selectSortWithArray:allArray];
    [arrayUserInfo setObject:allArray forKey:@"allArray"];
    
    [arrayUserInfo synchronize];
    

}

-(void)selectSortWithArray:(NSMutableArray *)list{
    for (int i=0; i<[list count]-1; i++) {
        int m =i;
        for (int j =i+1; j<[list count]; j++) {
            NSInteger a1 = [[[[list objectAtIndex:j] allValues]objectAtIndex:0] intValue];
            NSInteger a2 = [[[[list objectAtIndex:m] allValues]objectAtIndex:0] intValue];

            if (a1 > a2) {
                m = j;
            }
        }
        if (m != i) {
            [list exchangeObjectAtIndex:m withObjectAtIndex:i];
        }
    }
}

-(void)QuickSort:(NSMutableArray *)list StartIndex:(NSInteger)startIndex EndIndex:(NSInteger)endIndex{
    if(startIndex >= endIndex)
        return;
    
    NSNumber * temp = [[[list objectAtIndex:startIndex] allValues]objectAtIndex:0];
    NSInteger tempIndex = startIndex; //临时索引 处理交换位置(即下一个交换的对象的位置)
    
    for(int i = startIndex + 1 ; i <= endIndex ; i++){
        NSNumber *t = [[[list objectAtIndex:i] allValues]objectAtIndex:0];
        if([temp intValue] < [t intValue]){
            tempIndex = tempIndex + 1;
            [list exchangeObjectAtIndex:tempIndex withObjectAtIndex:i];
        }
    }
    
    [list exchangeObjectAtIndex:tempIndex withObjectAtIndex:startIndex];
    [self QuickSort:list StartIndex:startIndex EndIndex:tempIndex-1];
    [self QuickSort:list StartIndex:tempIndex+1 EndIndex:endIndex];
    
}

-(void)BubbleSort:(NSMutableArray *)list{
    
    for (int j = 1; j<= [list count]; j++) {
        
        for(int i = 0 ;i < j ; i++){
            
            if(i == [list count]-1)
                return;
            
            NSInteger a1 = [[[[list objectAtIndex:i] allValues]objectAtIndex:0] intValue];
            NSInteger a2 = [[[[list objectAtIndex:i+1] allValues]objectAtIndex:0] intValue];
            
            if(a1 < a2){
                [list exchangeObjectAtIndex:i withObjectAtIndex:i+1];
            }
        }
        NSLog(@"i = %d list=%@",j, list);
    }
}

-(void)addNewToHistory :(NSString *)stationInfo{
    NSMutableArray *userHisArray = [[NSMutableArray alloc]initWithArray:[arrayUserInfo objectForKey:@"historyArray"]];
    int temInt = -1;
    for (int i = 0; i< userHisArray.count; i++) {
        if ([[userHisArray objectAtIndex:i] isEqualToString:stationInfo]) {
            temInt = i;
        }
    }
    
    if (userHisArray.count >7) {
        if (temInt == -1) {
            [userHisArray insertObject:stationInfo atIndex:0];
            [userHisArray removeObjectAtIndex:8];
        }else{
            [userHisArray removeObjectAtIndex:temInt];
            [userHisArray insertObject:stationInfo atIndex:0];
        }
    }else{
        if (temInt == -1) {
            [userHisArray insertObject:stationInfo atIndex:0];
        }else{
            [userHisArray removeObjectAtIndex:temInt];
            [userHisArray insertObject:stationInfo atIndex:0];
        }
    }
    [arrayUserInfo setObject:userHisArray forKey:@"historyArray"];
    [arrayUserInfo synchronize];
    historyArray = userHisArray;

}

@end
