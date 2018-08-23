//
//  AlertTool.m
//  B500Test
//
//  Created by linanlin on 2017/8/4.
//  Copyright © 2017年 linanlin. All rights reserved.
//

#import "AlertTool.h"
static AlertTool *singleInstance = nil;
@implementation AlertTool

+(instancetype)sharaInstance{
    if (singleInstance == nil) {
        singleInstance = [[self alloc]init];
        
    }
    return singleInstance;
}


-(void)showMesssage:(NSString *)message subMessage:(NSString*)subMesssage image:(NSString*)imageName inWindow:(NSWindow*)window
{
    NSAlert *alert=[NSAlert alertWithError:[NSError errorWithDomain:@"Error" code:-1 userInfo:nil]];
    [alert setMessageText:message];
    [alert setInformativeText:subMesssage];
    alert.icon=[NSImage imageNamed:@"Logo2"];
    alert.alertStyle=NSCriticalAlertStyle;
    if (window == nil) {
        window = [NSApplication sharedApplication].keyWindow;
    }
    [alert beginSheetModalForWindow:window completionHandler:^(NSModalResponse returnCode) {
        NSLog(@"alert 展示完毕");
    }];

}




-(BOOL)setAlertWithMessage:(NSString *)message Informative:(NSString *)informative errorMessage:(NSString *)errorMessage subInformative:(NSString *)subinformative errorWithButtonLable:(NSString *)lableText
{
 
    
    NSAlert *alert=[NSAlert alertWithMessageText:message defaultButton:@"下载" alternateButton:@"取消" otherButton:nil informativeTextWithFormat:@"%@", informative];
    
    alert.alertStyle=NSWarningAlertStyle;
    NSTextField *textFiled=[[NSTextField alloc]initWithFrame:CGRectMake(0, 30, 200, 20)];
     alert.accessoryView= nil;//textFiled;
    
    NSUInteger action=  [alert runModal];
    if (action == NSAlertDefaultReturn) {
         return true;
        
    }
    else
    {
        NSLog(@"NSAlertOtherButtonReturn");
        return NO;
        
    }
    return NO;
    
}

-(BOOL)setAlertWithMessage:(NSString *)message Submessage:(NSString *)informative OKBtnTxt:(NSString *)OKText CancelBtnTxt:(NSString *)CancelBtnTxt
{
     
     
     NSAlert *alert=[NSAlert alertWithMessageText:message defaultButton:OKText alternateButton:CancelBtnTxt otherButton:nil informativeTextWithFormat:@"%@", informative];
     
     alert.alertStyle=NSWarningAlertStyle;
     NSTextField *textFiled=[[NSTextField alloc]initWithFrame:CGRectMake(0, 30, 200, 20)];
     alert.accessoryView= nil;//textFiled;
     
     NSUInteger action=  [alert runModal];
     if (action == NSAlertDefaultReturn) {
          return true;
          
     }
     else
     {
          NSLog(@"NSAlertOtherButtonReturn");
          return NO;
          
     }
     return NO;
     
}

@end
