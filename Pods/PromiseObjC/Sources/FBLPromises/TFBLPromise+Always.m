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

#import "TFBLPromise+Always.h"

#import "TFBLPromisePrivate.h"

@implementation TFBLPromise (AlwaysAdditions)

- (TFBLPromise *)always:(TFBLPromiseAlwaysWorkBlock)work {
  return [self onQueue:TFBLPromise.defaultDispatchQueue always:work];
}

- (TFBLPromise *)onQueue:(dispatch_queue_t)queue always:(TFBLPromiseAlwaysWorkBlock)work {
  NSParameterAssert(queue);
  NSParameterAssert(work);

  return [self chainOnQueue:queue
      chainedFulfill:^id(id value) {
        work();
        return value;
      }
      chainedReject:^id(NSError *error) {
        work();
        return error;
      }];
}

@end

@implementation TFBLPromise (DotSyntax_AlwaysAdditions)

- (TFBLPromise * (^)(TFBLPromiseAlwaysWorkBlock))always {
  return ^(TFBLPromiseAlwaysWorkBlock work) {
    return [self always:work];
  };
}

- (TFBLPromise * (^)(dispatch_queue_t, TFBLPromiseAlwaysWorkBlock))alwaysOn {
  return ^(dispatch_queue_t queue, TFBLPromiseAlwaysWorkBlock work) {
    return [self onQueue:queue always:work];
  };
}

@end
