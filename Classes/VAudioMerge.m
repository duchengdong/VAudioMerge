//
//  VAudioMerge.m
//  Pods-VAudioMerge_Tests
//
//  Created by 杜成东 on 2019/12/17.
//

#import "VAudioMerge.h"
#import <AVFoundation/AVFoundation.h>

@implementation VAudioMerge
-(void)mergeAudioSourceUrls:(NSArray *)sourceUrls destiontionUrl:(NSString *)destiontionUrl completionHandler:(void (^)(void))handler{
    AVMutableComposition* mixComposition = [AVMutableComposition composition];
    AVMutableCompositionTrack *compositionAudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    CMTime beginTime = kCMTimeZero;
    
    NSError *error = nil;
    
    for (int i=0;i<sourceUrls.count;i++) {
        NSURL *sourceURL = sourceUrls[i];
        AVURLAsset  *audioAsset = [[AVURLAsset alloc]initWithURL:sourceURL options:nil];
        CMTimeRange audio_timeRange = CMTimeRangeMake(kCMTimeZero, audioAsset.duration);
        BOOL success = [compositionAudioTrack insertTimeRange:audio_timeRange ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:beginTime error:&error];
        if (!success) {
            NSLog(@"插入音频失败: %@",error);
            
            return;
        }
        beginTime = CMTimeAdd(beginTime, audioAsset.duration);
    }
    
    
    AVAssetExportSession* assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetAppleM4A];
    assetExport.outputURL = [NSURL fileURLWithPath:destiontionUrl];
    assetExport.outputFileType = @"com.apple.m4a-audio";
    [assetExport exportAsynchronouslyWithCompletionHandler:^{
        //      4.5 分发到主线程
        NSLog(@"合并完成%@",destiontionUrl);
        dispatch_async(dispatch_get_main_queue(), ^{
            handler();
        });
        
        
    }];
}
@end
