//
//  oglMVModel.h
//  oglModelViewer
//
//  Created by Łukasz on 11.09.2014.
//  Copyright (c) 2014 apios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "oglMVMesh.h"

@interface oglMVModel : NSObject
{
@private
    unsigned int mMeshCount;
    NSMutableArray* mMeshArray;
}

-(bool)parseModel:(NSString*) path;

-(unsigned long)getMeshCount;

-(NSString*)getNameFromMesh:(unsigned long) mesh;

-(unsigned int)getVertexBufferFromMesh:(unsigned long) mesh;
-(unsigned int)getVertexCountFromMesh:(unsigned long) mesh;
-(float*)getVertexPtrFromMesh:(unsigned long) mesh;

-(unsigned int)getFaceBufferFromMesh:(unsigned long) mesh;
-(unsigned int)getFaceCountFromMesh:(unsigned long) mesh;
-(int*)getFacePtrFromMesh:(unsigned long) mesh;

@end
