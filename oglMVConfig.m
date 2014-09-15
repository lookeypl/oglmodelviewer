//
//  oglMVConfig.m
//  oglModelViewer
//
//  Created by Łukasz on 15.09.2014.
//  Copyright (c) 2014 apios. All rights reserved.
//

#import "oglMVConfig.h"

@implementation oglMVConfig

-(bool)readConfig
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docDir = [paths objectAtIndex:0];
    NSString* plistPath = [docDir stringByAppendingPathComponent:@"oglModelViewerConfig.plist"];

    // config is not available at Documents direcotry
    if (![[NSFileManager defaultManager] isReadableFileAtPath:plistPath])
    {
        // get path do default config
        NSString* defPlistPath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
        if (!defPlistPath)
        {
            NSLog(@"Cannot find config.plist resource.");
            return false;
        }

        NSLog(@"Copying default config file from %@", defPlistPath);
        // copy it to Documents directory and continue on with loading
        [[NSFileManager defaultManager] copyItemAtPath:defPlistPath toPath:plistPath error:nil];
    }

    //NSArray* rootArray = [NSArray arrayWithContentsOfFile:plistPath];
    NSDictionary* rootDict = [[NSDictionary alloc] initWithContentsOfFile: plistPath];

    // read data from root
    mMouseSensitivity = [[rootDict objectForKey:@"MouseSensitivity"] floatValue];
    mMouseScrollSensitivity = [[rootDict objectForKey:@"MouseScrollSensitivity"] floatValue];
    mMouseExponentialScroll = [[rootDict objectForKey:@"ExponentialScrollEnabled"] boolValue];

    mXYZArrowsEnabled = [[rootDict objectForKey:@"XYZArrowsEnabled"] boolValue];
    mGridEnabled = [[rootDict objectForKey:@"GridEnabled"] boolValue];

    // read data from BackgroundColor dictionary
    NSDictionary* colorDict = [rootDict objectForKey:@"BackgroundColor"];

    mBackgroundColorRed = [[colorDict objectForKey:@"Red"] floatValue];
    mBackgroundColorGreen = [[colorDict objectForKey:@"Green"] floatValue];
    mBackgroundColorBlue = [[colorDict objectForKey:@"Blue"] floatValue];

    // apply correction to received data if it is incorrect
    if (mMouseSensitivity > 100.0f)
        mMouseSensitivity = 100.0f;
    if (mMouseSensitivity < 10.0f)
        mMouseSensitivity = 10.0f;

    if (mMouseScrollSensitivity > 50.0f)
        mMouseScrollSensitivity = 50.0f;
    if (mMouseScrollSensitivity < 10.0f)
        mMouseScrollSensitivity = 10.0f;

    if (mBackgroundColorRed > 255.0f)
        mBackgroundColorRed = 255.0f;
    if (mBackgroundColorRed < 0.0f)
        mBackgroundColorRed = 0.0f;

    if (mBackgroundColorGreen > 255.0f)
        mBackgroundColorGreen = 255.0f;
    if (mBackgroundColorGreen < 0.0f)
        mBackgroundColorGreen = 0.0f;

    if (mBackgroundColorBlue > 255.0f)
        mBackgroundColorBlue = 255.0f;
    if (mBackgroundColorBlue < 0.0f)
        mBackgroundColorBlue = 0.0f;

    return true;
}

-(bool)saveConfig
{
    // apply correction to received data if it is incorrect
    if (mMouseSensitivity > 100.0f)
        mMouseSensitivity = 100.0f;
    if (mMouseSensitivity < 10.0f)
        mMouseSensitivity = 10.0f;

    if (mMouseScrollSensitivity > 50.0f)
        mMouseScrollSensitivity = 50.0f;
    if (mMouseScrollSensitivity < 10.0f)
        mMouseScrollSensitivity = 10.0f;

    if (mBackgroundColorRed > 255.0f)
        mBackgroundColorRed = 255.0f;
    if (mBackgroundColorRed < 0.0f)
        mBackgroundColorRed = 0.0f;

    if (mBackgroundColorGreen > 255.0f)
        mBackgroundColorGreen = 255.0f;
    if (mBackgroundColorGreen < 0.0f)
        mBackgroundColorGreen = 0.0f;

    if (mBackgroundColorBlue > 255.0f)
        mBackgroundColorBlue = 255.0f;
    if (mBackgroundColorBlue < 0.0f)
        mBackgroundColorBlue = 0.0f;

    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docDir = [paths objectAtIndex:0];
    NSString* plistPath = [docDir stringByAppendingPathComponent:@"oglModelViewerConfig.plist"];

    NSMutableDictionary* rootDict = [[NSMutableDictionary alloc] initWithContentsOfFile: plistPath];
    NSMutableDictionary* colorDict = [[NSMutableDictionary alloc] init];

    [colorDict setObject: [NSNumber numberWithFloat:mBackgroundColorRed] forKey:@"Red"];
    [colorDict setObject: [NSNumber numberWithFloat:mBackgroundColorGreen] forKey:@"Green"];
    [colorDict setObject: [NSNumber numberWithFloat:mBackgroundColorBlue] forKey:@"Blue"];

    [rootDict setObject: colorDict forKey:@"BackgroundColor"];

    [rootDict setObject: [NSNumber numberWithBool:mGridEnabled] forKey:@"GridEnabled"];
    [rootDict setObject: [NSNumber numberWithBool:mXYZArrowsEnabled] forKey:@"XYZArrowsEnabled"];

    [rootDict setObject: [NSNumber numberWithFloat:mMouseSensitivity] forKey:@"MouseSensitivity"];
    [rootDict setObject: [NSNumber numberWithFloat:mMouseScrollSensitivity] forKey:@"MouseScrollSensitivity"];
    [rootDict setObject: [NSNumber numberWithBool:mMouseExponentialScroll] forKey:@"ExponentialScrollEnabled"];

    [rootDict writeToFile:plistPath atomically:YES];

    return true;
}

@end
