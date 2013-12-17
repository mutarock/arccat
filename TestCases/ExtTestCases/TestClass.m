//
//  TestClass.m
//  TestApp
//
//  Created by ssukcha on 2013. 12. 17..
//  Copyright (c) 2013년 factorcat. All rights reserved.
//

#import "NSClassExt.h"
#import "UnitTest.h"

@interface TestClass : NSObject @end


@implementation TestClass

-(void) test_properties {
    assert_equal(@[@"-(void) test_properties ;"], [NSClassExt methodsForClass:TestClass.class]);

    NSArray* properties =@[
        @"char         _drawsDebugBaselines",
        @"char         allowsEditingTextAttributes",
        @"id           attributedText",
        @"int          autocapitalizationType",
        @"int          autocorrectionType",
        @"id           beginningOfDocument",
        @"char         clearsOnInsertion",
        @"uint         dataDetectorTypes",
        @"id           delegate",
        @"char         editable",
        @"char         enablesReturnKeyAutomatically",
        @"id           endOfDocument",
        @"id           font",
        @"id           inputAccessoryView",
        @"id           inputDelegate",
        @"id           inputView",
        @"char         interactiveTextSelectionDisabled",
        @"int          keyboardAppearance",
        @"int          keyboardType",
        @"id           layoutManager",
        @"id           linkTextAttributes",
        @"id           markedTextRange",
        @"id           markedTextStyle",
        @"int          returnKeyType",
        @"char         secureTextEntry",
        @"char         selectable",
        @"NSRange      selectedRange",
        @"id           selectedTextRange",
        @"int          selectionAffinity",
        @"int          spellCheckingType",
        @"id           text",
        @"int          textAlignment",
        @"id           textColor",
        @"id           textContainer",
        @"UIEdgeInsets textContainerInset",
        @"id           textInputView",
        @"id           textStorage",
        @"id           tokenizer",
        @"id           typingAttributes"
    ];
    assert_equal(properties, [NSClassExt propertiesForClass:UITextView.class]);
}

@end
