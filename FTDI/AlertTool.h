//
//  AlertTool.h
//  B500Test
//
//  Created by linanlin on 2017/8/4.
//  Copyright © 2017年 linanlin. All rights reserved.
//

/*
   提示弹框都在这个类里面做
 */
#import <Foundation/Foundation.h>
@import AppKit;

@interface AlertTool : NSObject

+(instancetype)sharaInstance;

/*
 @param :message 粗体的提示信息
 @param :subMessage 小字号的信息提示
 @param :imageName 提示框前面的image 的名字
 @param : window 要显示的哪个view里面，默认是 NSwindow
 @dicussion :
 */

-(void)showMesssage:(NSString *)message subMessage:(NSString*)subMesssage image:(NSString*)imageName inWindow:(NSWindow*)window;


/*
 @param :message 粗体的提示信息
 @param :informative 小字号的信息提示
 @param :errorMessage 密码输入错误后弹出的 粗 体警告
 @param :subinformative 密码输入错误后弹出的 小 字体体警告
 @param : labelText 输入密码错误后的enter键的文字，默认是enter
 @dicussion :
 */



-(BOOL)setAlertWithMessage:(NSString *)message Informative:(NSString *)informative errorMessage:(NSString *)errorMessage subInformative:(NSString *)subinformative errorWithButtonLable:(NSString *)lableText;


-(BOOL)setAlertWithMessage:(NSString *)message Submessage:(NSString *)informative OKBtnTxt:(NSString *)OKText CancelBtnTxt:(NSString *)CancelBtnTxt;

@end
