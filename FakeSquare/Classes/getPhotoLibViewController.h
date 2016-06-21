//
//  getPhotoLibViewController.h
//  FakeSquare
//
//  Created by Azzaro Mujic on 20/06/16.
//  Copyright © 2016 Azzaro Mujic. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AssetsLibrary/AssetsLibrary.h>

@protocol getPhotoLibViewControllerDelegate <NSObject>
-(void)allPhotosCollected:(NSArray *)imgArray;
@end

@interface getPhotoLibViewController : NSObject
{
    
    ALAssetsLibrary *library;
    NSArray *imageArray;
    NSMutableArray *mutableArray;
}

@property (weak, nonatomic) id<getPhotoLibViewControllerDelegate> delegate;
-(void)getAllPictures;
-(void)allPhotosCollected:(NSArray*)imgArray;

@end