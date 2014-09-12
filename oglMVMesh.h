//
//  oglMVMesh.h
//  oglModelViewer
//
//  Created by Łukasz on 11.09.2014.
//  Copyright (c) 2014 apios. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <GLKit/GLKit.h>

@interface oglMVMesh : NSObject
{
@private
    NSString* mMeshName;

    unsigned int mVBID;
    NSMutableArray* mVertices;
    float* mVertPtr;
    unsigned int mVertexCount;

    unsigned int mIBID;
    NSMutableArray* mFaces;
    int* mFacePtr;
    unsigned int mFaceCount;
}

-(oglMVMesh*)init;
-(oglMVMesh*)initWithName:(NSString*) name;
-(void)dealloc;
-(NSString*)getName;
-(unsigned int)getVBID;
-(float*)getVertPtr;
-(unsigned int)getVertexCount;
-(unsigned int)getIBID;
-(int*)getFacePtr;
-(unsigned int)getFaceCount;

-(void)addVertex:(float) x yCoord:(float) y zCoord:(float) z;
-(void)addFace:(long) a bVert:(long) b cVert:(long) c;
-(void)generateBuffers;

@end
