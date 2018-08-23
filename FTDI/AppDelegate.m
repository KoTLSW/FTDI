//
//  AppDelegate.m
//  FTDI
//
//  Created by Robin on 2018/8/8.
//  Copyright © 2018年 mactest. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
     // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
     // Insert code here to tear down your application
}

@end


//               //Turn off bit bang mode
//               ftdiPortStatus = FT_SetBitMode(myHandle, 0x00,0);
//               if (ftdiPortStatus != FT_OK)
//               {
//                    NSLog(@"Electronics error: Can't set bit bang mode");
//                    return;
//               }
//               // Reset the device
//               ftdiPortStatus = FT_ResetDevice(myHandle);
//               // Purge transmit and receive buffers
//               ftdiPortStatus = FT_Purge(myHandle, FT_PURGE_RX | FT_PURGE_TX);
//               // Set the baud rate
//               ftdiPortStatus = FT_SetBaudRate(myHandle, 9600);
//               // 1 s timeouts on read / write
//               ftdiPortStatus = FT_SetTimeouts(myHandle, 1000, 1000);
//               // Set to communicate at 8N1
//               ftdiPortStatus = FT_SetDataCharacteristics(myHandle, FT_BITS_8, FT_STOP_BITS_1, FT_PARITY_NONE); // 8N1
//               // Disable hardware / software flow control
//               ftdiPortStatus = FT_SetFlowControl(myHandle, FT_FLOW_NONE, 0, 0);
//               // Set the latency of the receive buffer way down (2 ms) to facilitate speedy transmission
//               ftdiPortStatus = FT_SetLatencyTimer(myHandle,2);
//               if (ftdiPortStatus != FT_OK)
//               {
//                    NSLog(@"Electronics error: Can't set latency timer");
//                    return;
//               }
