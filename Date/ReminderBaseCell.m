//
//  ReminderBaseCell.m
//  date
//
//  Created by lixiaoyu on 12-12-1.
//  Copyright (c) 2012年 Liu&Mao. All rights reserved.
//

#import "ReminderBaseCell.h"
#import "SoundManager.h"
#import "UserManager.h"

@implementation ReminderBaseCell

@synthesize btnAudio = _btnAudio;
@synthesize btnMap = _btnMap;
@synthesize image = _image;
@synthesize labelTriggerDate = _labelTriggerDate;
@synthesize audioState = _audioState;
@synthesize reminder = _reminder;
@synthesize bilateralFriend = _bilateralFriend;
@synthesize indexPath = _indexPath;
@synthesize labelAddress = _labelAddress;
@synthesize indicatorView = _indicatorView;

- (void)setReminder:(Reminder *)reminer {
    if (nil != reminer) {
        _reminder = reminer;
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        _labelTriggerDate.text = [formatter stringFromDate:reminer.triggerTime];
        
        if (nil == _reminder.longitude || [_reminder.longitude isEqualToString:@"0"]) {
            [_btnMap setHidden:YES];
            [_labelAddress setHidden:YES];
        }else {
            [_btnMap setHidden:NO];
            if (nil != _reminder.adress) {
                [_labelAddress setHidden:NO];
                _labelAddress.text = _reminder.adress;
            }else {
                [_labelAddress setHidden:YES];
            }
        }
    }
}

- (void)setBilateralFriend:(BilateralFriend *)bilateralFriend {
    if (nil != bilateralFriend) {
        _bilateralFriend = bilateralFriend;
        if (nil != bilateralFriend.imageUrl) {
            [_image setImageURL:[NSURL URLWithString:bilateralFriend.imageUrl]];
        }
    }else {
        
        [_image setImageURL:[NSURL URLWithString:[UserManager defaultManager].imageUrl]];
    }
}

- (void)setAudioState:(AudioState)audioState {
    _audioState = audioState;
    if (_audioState == AudioStateNormal) {
        [_btnAudio setTitle:@"播放" forState:UIControlStateNormal];
        [_indicatorView stopAnimating];
        [_indicatorView setHidden:YES];
    }else if (_audioState == AudioStateDownload){
        [_indicatorView setHidden:NO];
        [_indicatorView startAnimating];
        [_btnAudio setHidden:YES];
    }else if (_audioState == AudioStatePlaying) {
        [_btnAudio setHidden:NO];
        [_btnAudio setTitle:@"暂停" forState:UIControlStateNormal];
        [_indicatorView stopAnimating];
        [_indicatorView setHidden:YES];
    }
}

- (void)modifyReminderReadState {
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)palyAudio:(UIButton *)sender {
    if (NO == [_reminder.isRead integerValue]) {
        [[ReminderManager defaultManager] updateReminderReadStateRequest:_reminder withReadState:YES];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:_reminder.audioUrl]) {
        [self setAudioState:AudioStatePlaying];
        
    }else {
        [self setAudioState:AudioStateDownload];
    }
    
    if (self.delegate != nil && nil != sender) {
        if ([self.delegate respondsToSelector:@selector(clickAudioButton: WithState:)]) {
            [self.delegate performSelector:@selector(clickAudioButton: WithState:) withObject:_indexPath withObject:[NSNumber numberWithInteger:_audioState]];
        }
    }
    
    if (_audioState == AudioStatePlaying) {
        [[SoundManager defaultSoundManager] playAudio:_reminder.audioUrl];
    }else {
        [[ReminderManager defaultManager] downloadAudioFileWithReminder:_reminder];
    }
}

- (IBAction)showMap:(UIButton *)sender {
    if (self.delegate != nil) {
        if ([self.delegate respondsToSelector:@selector(clickMapButton:)]) {
            [self.delegate performSelector:@selector(clickMapButton:) withObject:_indexPath];
        }
    }
}

@end