//
//  CacheUUIDHelp.m
//  Test
//
//  Created by Acar on 2025/6/4.
//

#import "CacheUUIDHelp.h"

@implementation CacheUUIDHelp

- (NSString *)sysCacheUUID {
    
    NSString *plistPath = @"/private/var/containers/Shared/SystemGroup/systemgroup.com.apple.mobilegestaltcache/Library/Caches/com.apple.MobileGestalt.plist";

    NSLog(@"尝试读取: %@", plistPath);

    // 检查文件是否存在
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:plistPath];

    if (fileExists) {
        // 检查文件权限
        BOOL isReadable = [fileManager isReadableFileAtPath:plistPath];

        if (isReadable) {
            // 读取并解析plist文件
            NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:plistPath];

            if (plistData) {
                NSLog(@"成功读取plist文件，包含 %lu 个键值对", (unsigned long)[plistData count]);

                NSLog(@"%@",plistData);

                NSLog(@"设备唯一标识符CacheUUID = ：%@",plistData[@"CacheUUID"]);
                
                return plistData[@"CacheUUID"];

            } else {
                NSLog(@"无法解析plist文件内容");
                
                return @"";
            }
        } else {
            NSLog(@"文件存在但不可读取，可能需要root权限");
            return @"";
        }
    } else {
        NSLog(@"文件不存在: %@", plistPath);
        return @"";
    }
}

@end
