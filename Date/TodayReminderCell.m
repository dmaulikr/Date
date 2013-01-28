//
//  TodayReminderWithTimeCell.m
//  date
//
//  Created by maoyu on 13-1-18.
//  Copyright (c) 2013年 Liu&Mao. All rights reserved.
//

#import "TodayReminderCell.h"

@implementation TodayReminderCell


- (void)setDateTimeView {
    if (nil != self.reminder.triggerTime) {
        NSString * day = @"";
        if (DataTypeRecent == self.dateType) {
            [self.labelDay setHidden:YES];
        }else {
            [self.labelDay setHidden:NO];
            day = [self custumDayString:self.reminder.triggerTime];
        }
        
        if (ReminderTypeReceiveAndNoAlarm == [self.reminder.type integerValue]) {
            [self.labelTriggerDate setHidden:YES];
            [self.labelNickname setHidden:YES];
            self.labelDay.frame = CGRectMake(self.labelDay.frame.origin.x,kLabelDescChangedY, self.labelDay.frame.size.width, self.labelDay.frame.size.height);
            if ([@"" isEqualToString:day]) {
                self.labelDescription.frame = CGRectMake(kLabelDescChangedX, kLabelDescChangedY, self.labelDescription.frame.size.width + kDayLabelWidth, self.labelDescription.frame.size.height);
            }else {
                self.labelDescription.frame = CGRectMake(kLabelDescOriX, kLabelDescChangedY, self.labelDescription.frame.size.width, self.labelDescription.frame.size.height);
            }
            
        }else {
            [self.labelTriggerDate setHidden:NO];
            self.labelDay.frame = CGRectMake(kLabelDescChangedX,kLabelDescOriY, kDayLabelWidth, self.labelDay.frame.size.height);
            if ([@"" isEqualToString:day]) {
                self.labelDescription.frame = CGRectMake(kLabelDescChangedX, kLabelDescOriY, self.labelDescription.frame.size.width + kDayLabelWidth, self.labelDescription.frame.size.height);
            }else {
                self.labelDescription.frame = CGRectMake(kLabelDescOriX, kLabelDescOriY, kLabelDescOriWidth, self.labelDescription.frame.size.height);
            }
            if (YES == [self showFrom]) {
//                if ([@"" isEqualToString:day]) {
//                    self.labelNickname.frame = CGRectMake(self.labelDay.frame.origin.x, self.labelNickname.frame.origin.y, self.labelDescription.frame.size.width, self.labelDescription.frame.size.height);
//                }else {
//                    self.labelNickname.frame = CGRectMake(145, self.labelNickname.frame.origin.y, self.labelDescription.frame.size.width, self.labelDescription.frame.size.height);
//                }
            }
        }

        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        self.labelTriggerDate.text =[formatter stringFromDate:self.reminder.triggerTime];
        self.labelDay.text = day;
    }
}

#pragma 事件函数
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"TodayReminderCell" owner:self options:nil] ;
        self = [nib objectAtIndex:0];
    }
    return self;
}

- (void)setReminder:(Reminder *)reminder {
    self.labelDescOriwidth = 180;
     [super setReminder:reminder];
     [self setDateTimeView];
    
}

@end
