//
// Copyright 1999-2015 MyApp
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import <Foundation/Foundation.h>

//需要的一些参数
#define CHAT_EMOJ_COL 7     //emoj键盘的列数
#define CHAT_EMOJ_ROW 4
#define CHAT_EMOJ_SIZE 28   //emoj图像的大小
#define CHAT_EMOJ_VECTICAL_PADDING 9  //btn距离上下缘的距离
#define EMOJI_FONT [UIFont fontWithName:@"AppleColorEmoji" size:CHAT_EMOJ_SIZE]




@class EmojInfo;
@interface EmojHelper : NSObject{
}
+ (EmojInfo*) emojAtIndex:(NSUInteger)index;
+ (NSInteger) emojCount;
+ (BOOL)isEmojStr:(NSString *)emojStr;
@end


#pragma mark- Class EMojiInfo
/**EMojiInfo store emoji code and image name codeID or index*/
@interface EmojInfo:NSObject{
}
@property (nonatomic,copy) NSString* emjStr;
@property (nonatomic,copy) NSString* imageName;
@property (nonatomic,copy) NSString* codeID;
@property (nonatomic,assign) NSUInteger index;

@end