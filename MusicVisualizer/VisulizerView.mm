//
//  VisulizerView.m
//  MusicVisualizer
//
//  Created by Kangsoo Jung on 2014. 12. 29..
//  Copyright (c) 2014년 Jung. All rights reserved.
//

#import "VisulizerView.h"
#import <QuartzCore/QuartzCore.h>
#import "MEterTable.h"

@implementation VisulizerView{
    CAEmitterLayer *emitterLayer;
    MeterTable meterTable;
    
}
+(Class)layerClass{
    return [CAEmitterLayer class];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor blackColor];
        emitterLayer = (CAEmitterLayer *)self.layer;
        
        CGFloat width = MAX(frame.size.width, frame.size.height);
        CGFloat height = MIN(frame.size.width, frame.size.height);
        
        emitterLayer.emitterPosition = CGPointMake(width/2, height/2);
        emitterLayer.emitterSize = CGSizeMake(width-80, 60);
        emitterLayer.emitterShape = kCAEmitterLayerRectangle;
        emitterLayer.renderMode = kCAEmitterLayerAdditive;
        
        
        CAEmitterCell *cell = [CAEmitterCell emitterCell];
        cell.name=@"cell";
    //    cell.contents = (id)[[UIImage imageNamed:@"particleTexture.png"]CGImage];
        CAEmitterCell *childCell = [CAEmitterCell emitterCell];
        childCell.name = @"childCell";
        childCell.lifetime = 1.0f/60.0f;
        childCell.birthRate = 60.0f;
        childCell.velocity = 0.0f;
        childCell.contents = (id)[[UIImage imageNamed:@"particleTexture.png"]CGImage];
        
        cell.emitterCells = @[childCell];
        
        cell.color = [[UIColor colorWithRed:1.0f green: 0.53f blue:0.0f alpha:0.8f]CGColor];
        cell.redRange = 0.46f;
        cell.greenRange = 0.49f;
        cell.blueRange = 0.67f;
        cell.alphaRange = 0.55f;
        
        cell.redSpeed = 0.11f;
        cell.greenSpeed = 0.07f;
        cell.blueSpeed = -0.25f;
        cell.alphaSpeed = 0.15f;
        
        cell.scale = 0.5;
        cell.scaleRange = 0.5;
        
        cell.lifetime = 1.0f;
        cell.lifetimeRange = 0.25f;
        cell.birthRate = 80;
        
        cell.velocity = 100.0f;
        cell.velocityRange = 300.0f;
        cell.emissionRange = M_PI * 2;
        
        emitterLayer.emitterCells = @[cell];
        CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

-(void)update{
    float scale = 0.5;
    if (self.audioPlayer.isPlaying){
        [self.audioPlayer updateMeters];
        
        float power = 0.0;
        
        for(int i=0;i<self.audioPlayer.numberOfChannels; i++)
        {
            power+= [self.audioPlayer averagePowerForChannel:i];
            
        }
        power /=self.audioPlayer.numberOfChannels;
        
        float level = meterTable.ValueAt(power);
        
        scale = level * 5;
        
    }
    [emitterLayer setValue:@(scale) forKeyPath:@"emitterCells.cell.emitterCells.childCell.scale"];
   
}

@end
