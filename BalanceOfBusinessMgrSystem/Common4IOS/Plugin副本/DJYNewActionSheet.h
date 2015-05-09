//
//  DJYNewActionSheet.h
//  ipaycard
//
//  Created by Davidsph on 5/28/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConfigure.h"



typedef void (^ChooseCityResultBlock)(NSString *province ,NSString *city);


@interface DJYNewActionSheet : UIActionSheet<UIPickerViewDataSource,UIPickerViewDelegate>

{
    
    ChooseCityResultBlock thisBlock;
    
}

- (id) initActionSheetWithHeight:(float) height title:(NSString *)title dataSource:(NSDictionary *) data  resultBlock:(ChooseCityResultBlock) resultBlock;





@end
