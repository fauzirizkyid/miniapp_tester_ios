/**
 Copyright 2018 Google Inc. All rights reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at:

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "TFBLPromise+Async.h"

#import "TFBLPromisePrivate.h"

@implementation TFBLPromise (AsyncAdditions)

+ (instancetype)async:(TFBLPromiseAsyncWorkBlock)work {
  return [self onQueue:self.defaultDispatchQueue async:work];
}

+ (instancetype)onQueue:(dispatch_queue_t)queue async:(TFBLPromiseAsyncWorkBlock)work {
  NSParameterAssert(queue);
  NSParameterAssert(work);

  TFBLPromise *promise = [[TFBLPromise alloc] initPending];
  dispatch_group_async(TFBLPromise.dispatchGroup, queue, ^{
    work(
        ^(id __nullable value) {
          if ([value isKindOfClass:[TFBLPromise class]]) {
            [(TFBLPromise *)value observeOnQueue:queue
                fulfill:^(id __nullable value) {
                  [promise fulfill:value];
                }
                reject:^(NSError *error) {
                  [promise reject:error];
                }];
          } else {
            [promise fulfill:value];
          }
        },
        ^(NSError *error) {
          [promise reject:error];
        });
  });
  return promise;
}

@end

@implementation TFBLPromise (DotSyntax_AsyncAdditions)

+ (TFBLPromise* (^)(TFBLPromiseAsyncWorkBlock))async {
  return ^(TFBLPromiseAsyncWorkBlock work) {
    return [self async:work];
  };
}

+ (TFBLPromise* (^)(dispatch_queue_t, TFBLPromiseAsyncWorkBlock))asyncOn {
  return ^(dispatch_queue_t queue, TFBLPromiseAsyncWorkBlock work) {
    return [self onQueue:queue async:work];
  };
}

@end
