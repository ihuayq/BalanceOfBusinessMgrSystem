//
//  DJYNewActionSheet.m
//  ipaycard
//
//  Created by Davidsph on 5/28/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import "DJYNewActionSheet.h"

@interface DJYNewActionSheet (){
    
    
    UIToolbar* toolBar;
    
    UIPickerView *picker;
    
    NSMutableArray *pickList;
    int pickSelectedIndex;
    
    NSArray *cityComponentArray;
    
    NSArray *provinceArray;
    
    
    
    NSString *selectProvince;
    NSString *selectCity;
    
    
}

@property(nonatomic,strong)NSDictionary *dataDic;

@end

@implementation DJYNewActionSheet


- (id)initWithFrame:(CGRect)frame
{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    self = [super initWithFrame:frame];
    if (self) {
        
              
        // Initialization code
    }
    return self;
}



-(id)init{
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    self = [super init];
    if (self) {
        
         }
    
    return self;
    
}


- (id) initActionSheetWithHeight:(float) height title:(NSString *)title dataSource:(NSDictionary *) data  resultBlock:(ChooseCityResultBlock) resultBlock{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    thisBlock = resultBlock;
    
    self.dataDic = data;
    provinceArray = [self.dataDic allKeys];
    
    NSString *string = [provinceArray objectAtIndex:0];
    
    cityComponentArray = [self.dataDic objectForKey:string];
    
    CCLog(@"省份count = %d 城市 count = %d",[provinceArray count],[cityComponentArray count]);
    
    

    
    
    self = [super init];
    if (self) {
        int theight = height - 40;
        int btnnum = theight/50;
        for(int i=0; i<btnnum; i++)
        {
            [self addButtonWithTitle:@" "];
        }
        
        
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        toolBar.barStyle = UIBarStyleBlackOpaque;
        NSDictionary* textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIColor whiteColor],UITextAttributeTextColor,
                                        nil];
        UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithTitle:title style: UIBarButtonItemStylePlain target: nil action: nil];
        [titleButton setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style: UIBarButtonItemStyleDone target: self action: @selector(done)];
        UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style: UIBarButtonItemStyleBordered target: self action: @selector(docancel)];
        UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil];
        NSArray *array = [[NSArray alloc] initWithObjects: leftButton,fixedButton, titleButton,fixedButton, rightButton, nil];
        [toolBar setItems: array];
        
        picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, 320, iOS7?height-30:216.0f)];
        
        picker.delegate = self;
        picker.dataSource =self;
      
        picker.showsSelectionIndicator = YES;
        
        picker.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [picker selectRow:0 inComponent:0 animated:YES];
        
        selectProvince = [provinceArray objectAtIndex:0];
        selectCity =[cityComponentArray objectAtIndex:0];
        
        [self addSubview:picker];
        
        [self addSubview:toolBar];
        
    }
    return self;
    
}




#pragma mark -
#pragma mark UIPickerViewDelegate  UIPickerViewDataSource



//以下是适配器部分，即数据源

//返回有几列
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
   
    
    //返回有几列
    return 2;
    
}


//返回指定列的行数
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
   
    
    if (component==0) {
        
        NSInteger i = [provinceArray count];
        CCLog(@"count = %d",i);
        return  [provinceArray count];
    } else if(component==1){
        
        return  [cityComponentArray count];
    }
    
    
    return 0;
}



//以下是代理部分，可以自定义视图



- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
   
    
    NSString *string = nil;
    
    
    if (component==0) {
        
        string = [provinceArray objectAtIndex:row];
        
    } else if(component ==1){
        
        string = [cityComponentArray objectAtIndex:row];
    }
    

    return string;
}



- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    
    
    if (component==0) {
        
        
        cityComponentArray = [self.dataDic objectForKey:[provinceArray objectAtIndex:row]];
        
        selectProvince = [provinceArray objectAtIndex:row];
        
        selectCity = [cityComponentArray objectAtIndex:0];
        
        [picker reloadComponent:1];
        
//        [picker selectRow:0 inComponent:1 animated:YES];
        
        
    } else{
        
        selectCity =[cityComponentArray objectAtIndex:row];
        
    }
    
}

-(UIView * )pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.minimumFontSize = 17.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:UITextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:17]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


-(void)done
{
    
    //处理选择之后的结果
    
       
    thisBlock(selectProvince,selectCity);
    
	[self dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)docancel
{
	[self dismissWithClickedButtonIndex:0 animated:YES];
}



@end
