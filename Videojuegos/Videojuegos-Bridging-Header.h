//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface VideoPlayer : NSObject

+ (AVPlayerViewController *)playVideo:(NSString *) urlVideo;
@end
