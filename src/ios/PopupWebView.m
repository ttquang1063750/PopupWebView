/********* PopupWebView.m Cordova Plugin Implementation *******/

#import "PopupWebView.h"


#pragma implement PopupWebView
@implementation PopupWebView


- (void)show:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* url = [[command.arguments objectAtIndex:0] objectForKey:@"url"];
    if (url != nil && [url length] > 0) {
        [[[PopupViewController alloc] init] navigateTo:url root:self.viewController];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:url];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end


#pragma implement PopupViewController
@implementation PopupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        [self loadView];
    }
    return self;
}

- (void) loadView {
    CGRect screen = [[UIScreen mainScreen] bounds];
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)];
    [self viewDidLoad];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //Get screen devices
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    //Init WebView
    self.popView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)];
    
    UIButton *btnClose = [[UIButton alloc] initWithFrame:CGRectMake(screen.size.width - 101, 20, 81, 80)];
    UIImage *image = [UIImage imageNamed:@"btn_close.png"];
    [btnClose setBackgroundImage:image forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(btnClose) forControlEvents:UIControlEventTouchUpInside];
    
    self.popView.delegate = self;
    self.popView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.popView];
    [self.popView addSubview:btnClose];

    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.frame = CGRectMake(screen.size.width/2 - 20, screen.size.height/2 - 20, 40, 40);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
}

- (void)viewDidUnload
{
    self.popView.delegate = nil;
    [super viewDidUnload];
}

-(void)btnClose{
    __weak UIViewController* theView = self;
    // Run later to avoid the "took a long time" log message.
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([theView respondsToSelector:@selector(presentingViewController)]) {
            [[theView presentingViewController] dismissViewControllerAnimated:YES completion:nil];
        } else {
            [[theView parentViewController] dismissViewControllerAnimated:YES completion:nil];
        }
    });
}

-(void)navigateTo:(NSString*)thUrl root: (UIViewController*) theRoot{
    NSURL *url = [NSURL URLWithString:thUrl];
    [self.popView loadRequest:[NSURLRequest requestWithURL:url]];
    [theRoot presentViewController:self animated:TRUE completion:nil];
}

#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView*)theWebView
{
    // loading url, start spinner, update back/forward
    NSLog(@"loading: %@", [theWebView.request.URL relativeString]);
    [spinner startAnimating];
}

- (BOOL)webView:(UIWebView*)theWebView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"Finished: %@", [webView.request.URL relativeString]);
    [spinner stopAnimating];
}

- (void)webView:(UIWebView*)theWebView didFailLoadWithError:(NSError*)error
{
    // log fail message, stop spinner, update back/forward
    NSLog(@"webView:didFailLoadWithError - %ld: %@", (long)error.code, [error localizedDescription]);
    [spinner stopAnimating];
    [self btnClose];
}
@end
