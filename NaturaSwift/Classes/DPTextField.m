//
//  DPTextField.m
//  Naturapass
//
//  Created by Manh on 8/6/15.
//  Copyright (c) 2015 Appsolute. All rights reserved.
//

#import "DPTextField.h"
#import "ASSharedTimeFormatter.h"
@implementation DPTextField
{
    UIToolbar                   *keyboardToolbar;
    UIBarButtonItem             *doneBarItem;
    UIBarButtonItem             *spaceBarItem;

}

- (void)awakeFromNib {
    // Initialization code
    [self InitializeKeyboardToolBar];
}
#pragma mark -date picker
- (void)LabelChange:(id)sender{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy HH:mm"];
    self.text = [NSString stringWithFormat:@"%@",
                         [df stringFromDate:self.datePicker.date]];
    if (self.CallBack) {
        self.CallBack();
    }
}
#pragma Mark - Keyboard

-(void) InitializeKeyboardToolBar{
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [self.datePicker addTarget:self
                   action:@selector(LabelChange:)
         forControlEvents:UIControlEventValueChanged];
    //
    self.inputView = self.datePicker;
    if (keyboardToolbar == nil)
    {
        keyboardToolbar            = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 38.0f)];
        keyboardToolbar.barStyle   = UIBarStyleBlackTranslucent;
        
        spaceBarItem    = [[UIBarButtonItem alloc]  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                         target:self
                                                                         action:nil];

        
        doneBarItem     = [[UIBarButtonItem alloc]  initWithTitle:NSLocalizedString(@"OK", @"")
                                                            style:UIBarButtonItemStyleDone
                                                           target:self
                                                           action:@selector(resignKeyboard:)];
        
        [keyboardToolbar setItems:[NSArray     arrayWithObjects:
                                   spaceBarItem, doneBarItem, nil]];
        
        
    }
    //
    [self setInputAccessoryView:keyboardToolbar];
}

- (void)resignKeyboard:(id)sender{
    
    [self resignFirstResponder];
    
    if([self.text length]==0){
        
        NSDateFormatter *dateFormatter = [[ASSharedTimeFormatter sharedFormatter] dateFormatterTer];
        
        [ASSharedTimeFormatter checkFormatString: @"dd/MM/yyyy HH:mm" forFormatter: dateFormatter];
        
        self.text = [NSString stringWithFormat:@"%@",
                             [dateFormatter stringFromDate:self.datePicker.date]];
    }
    
    if (self.CallBack) {
        self.CallBack();
    }
    
}
@end
