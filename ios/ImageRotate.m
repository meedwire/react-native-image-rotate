#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(ImageRotate, NSObject)
                
RCT_EXTERN_METHOD(rotate:(NSDictionary *)options
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
