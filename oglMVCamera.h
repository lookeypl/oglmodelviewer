//
//  oglMVCamera.h
//  oglModelViewer
//
//  Created by Łukasz on 01.09.2014.
//  Copyright (c) 2014 apios. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <GLKit/GLKit.h>

@interface oglMVCamera : NSObject
{
    GLKVector4 mPos;
    GLKVector4 mDir;
    GLKVector4 mUp;

    GLKMatrix4 mViewMatrix;

    float mSensitivity;
    float mScrollSensitivity;
    bool mExponentialZoom;
}

-(void)update:(float) deltaX and: (float) deltaY;
-(void)updateZoom:(float) delta;

-(void)setSensitivity:(float) sensitivity;
-(void)setScrollSensitivity:(float) sensitivity;
-(void)setExponentialZoom:(bool) enabled;

-(GLKVector4)getPos;
-(GLKVector4)getDir;
-(GLKVector4)getUp;
-(GLKMatrix4)getViewMatrix;

@end
