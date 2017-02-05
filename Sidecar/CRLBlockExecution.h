// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <dispatch/dispatch.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Creates a dispatch_time_t representing the given time interval from the present.
 */
NS_INLINE dispatch_time_t CRLDispatchTimeForTimeIntervalFromNow(NSTimeInterval time) NS_SWIFT_UNAVAILABLE("Use the Swift-native GCD interface")
{
    return dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC));
}

/**
 Schedules the given block to be executed on the given queue after a number of seconds.
 */
NS_INLINE void CRLPerformBlockOnQueueAfterDelay(dispatch_block_t block, dispatch_queue_t queue, NSTimeInterval delay) NS_SWIFT_UNAVAILABLE("Use the Swift-native GCD interface")
{
    dispatch_after(CRLDispatchTimeForTimeIntervalFromNow(delay), queue, block);
}

/**
 Executes the given block synchronously on the given queue.
 
 Note: Passing the current dispatch queue to this function will result in deadlock!
 */
NS_INLINE void CRLPerformBlockOnQueueAndWait(__attribute__((noescape)) dispatch_block_t block, dispatch_queue_t queue) NS_SWIFT_UNAVAILABLE("Use the Swift-native GCD interface")
{
    dispatch_sync(queue, block);
}

/**
 Schedules the given block to be executed on the main thread after a number of seconds.
 */
NS_INLINE void CRLPerformBlockOnMainThreadAfterDelay(dispatch_block_t block, NSTimeInterval delay) NS_SWIFT_UNAVAILABLE("Use the Swift-native GCD interface")
{
    dispatch_after(CRLDispatchTimeForTimeIntervalFromNow(delay), dispatch_get_main_queue(), block);
}

/**
 Executes the given block synchronously on the main thread.

 Note that this function, unlike CRLPerformBlockOnQueueAndWait, is safe to call from any thread.
 */
NS_INLINE void CRLPerformBlockOnMainThreadAndWait(__attribute__((noescape)) dispatch_block_t block) NS_SWIFT_UNAVAILABLE("Use the Swift-native GCD interface")
{
    if([NSThread isMainThread])
        block();
    else
        dispatch_sync(dispatch_get_main_queue(), block);
}

/**
 Schedules the given block to be executed asynchronously on the main thread.
 */
NS_INLINE void CRLPerformBlockOnMainThread(dispatch_block_t block) NS_SWIFT_UNAVAILABLE("Use the Swift-native GCD interface")
{
    dispatch_async(dispatch_get_main_queue(), block);
}

/**
 Schedules the given block to be executed in the background (on the default priority queue)
 after the given number of seconds.
 */
NS_INLINE void CRLPerformBlockInBackgroundAfterDelay(dispatch_block_t block, NSTimeInterval delay) NS_SWIFT_UNAVAILABLE("Use the Swift-native GCD interface")
{
    dispatch_after(CRLDispatchTimeForTimeIntervalFromNow(delay), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

/**
 Executes the given block in the background (on the default priority queue), and waits for its return.

 Note: Calling this function from the default priority queue will result in deadlock!
 */
NS_INLINE void CRLPerformBlockInBackgroundAndWait(__attribute__((noescape)) dispatch_block_t block) NS_SWIFT_UNAVAILABLE("Use the Swift-native GCD interface")
{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

/**
 Schedules the given block to be executed asynchronously in the background (on the default
 priority queue).
 */
NS_INLINE void CRLPerformBlockInBackground(dispatch_block_t block) NS_SWIFT_UNAVAILABLE("Use the Swift-native GCD interface")
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

NS_ASSUME_NONNULL_END
