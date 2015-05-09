//
//  TradeDetail.h
//  ipaycard
//
//  Created by han bing on 13-1-17.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeDetail : NSObject{
    NSDictionary *tdDetail;
}
@property (nonatomic, retain) NSDictionary *tdDetail;

+(TradeDetail *) newInstence;
@end
