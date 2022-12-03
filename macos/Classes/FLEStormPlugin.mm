//
//  FLEFlutterPlugin.mm
//  flutter_storm
//
//  Created by David Chavez on 06.11.20.
//

#import "FLEStormPlugin.h"
#include "../StormLib/src/StormLib.h"

#include <unordered_map>
#include <string>

namespace {
NSString *const kChannelName = @"flutter_storm";
NSString *const kFileOpenArchive = @"SFileOpenArchive";
NSString *const kFileCreateArchive = @"SFileCreateArchive";
NSString *const kFileCloseArchive = @"SFileCloseArchive";
NSString *const kFileHasFile = @"SFileHasFile";
NSString *const kFileCreateFile = @"SFileCreateFile";
NSString *const kFileWriteFile = @"SFileWriteFile";
NSString *const kFileCloseFile = @"SFileCloseFile";
NSString *const kFileRemoveFile = @"SFileRemoveFile";
NSString *const kFileRenameFile = @"SFileRenameFile";
NSString *const kFileFinishFile = @"SFileFinishFile";
NSString *const kFileFindFirstFile = @"SFileFindFirstFile";
NSString *const kFileFindNextFile = @"SFileFindNextFile";
NSString *const kFileFindClose = @"SFileFindClose";
NSString *const kFileOpenFileEx = @"SFileOpenFileEx";
NSString *const kFileGetFileSize = @"SFileGetFileSize";
NSString *const kFileReadFile = @"SFileReadFile";


// Own additions
NSString *const kFileFindCreateDataPointer = @"SFileFindCreateDataPointer";
NSString *const kFileFindGetDataForDataPointer = @"SFileFindGetDataForDataPointer";
}

typedef  NS_ENUM(NSInteger, ReferenceType) {
    ReferenceTypeHandle,
    ReferenceTypeFindData
};

#define METHOD(name) if ([call.method isEqualToString:name])

// Custom errors
#define ERROR_FAILED_TO_OPEN_MPQ 0x20

@interface FLEStormPlugin ()
@end

@implementation FLEStormPlugin {
  // The channel used to communicate with Flutter.
  FlutterMethodChannel *_channel;

  // A reference to the registrar holding the NSView used by the plugin. Holding a reference
  // since the view might be nil at the time the plugin is created.
  id<FlutterPluginRegistrar> _registrar;

  // A dictionary to hold all HANDLE
  std::unordered_map<std::string, HANDLE> handles;

  // A dictionary to hold all SFILE_FOIND_DATA
  std::unordered_map<std::string, SFILE_FIND_DATA> findDataPointers;
}

+ (void)registerWithRegistrar:(id<FlutterPluginRegistrar>)registrar {
  FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:kChannelName
                                                              binaryMessenger:registrar.messenger];
    FLEStormPlugin *instance = [[FLEStormPlugin alloc] initWithChannel:channel
                                                                     registrar:registrar];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (instancetype)initWithChannel:(FlutterMethodChannel *)channel
                      registrar:(id<FlutterPluginRegistrar>)registrar {
  self = [super init];
  if (self) {
    _channel = channel;
    _registrar = registrar;
  }
  return self;
}

/**
 * Handles platform messages generated by the Flutter framework on the platform channel.
 */
- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    METHOD(kFileOpenArchive) {
        NSDictionary *args = call.arguments;

        NSString *mpqName = args[@"mpqName"];
        NSNumber *mpqFlags = args[@"mpqFlags"];

        HANDLE mpqHandle;
        bool success = SFileOpenArchive([mpqName UTF8String], [mpqFlags unsignedIntValue], 0, &mpqHandle);
        if (success) {
            NSString *uuid = [self generateUUIDForType:ReferenceTypeHandle];
            handles[uuid.UTF8String] = mpqHandle;
            result(uuid);
            return;
        } else {
            result([self flutterErrorFromError:GetLastError()]);
            return;
        }
    }

    METHOD(kFileCreateArchive) {
        NSDictionary *args = call.arguments;

        NSString *mpqName = args[@"mpqName"];
        NSNumber *mpqFlags = args[@"mpqFlags"];
        NSNumber *maxFileCount = args[@"maxFileCount"];

        HANDLE mpqHandle;
        bool success = SFileCreateArchive([mpqName UTF8String], [mpqFlags unsignedIntValue], [maxFileCount unsignedIntValue], &mpqHandle);
        if (success) {
            NSString *uuid = [self generateUUIDForType:ReferenceTypeHandle];
            handles[uuid.UTF8String] = mpqHandle;
            result(uuid);
            return;
        } else {
            result([self flutterErrorFromError:GetLastError()]);
            return;
        }
    }

    METHOD(kFileCloseArchive) {
        NSDictionary *args = call.arguments;
        NSString *mpqHandle = args[@"hMpq"];
        HANDLE handle = [self getHandleOrError:mpqHandle result:result];

        bool success = SFileCloseArchive(handle);
        if (success) {
            handles.erase([mpqHandle UTF8String]);
            result(nil);
            return;
        } else {
            result([self flutterErrorFromError:GetLastError()]);
            return;
        }
    }

    METHOD(kFileHasFile) {
        NSDictionary *args = call.arguments;
        NSString *mpqHandle = args[@"hMpq"];
        HANDLE handle = [self getHandleOrError:mpqHandle result:result];
        NSString *fileName = args[@"fileName"];

        bool success = SFileHasFile(handle, [fileName UTF8String]);
        result([NSNumber numberWithBool:success]);
        return;
    }

    METHOD(kFileCreateFile) {
        NSDictionary *args = call.arguments;
        NSString *mpqHandle = args[@"hMpq"];
        HANDLE handle = [self getHandleOrError:mpqHandle result:result];
        NSString *fileName = args[@"fileName"];
        NSNumber *fileSize = args[@"fileSize"];
        NSNumber *dwFlags = args[@"dwFlags"];

        HANDLE fileHandle;
        time_t theTime;
        time(&theTime);
        bool success = SFileCreateFile(handle, [fileName UTF8String], theTime, [fileSize unsignedIntValue], 0, [dwFlags unsignedIntValue], &fileHandle);
        if (success) {
            NSString *uuid = [self generateUUIDForType:ReferenceTypeHandle];
            handles[uuid.UTF8String] = fileHandle;
            result(uuid);
            return;
        } else {
            result([self flutterErrorFromError:GetLastError()]);
            return;
        }
    }

    METHOD(kFileWriteFile) {
        NSDictionary *args = call.arguments;
        NSString *fileHandle = args[@"hFile"];
        HANDLE handle = [self getHandleOrError:fileHandle result:result];
        FlutterStandardTypedData *data = args[@"pvData"];
        NSNumber *dwSize = args[@"dwSize"];
        NSNumber *dwCompression = args[@"dwCompression"];

        bool success = SFileWriteFile(handle, [[data data] bytes], [dwSize unsignedIntValue], [dwCompression unsignedIntValue]);
        result(success ? nil : [self flutterErrorFromError:GetLastError()]);
        return;
    }

    METHOD(kFileCloseFile) {
        NSDictionary *args = call.arguments;
        NSString *fileHandle = args[@"hFile"];
        HANDLE handle = [self getHandleOrError:fileHandle result:result];

        bool success = SFileCloseFile(handle);
        if (success) {
            handles.erase([fileHandle UTF8String]);
            result(nil);
            return;
        } else {
            result([self flutterErrorFromError:GetLastError()]);
            return;
        }
    }

    METHOD(kFileRemoveFile) {
        NSDictionary *args = call.arguments;
        NSString *mpqHandle = args[@"hMpq"];
        HANDLE handle = [self getHandleOrError:mpqHandle result:result];
        NSString *fileName = args[@"fileName"];

        bool success = SFileRemoveFile(handle, [fileName UTF8String], 0);
        result(success ? nil : [self flutterErrorFromError:GetLastError()]);
        return;
    }

    METHOD(kFileRenameFile) {
        NSDictionary *args = call.arguments;
        NSString *mpqHandle = args[@"hMpq"];
        HANDLE handle = [self getHandleOrError:mpqHandle result:result];
        NSString *oldFileName = args[@"oldFileName"];
        NSString *newFileName = args[@"newFileName"];

        bool success = SFileRenameFile(handle, [oldFileName UTF8String], [newFileName UTF8String]);
        result(success ? nil : [self flutterErrorFromError:GetLastError()]);
        return;
    }

    METHOD(kFileFinishFile) {
        NSDictionary *args = call.arguments;
        NSString *fileHandle = args[@"hFile"];
        HANDLE handle = [self getHandleOrError:fileHandle result:result];

        bool success = SFileFinishFile(handle);
        result(success ? nil : [self flutterErrorFromError:GetLastError()]);
        return;
    }

    METHOD(kFileFindFirstFile) {
        NSDictionary *args = call.arguments;
        NSString *mpqHandle = args[@"hMpq"];
        HANDLE handle = [self getHandleOrError:mpqHandle result:result];
        NSString *searchMask = args[@"szMask"];
        NSString *findFileData = args[@"lpFindFileData"];
        SFILE_FIND_DATA *findData = [self getFindDataOrError:findFileData result:result];

        HANDLE findHandle = SFileFindFirstFile(handle, [searchMask UTF8String], findData, NULL);
        if (findHandle != NULL) {
            NSString *uuid = [self generateUUIDForType:ReferenceTypeHandle];
            handles[uuid.UTF8String] = findHandle;

            result(uuid);
            return;
        } else {
            result([self flutterErrorFromError:GetLastError()]);
            return;
        }
    }

    METHOD(kFileFindNextFile) {
        NSDictionary *args = call.arguments;
        NSString *findHandle = args[@"hFind"];
        HANDLE handle = [self getHandleOrError:findHandle result:result];
        NSString *findFileData = args[@"lpFindFileData"];
        SFILE_FIND_DATA *findData = [self getFindDataOrError:findFileData result:result];

        bool success = SFileFindNextFile(handle, findData);
        result(success ? nil : [self flutterErrorFromError:GetLastError()]);
        return;
    }

    METHOD(kFileFindClose) {
        NSDictionary *args = call.arguments;
        NSString *findHandle = args[@"hFind"];
        HANDLE handle = [self getHandleOrError:findHandle result:result];

        bool success = SFileFindClose(handle);
        if (success) {
            handles.erase([findHandle UTF8String]);

            result(nil);
            return;
        } else {
            result([self flutterErrorFromError:GetLastError()]);
            return;
        }
    }

    METHOD(kFileOpenFileEx) {
        NSDictionary *args = call.arguments;
        NSString *mpqHandle = args[@"hMpq"];
        HANDLE handle = [self getHandleOrError:mpqHandle result:result];
        NSString *fileName = args[@"szFileName"];
        NSNumber *dwSearchScope = args[@"dwSearchScope"];
        HANDLE fileHandle = NULL;

        SFileOpenFileEx(handle, [fileName UTF8String], [dwSearchScope unsignedIntValue], &fileHandle);
        if (fileHandle != NULL) {
            NSString *uuid = [self generateUUIDForType:ReferenceTypeHandle];
            handles[uuid.UTF8String] = fileHandle;

            result(uuid);
            return;
        } else {
            result([self flutterErrorFromError:GetLastError()]);
            return;
        }
    }

    METHOD(kFileGetFileSize) {
        NSDictionary *args = call.arguments;
        NSString *fileHandle = args[@"hFile"];
        HANDLE handle = [self getHandleOrError:fileHandle result:result];

        DWORD fileSize = SFileGetFileSize(handle, 0);
        if (fileSize != SFILE_INVALID_SIZE) {
            result([NSNumber numberWithUnsignedInt:fileSize]);
            return;
        } else {
            result([self flutterErrorFromError:GetLastError()]);
            return;
        }
    }

    METHOD(kFileReadFile) {
        NSDictionary *args = call.arguments;
        NSString *fileHandle = args[@"hFile"];
        HANDLE handle = [self getHandleOrError:fileHandle result:result];
        NSNumber *dwToRead = args[@"dwToRead"];
        DWORD countBytes;
        char* lpBuffer = new char[[dwToRead unsignedIntValue]];

        bool success = SFileReadFile(handle, lpBuffer, [dwToRead unsignedIntValue], &countBytes, NULL);
        if (success) {
            NSData *data = [NSData dataWithBytes:lpBuffer length:countBytes];
            result([FlutterStandardTypedData typedDataWithBytes:data]);
            return;
        } else {
            result([self flutterErrorFromError:GetLastError()]);
            return;
        }
        return;
    }

    // Custom additions
    METHOD(kFileFindCreateDataPointer) {
        SFILE_FIND_DATA findData = {};
        NSString *uuid = [self generateUUIDForType:ReferenceTypeFindData];
        findDataPointers[uuid.UTF8String] = findData;

        result(uuid);
        return;
    }

    METHOD(kFileFindGetDataForDataPointer) {
        NSDictionary *args = call.arguments;
        NSString *findFileData = args[@"lpFindFileData"];
        SFILE_FIND_DATA *findData = [self getFindDataOrError:findFileData result:result];

        result([NSString stringWithUTF8String:findData->cFileName]);
        return;
    }

    result(FlutterMethodNotImplemented);
}

// MARK: - Helpers

/// Generates a unique UUID that is not already present in the relevant lookup table
- (NSString *)generateUUIDForType:(ReferenceType)generationType {
    NSString *uuid = [[NSUUID UUID] UUIDString];

    if (generationType == ReferenceTypeHandle) {
        while (handles.find([uuid UTF8String]) != handles.end()) {
            uuid = [[NSUUID UUID] UUIDString];
        }
    } else if (generationType == ReferenceTypeFindData) {
        while (findDataPointers.find([uuid UTF8String]) != findDataPointers.end()) {
            uuid = [[NSUUID UUID] UUIDString];
        }
    }

    return uuid;
}

- (NSString *)mpqErrorString:(DWORD)error {
    switch (error) {
        case ERROR_SUCCESS:
            return @"The operation completed successfully.";
        case ERROR_FILE_NOT_FOUND:
            return @"The system cannot find the file specified.";
        case ERROR_ACCESS_DENIED:
            return @"Access is denied.";
        case ERROR_INVALID_HANDLE:
            return @"The handle is invalid.";
        case ERROR_NOT_ENOUGH_MEMORY:
            return @"Not enough storage is available to process this command.";
        case ERROR_NOT_SUPPORTED:
            return @"The request is not supported.";
        case ERROR_INVALID_PARAMETER:
            return @"One of the parameters is incorrect.";
        case ERROR_NEGATIVE_SEEK:
            return @"An attempt was made to move the file pointer before the beginning of the file.";
        case ERROR_DISK_FULL:
            return @"There is not enough space on the disk.";
        case ERROR_ALREADY_EXISTS:
            return @"Cannot create a file when that file already exists.";
        case ERROR_INSUFFICIENT_BUFFER:
            return @"The data area passed to a system call is too small.";
        case  ERROR_BAD_FORMAT:
            return @"The .mpq archive is corrupt.";
        case ERROR_NO_MORE_FILES:
            return @"No more files were found.";
        case ERROR_HANDLE_EOF:
            return @"Reached the end of the file.";
        case ERROR_CAN_NOT_COMPLETE:
            return @"Cannot complete this function.";
        case ERROR_FILE_CORRUPT:
            return @"The file or directory is corrupted and unreadable.";
        case ERROR_AVI_FILE:
            return @"The file is an MPQ but an AVI file.";
        case ERROR_UNKNOWN_FILE_KEY:
            return @"The system cannot find the key file.";
        case ERROR_CHECKSUM_ERROR:
            return @"The crc sector doesn't match.";
        case ERROR_INTERNAL_FILE:
            return @"The given operation is not allowed on internal file.";
        case ERROR_BASE_FILE_MISSING:
            return @"The file is present as incremental patch file, but base file is missing.";
        case ERROR_MARKED_FOR_DELETE:
            return @"The file was marked as \"deleted\" in the MPQ.";
        case ERROR_FILE_INCOMPLETE:
            return @"The required file part is missing.";
        case ERROR_UNKNOWN_FILE_NAMES:
            return @"A name of at least one file is unknown.";
        case ERROR_CANT_FIND_PATCH_PREFIX:
            return @"StormLib was unable to find patch prefix for the patches.";
        case ERROR_FAKE_MPQ_HEADER:
            return @"The header at this position is fake header.";
        case ERROR_FAILED_TO_OPEN_MPQ: // TODO: Find a better way to handle this
            return @"Failed to open mpq archive it could be corrupted or busy.";
    }

    return [NSString stringWithFormat:@"Unknown error: (%u)", error];;
}

- (FlutterError *)flutterErrorFromError:(DWORD)error {
    return [FlutterError errorWithCode:[NSString stringWithFormat:@"%d", error]
                               message:[self mpqErrorString:error]
                               details:nil];
}

- (HANDLE)getHandleOrError:(NSString *)handle result:(FlutterResult)result {
    if (handles.find([handle UTF8String]) == handles.end()) {
        result([self flutterErrorFromError:ERROR_INVALID_HANDLE]);
        return nil;
    }

    return handles[[handle UTF8String]];
}

- (SFILE_FIND_DATA *)getFindDataOrError:(NSString *)ref result:(FlutterResult)result {
    if (findDataPointers.find([ref UTF8String]) == findDataPointers.end()) {
        result([self flutterErrorFromError:ERROR_INVALID_HANDLE]);
        return nil;
    }

    return &findDataPointers[[ref UTF8String]];
}

@end
