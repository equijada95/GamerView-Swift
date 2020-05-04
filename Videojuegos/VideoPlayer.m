//
//  VideoPlayer.m
//  Videojuegos
//
//  Created by MIMO on 04/05/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "Videojuegos-Bridging-Header.h"

@implementation VideoPlayer 

+(AVPlayerViewController *) playVideo:(NSString *) urlVideo{
    NSURL *videoURL = [NSURL URLWithString:urlVideo];
    AVPlayer *player = [AVPlayer playerWithURL:videoURL];
    AVPlayerViewController *playerViewController = [AVPlayerViewController new];
    playerViewController.player = player;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    return playerViewController;
}


@end


