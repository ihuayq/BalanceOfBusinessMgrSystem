//
//  Created by locojoy on 14-3-4.
//  Copyright (c) 2014年 locojoy. All rights reserved.
//

#ifndef Utils_h
#define Utils_h

#include <string>

#ifndef MAX
#define MAX(x,y) (((x) < (y)) ? (y) : (x))
#endif  // MAX

extern std::string getBundleId();
extern void LJLog(const char * pszFormat, ...);
extern std::string UrlEncode(const std::string& str);
extern std::string getMD5(const char *buf);
extern std::string base64Encode(std::string& str);
extern std::string base64Decode(std::string& str);
extern std::string getIPAddress();
extern std::string getMacAddress();
extern std::string parseParamFromUrl(const char *url, const char *param);

extern void showLoadingView(const char *msg);
extern void hideLoadingView();

#endif
