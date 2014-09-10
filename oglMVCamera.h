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
}

-(void)update:(float) deltaX and: (float) deltaY;
-(GLKVector4)getPos;
-(GLKVector4)getDir;
-(GLKVector4)getUp;
-(GLKMatrix4)getViewMatrix;

@end
