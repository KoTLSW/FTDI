//
//  ViewController.m
//  FTDI
//
//  Created by Robin on 2018/8/8.
//  Copyright © 2018年 mactest. All rights reserved.
//

#import "ViewController.h"
#import "ftd2xx.h"
#include <string.h>
#import "AlertTool.h"
@interface ViewController(){

     int  ftdiPortStatus;
     FT_HANDLE myHandle;
     FT_HANDLE closeHandle;

}

@end

@implementation ViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     ftdiPortStatus = FT_DEVICE_NOT_FOUND;
}


-(void)searchFDTIDevice{
     DWORD numDevs = 0;
    
     // Grab the number of attached devices
     ftdiPortStatus = FT_ListDevices(&numDevs, NULL, FT_LIST_NUMBER_ONLY);
     if (ftdiPortStatus != FT_OK)
     {
          NSLog(@"Electronics error: Unable to list devices");
          return;
     }
     
     
     if (numDevs == 0) {
          NSLog(@"没有找到串口");
          return;
     }
     
     
     // Find the device number of the electronics
     for (int currentDevice = 0; currentDevice < numDevs; currentDevice++)
     {
          char Buffer[64];
          ftdiPortStatus = FT_ListDevices((PVOID)currentDevice,Buffer,FT_LIST_BY_INDEX|FT_OPEN_BY_DESCRIPTION);
          NSString *portDescription = [NSString stringWithCString:Buffer encoding:NSASCIIStringEncoding];
          if ( (![portDescription isEqualToString:@""])) // && (usbRelayPointer != NULL)
          {
               ftdiPortStatus = FT_OpenEx(Buffer,FT_OPEN_BY_DESCRIPTION,&myHandle);
              //ftdiPortStatus = FT_OpenEx("FT000001",FT_OPEN_BY_SERIAL_NUMBER,&myHandle);
               if (ftdiPortStatus != FT_OK)
               {
                    NSLog(@"Electronics error: Can't open USB relay device: %d", (int)ftdiPortStatus);
                   NSLog(@"擦写串口的名字失败，失败错误码为 %d",ftdiPortStatus);
                   NSString *info= [NSString stringWithFormat:@"Error code is: %d.",ftdiPortStatus];
                   [[AlertTool sharaInstance] showMesssage:@"open Serial-Port fail." subMessage:info image:nil inWindow:nil];

                    return;
               }else{
                    NSLog(@"打开设备成功");
               }


              char serialNumber[16];
              char description[64];
              DWORD Flags;
              DWORD ID;
              DWORD Type;
              DWORD LocId;
              
              FT_DEVICE ftDevice;
              DWORD deviceID;
              ftdiPortStatus = FT_CreateDeviceInfoList(&numDevs);
              
              
              ftdiPortStatus = FT_GetDeviceInfoDetail(0,&Flags,&Type,&ID,&LocId,serialNumber,description,&myHandle);
              if (ftdiPortStatus == FT_OK) {
                  NSLog(@"serialNumber is %s,description is %s",serialNumber,description);
                  self.olderName.stringValue = [NSString stringWithCString:serialNumber encoding:NSUTF8StringEncoding];
                  
              }

              
              
               [self closeSerialPort];

               if (ftdiPortStatus != FT_OK) {
                    NSLog(@"获取设备的信息失败,失败码为：%d",ftdiPortStatus);
               }else{
//                    NSString* path =[NSString stringWithCString:serialPath encoding:NSUTF8StringEncoding];
//                    NSString*description = [NSString stringWithCString:desc encoding:NSUTF8StringEncoding];
//                    NSLog(@"设备的路径为：%@,描述为：%@",path,description);
//                    [NSThread sleepForTimeInterval:1.5];
//                   dispatch_async(dispatch_get_main_queue(), ^{
//                       NSLog(@"------2");
//                       self.olderName.stringValue = path;
//                   });


               }
              

            
          }
     }
     
}


//关闭设备

-(void)closeSerialPort{
    ftdiPortStatus = FT_Close(myHandle);
    if (ftdiPortStatus != FT_OK) {
        NSLog(@"关闭设备失败，失败码为：%d",ftdiPortStatus);
    }else{
        NSLog(@"关闭设备成功");
    }
    
}


- (void)setRepresentedObject:(id)representedObject {
     [super setRepresentedObject:representedObject];

     // Update the view, if already loaded.
}

- (IBAction)clickSearch:(id)sender {
    
    [self searchFDTIDevice];


}




- (IBAction)clickModify:(id)sender {
    
    if (self.changedName.stringValue.length == 0) {
        [[AlertTool sharaInstance] showMesssage:@"Pls enter the new Serial-port name." subMessage:@"new Serial-port name cannot be empty!" image:nil inWindow:nil];
        
        return;
    }
    
    
    
    DWORD numDevs = 0;
    ftdiPortStatus = FT_ListDevices(&numDevs, NULL, FT_LIST_NUMBER_ONLY);
    if (ftdiPortStatus != FT_OK)
    {
        NSLog(@"Electronics error: Unable to list devices");
        return;
    }
    
    if (numDevs == 0) {
        NSLog(@"没有找到串口");
        return;
    }
    
    // Find the device number of the electronics
    for (int currentDevice = 0; currentDevice < numDevs; currentDevice++)
    {
        char Buffer[64];
        ftdiPortStatus = FT_ListDevices((PVOID)currentDevice,Buffer,FT_LIST_BY_INDEX|FT_OPEN_BY_DESCRIPTION);
        NSString *portDescription = [NSString stringWithCString:Buffer encoding:NSASCIIStringEncoding];
        if ( (![portDescription isEqualToString:@""])) // && (usbRelayPointer != NULL)
        {
            ftdiPortStatus = FT_OpenEx(Buffer,FT_OPEN_BY_DESCRIPTION,&myHandle);
            //ftdiPortStatus = FT_OpenEx("FT000001",FT_OPEN_BY_SERIAL_NUMBER,&myHandle);
            if (ftdiPortStatus != FT_OK)
            {
                NSLog(@"Electronics error: Can't open USB relay device: %d", (int)ftdiPortStatus);
                return;
            }else{
                NSLog(@"打开设备成功");
            }

        }
    }
    
    
     //[self RESET:nil];
     // NSString *path = [NSString stringWithFormat:@""]
    
      FT_PROGRAM_DATA data = [self getDataConfigWith:(char*)[self.changedName.stringValue UTF8String]];
    
    
      ftdiPortStatus = FT_EE_Program(myHandle,&data);
    
      //[self.changedName.stringValue cStringUsingEncoding:NSUTF16StringEncoding];
    
     // ftdiPortStatus = FT_WriteEE(myHandle,0x0008,0x6040);
    
     
     if (ftdiPortStatus == FT_OK) {
          NSLog(@"擦写串口的名字成功");
         [[AlertTool sharaInstance] showMesssage:@"Change the Serial-port name Successfully." subMessage:@"Pls power off and power on to verify." image:nil inWindow:nil];
         

     }else{
          NSLog(@"擦写串口的名字失败，失败错误码为 %d",ftdiPortStatus);
         NSString *info= [NSString stringWithFormat:@"Error code is:%d.",ftdiPortStatus];
         [[AlertTool sharaInstance] showMesssage:@"Change the Serial-Port name Fail." subMessage:info image:nil inWindow:nil];
         
     }
    
    
    [self closeSerialPort];
    
}

- (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
        hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
        hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}





-(FT_PROGRAM_DATA)getDataConfigWith:(char*)serialPath{

        
    FT_PROGRAM_DATA ftData = {
        0x00000000,
        0xFFFFFFFF,
        0x00000002,
        0x0403,
        0x6001,
        "FTDI",
        "FT",
        "USB HS Serial Converter",
        serialPath,
        44,
        1,
        0,
        1,
        1,
        0,
        0,
        0,
        1,
        0,
        0x0110,
        0,
        0,
        0,
        0, // non-zero if out endpoint is isochronous
        0, // non-zero if out endpoint is isochronous
        0, // non-zero if pull down enabled
        1, // non-zero if serial number to be used
        0, // non-zero if chip uses USBVersion
        0x0, // BCD (0x0200 => USB2)
        0, // non-zero if interface is high current
        0, // non-zero if interface is high current
        0, // non-zero if interface is 245 FIFO
        0, // non-zero if interface is 245 FIFO CPU target
        0, // non-zero if interface is Fast serial
        0, // non-zero if interface is to use VCP drivers
        0, // non-zero if interface is 245 FIFO
        0, // non-zero if interface is 245 FIFO CPU target
        0, // non-zero if interface is Fast serial
        0, // non-zero if interface is to use VCP drivers
        //
        
        // FT232R extensions (Enabled if Version = 2 or greater)
        //
        0, // Use External Oscillator
        1, // High Drive I/Os
        0, // Endpoint size
        0, // non-zero if pull down enabled
        1, // non-zero if serial number to be used
        0, // non-zero if invert TXD
        0, // non-zero if invert RXD
        0, // non-zero if invert RTS
        0, // non-zero if invert CTS
        0, // non-zero if invert DTR
        0, // non-zero if invert DSR
        0, // non-zero if invert DCD
        0, // non-zero if invert RI
        0, // Cbus Mux control
        0, // Cbus Mux control
        0, // Cbus Mux control
        0, // Cbus Mux control
        0, // Cbus Mux control
        0, // non-zero if using D2XX
        //
        // Rev 7 (FT2232H) Extensions (Enabled if Version = 3 or greater)
        //
        0, // non-zero if pull down enabled
        1, // non-zero if serial number to be used  -----mychange
        0, // non-zero if AL pins have slow slew
        0, // non-zero if AL pins are Schmitt input
        0, // valid values are 4mA, 8mA, 12mA, 16mA
        0, // non-zero if AH pins have slow slew
        0, // non-zero if AH pins are Schmitt input
        0, // valid values are 4mA, 8mA, 12mA, 16mA
        0, // non-zero if BL pins have slow slew
        0, // non-zero if BL pins are Schmitt input
        0, // valid values are 4mA, 8mA, 12mA, 16mA
        0, // non-zero if BH pins have slow slew
        0, // non-zero if BH pins are Schmitt input
        0, // valid values are 4mA, 8mA, 12mA, 16mA
        0, // non-zero if interface is 245 FIFO
        0, // non-zero if interface is 245 FIFO CPU
        0, // non-zero if interface is Fast serial
        0, // non-zero if interface is to use VCP drivers
        0, // non-zero if interface is 245 FIFO
        0, // non-zero if interface is 245 FIFO CPU target
        0, // non-zero if interface is Fast serial
        0, // non-zero if interface is to use VCP drivers
        0, // non-zero if using BCBUS7 to save power for self-
        // powered designs
        //VWESION 8
        0, // non-zero if pull down enabled
        1, // non-zero if serial number to be used   mychange
        0, // non-zero if AL pins have slow slew
        0, // non-zero if AL pins are Schmitt input
        0, // valid values are 4mA, 8mA, 12mA, 16mA
        0, // non-zero if AH pins have slow slew
        0, // non-zero if AH pins are Schmitt input
        0, // valid values are 4mA, 8mA, 12mA, 16mA
        0, // non-zero if BL pins have slow slew
        0, // non-zero if BL pins are Schmitt input
        0, // valid values are 4mA, 8mA, 12mA, 16mA
        0, // non-zero if BH pins have slow slew
        0, // non-zero if BH pins are Schmitt input
        0, // valid values are 4mA, 8mA, 12mA, 16mA
        0, // non-zero if port A uses RI as RS485 TXDEN
        0, // non-zero if port B uses RI as RS485 TXDEN
        0, // non-zero if port C uses RI as RS485 TXDEN
        0, // non-zero if port D uses RI as RS485 TXDEN
        0, // non-zero if interface is to use VCP drivers
        0, // non-zero if interface is to use VCP drivers
        0, // non-zero if interface is to use VCP drivers
        0 // non-zero if interface is to use VCP drivers
    };
    return ftData;
    
}



@end
