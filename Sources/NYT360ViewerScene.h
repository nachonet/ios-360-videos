//
//  NYT360ViewerScene.h
//  ios-360-videos
//
//  Created by Nacho Diaz on 3/29/17.
//  Copyright © 2017 The New York Times Company. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@import SceneKit;

/**
 A 3D viewer scene.
 */
@interface NYT360ViewerScene : SCNScene

@property (nonatomic, readonly) SCNCamera *camera;

- (instancetype)initWithUIImage:(UIImage *)image boundToView:(SCNView *)view;

@end

NS_ASSUME_NONNULL_END
