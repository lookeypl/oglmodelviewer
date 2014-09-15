//
//  oglMVConfig.h
//  oglModelViewer
//
//  Created by Łukasz on 15.09.2014.
//  Copyright (c) 2014 apios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface oglMVConfig : NSObject
{
@public
    float mBackgroundColorRed;
    float mBackgroundColorGreen;
    float mBackgroundColorBlue;

    float mMouseSensitivity;
    float mMouseScrollSensitivity;
    bool mMouseExponentialScroll;

    bool mXYZArrowsEnabled;
    bool mGridEnabled;
}

-(bool)readConfig;
-(bool)saveConfig;

@end
