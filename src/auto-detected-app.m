#import <Cocoa/Cocoa.h>

int startApplicationActivityAgent() {
    @autoreleasepool {
        NSApplication *app = [NSApplication sharedApplication];

        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserverForName:NSWorkspaceDidActivateApplicationNotification
                                                                         object:nil
                                                                          queue:[NSOperationQueue mainQueue]
                                                                     usingBlock:^(NSNotification *note) {
            NSRunningApplication *activeApp = note.userInfo[NSWorkspaceApplicationKey];
            NSLog(@"Active application: %@", activeApp.localizedName);
        }];

        NSLog(@"Agent started. Watching active applications...");
        [app run]; 
    }
    return 0;
}
