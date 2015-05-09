//
//  ActionSheetForCity.m
//  ipaycard
//
//  Created by WangJian on 13-4-19.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import "ActionSheetForCity.h"
#import "CityDataBase_David.h"
#import "CityData_David.h"
@interface ActionSheetForCity()
{
    int selectRowInPickView;
    int selectRowInPickViewCom2;
    
    BOOL selectPickFlag;
    BOOL selectCom2Falg;
    
    NSString * city;
    NSString * province;
    
    UIToolbar * toolBar;
}

//pickView 数据
@property (retain, nonatomic) NSMutableDictionary * provinceDic;
@property (retain, nonatomic) NSMutableDictionary * derectDic;
@property (retain, nonatomic) NSMutableArray * scetionTitleArr;
@property (retain, nonatomic) NSMutableArray * objectArr;

@end

@implementation ActionSheetForCity
@synthesize pickerView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            
        // Initialization code
    }
    return self;
}

-(id)init{
    
    self = [super init];
    if (self) {
        [self initCityData];
        
        [self initPickView];
        
    }

    return self;

}

-(void)initCityData   // 初始化城市数据
{
    
    province = @"直辖市";
    
    self.provinceDic = [CityDataBase_David findAllCitiesSortedInKeys];
    self.derectDic = [CityDataBase_David findAllDerectCities];
    
    self.scetionTitleArr = [NSMutableArray arrayWithObject:@"直辖市"];
    for (NSString * str in [self.provinceDic allKeys]) {
        [self.scetionTitleArr addObject:str];
    }
    
    self.objectArr = [NSMutableArray arrayWithCapacity:5];
    
    self.objectArr = [self.derectDic objectForKey:@"直辖市"];
    
    selectRowInPickView = 0;
    selectRowInPickViewCom2 = 0;
}

-(void)initPickView
{
    pickerView = [[UIPickerView alloc] init];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    
    pickerView.delegate = self;
    
    [pickerView selectRow:selectRowInPickView inComponent:0 animated:YES];  // 默认选中那一部分的哪一行
    [pickerView selectRow:selectRowInPickViewCom2 inComponent:1 animated:YES];
    
    [self addSubview:pickerView];
    
    CGRect pickerRect = pickerView.bounds;
    pickerRect.origin.y = -43;
    pickerView.bounds = pickerRect;
            
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithTitle:@"开户行所在地" style: UIBarButtonItemStylePlain target: nil action: nil];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style: UIBarButtonItemStyleDone target: self action: @selector(done)];
    UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style: UIBarButtonItemStyleBordered target: self action: @selector(docancel)];
    UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil];
    NSArray *array = [NSArray arrayWithObjects: leftButton,fixedButton, titleButton,fixedButton, rightButton, nil];
    [leftButton release];
    [titleButton release];
    [fixedButton release];
    [rightButton release];
    [toolBar setItems: array];
    
    [self addSubview:toolBar];

}
-(void)backToOrignal{

    [pickerView selectRow:0 inComponent:0 animated:YES];  // 默认选中那一部分的哪一行
    [pickerView selectRow:0 inComponent:1 animated:YES];
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *str = @"";
    CityData_David* pickCity;
    if (component == 0) {
        
        return [self.scetionTitleArr objectAtIndex:row];
    }
    
    else {
        pickCity = [self.objectArr objectAtIndex:row];
        
    }
    str = pickCity.name;
    return str;
    
}


- (void)pickerView:(UIPickerView *)pickerV didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    selectPickFlag = TRUE;
    
    
    CityData_David* pickCity;
    
    
    
    if (component == 0) {
        
        if (row == 0) {
            self.objectArr = [self.derectDic objectForKey:@"直辖市"];
            province = @"直辖市";
        }
        else{
            
            NSArray * allkeys = [self.provinceDic allKeys];
            NSString * key = [allkeys objectAtIndex:row-1];
            self.objectArr = [self.provinceDic objectForKey:key];
            province = key;
        }
        
        selectRowInPickView = row;
        
        selectCom2Falg = NO;
        
        [pickerV reloadComponent:1];     // 重点在这, 选中上层时, 相应的下层的数据会变动, 此时需要reloadComponent
        
        [pickerV selectRow:0 inComponent:1 animated:YES];
        
    }
    if (component == 1) {
        
        
        selectCom2Falg = TRUE;
        
        pickCity = [self.objectArr objectAtIndex:row];
        
        selectRowInPickViewCom2 = row;
        
        city = pickCity.name;
        
    }
    
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        
        return [self.scetionTitleArr count];
        
    }
    
    if (component == 1) {
        
        return self.objectArr.count;
        
    }
    
    return 0;
    
}


-(void)done   // 点击pickerView上边定义的done按钮的时候触发
{
    
    
    
    if (!selectPickFlag) {
        
        if (selectRowInPickView == 0) {
            CityData_David * defaultCity = [self.objectArr objectAtIndex:selectRowInPickViewCom2];
            city = defaultCity.name;
            
            
        }
        else{
            
            NSArray * allkeys = [self.provinceDic allKeys];
            NSString * key = [allkeys objectAtIndex:selectRowInPickView-1];
            
            self.objectArr = [self.provinceDic objectForKey:key];
            
            CityData_David * defaultCity = [self.objectArr objectAtIndex:selectRowInPickViewCom2];
            city = defaultCity.name;
        }
        
        
    }
    
    
    if (!selectCom2Falg) {
        selectRowInPickViewCom2 = 0;
    }
    if (selectRowInPickViewCom2 == 0) {
        
        if (selectRowInPickView == 0) {
            CityData_David * defaultCity = [self.objectArr objectAtIndex:selectRowInPickViewCom2];
            city = defaultCity.name;
        }
        
        if (selectRowInPickView !=0 )
        {
            NSArray * allkeys = [self.provinceDic allKeys];
            NSString * key = [allkeys objectAtIndex:selectRowInPickView-1];
            
            self.objectArr = [self.provinceDic objectForKey:key];
            
            CityData_David * defaultCity = [self.objectArr objectAtIndex:0];
            city = defaultCity.name;
            
        }
        
    }
    
    selectPickFlag = FALSE;
    selectCom2Falg = FALSE;
    [self dismissWithClickedButtonIndex:0 animated:YES];  
    
    
    [self.cityDelegate didSelectedProvicenAndCity:province city:city];
    
}

-(void)docancel{

    [self dismissWithClickedButtonIndex:0 animated:YES];

}

@end
