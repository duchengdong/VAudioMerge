//
//  VAudioMerge.h
//  Pods-VAudioMerge_Tests
//
//  Created by 杜成东 on 2019/12/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VAudioMerge : NSObject
/**
 音频合并
 sourceUrls:存储url对象
 destiontionUrl:音频合并后输出地址
 */
-(void)mergeAudioSourceUrls:(NSArray *)sourceUrls destiontionUrl:(NSString *)destiontionUrl completionHandler:(void (^)(void))handler;
@end

NS_ASSUME_NONNULL_END
