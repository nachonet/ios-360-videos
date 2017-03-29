//
//  NYT360ViewerScene.m
//  ios-360-videos
//
//  Created by Nacho Diaz on 3/29/17.
//  Copyright © 2017 The New York Times Company. All rights reserved.
//

@import SpriteKit;
@import AVFoundation;

#import "NYT360ViewerScene.h"

///-----------------------------------------------------------------------------
/// NYT360ViewerScene
///-----------------------------------------------------------------------------

@interface NYT360ViewerScene ()

@property (nonatomic, readonly) SCNNode *cameraNode;
@property (nonatomic, readonly) SKSpriteNode *spriteNode;
@property (nonatomic, readonly) UIImage *image;

@end

@implementation NYT360ViewerScene

- (instancetype)initWithUIImage:(UIImage *)image boundToView:(SCNView *)view {
	if ((self = [super init])) {
		
		_image = image;
		
		_camera = [SCNCamera new];
		
		_cameraNode = ({
			SCNNode *cameraNode = [SCNNode new];
			cameraNode.camera = _camera;
			cameraNode.position = SCNVector3Make(0, 0, 0);
			cameraNode;
		});
		[self.rootNode addChildNode:_cameraNode];
		
		SKScene *skScene = ({
			SKScene *scene = [[SKScene alloc] initWithSize:image.size];
			scene.shouldRasterize = YES;
			scene.scaleMode = SKSceneScaleModeAspectFit;
			_spriteNode = ({
				SKTexture* aTexture = [SKTexture textureWithImage:image];
				SKSpriteNode *spriteNode = [[SKSpriteNode alloc] initWithTexture:aTexture];
				spriteNode.position = CGPointMake(scene.size.width / 2, scene.size.height / 2);
				spriteNode.size = scene.size;
				spriteNode.yScale = -1;
				spriteNode.xScale = -1;
				spriteNode;
			});
			[scene addChild:_spriteNode];
			scene;
		});
		
		SCNNode *sphereNode = ({
			SCNNode *sphereNode = [SCNNode new];
			sphereNode.position = SCNVector3Make(0, 0, 0);
			sphereNode.geometry = [SCNSphere sphereWithRadius:100.0]; //TODO [DZ]: What is the correct size here?
			sphereNode.geometry.firstMaterial.diffuse.contents = skScene;
			sphereNode.geometry.firstMaterial.diffuse.minificationFilter = SCNFilterModeLinear;
			sphereNode.geometry.firstMaterial.diffuse.magnificationFilter = SCNFilterModeLinear;
			sphereNode.geometry.firstMaterial.doubleSided = YES;
			sphereNode;
		});
		[self.rootNode addChildNode:sphereNode];
		
		view.scene = self;
		view.pointOfView = self.cameraNode;
	}
	
	return self;
}


@end
