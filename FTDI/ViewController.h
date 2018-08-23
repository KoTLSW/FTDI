//
//  ViewController.h
//  FTDI
//
//  Created by Robin on 2018/8/8.
//  Copyright © 2018年 mactest. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController



@property (strong) IBOutlet NSTextFieldCell *olderName;

@property (strong) IBOutlet NSTextFieldCell *changedName;

- (IBAction)clickSearch:(id)sender;

- (IBAction)clickModify:(id)sender;

@end

