//
//  PopupWebView.h
//  MOBIONE
//
//  Created by GUMI-QUANG on 1/8/16.
//
//

#import <Cordova/CDV.h>
#import <Cordova/CDVViewController.h>

@interface PopupWebView : CDVPlugin
- (void)show:(CDVInvokedUrlCommand*)command;
@end


#pragma viewController
@interface PopupViewController: UIViewController <UIWebViewDelegate>{
    NSString* _url;
    UIActivityIndicatorView *spinner;
    UIButton *btnBack;
}
@property (nonatomic, strong) IBOutlet UIWebView* popView;
-(void)navigateTo:(NSString*)thUrl root: (UIViewController*) theRoot;
-(void)btnClose;
@end