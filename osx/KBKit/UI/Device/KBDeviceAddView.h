//
//  KBSecretWordsInputView.h
//  Keybase
//
//  Created by Gabriel on 3/19/15.
//  Copyright (c) 2015 Gabriel Handford. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KBContentView.h"

typedef void (^KBDeviceAddCompletion)(id sender, BOOL ok);

@interface KBDeviceAddView : KBContentView

@property (readonly) KBTextView *inputField;
@property (copy) KBDeviceAddCompletion completion;

- (void)openInWindow:(KBWindow *)window;

@end
