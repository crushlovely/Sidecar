#import <dispatch/dispatch.h>

NS_INLINE dispatch_time_t CRLDispatchTimeForTimeIntervalFromNow(NSTimeInterval time)
{
    return dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC));
}


NS_INLINE void CRLPerformBlockOnQueueAfterDelay(dispatch_block_t block, dispatch_queue_t queue, NSTimeInterval delay)
{
    dispatch_after(CRLDispatchTimeForTimeIntervalFromNow(delay), queue, block);
}

NS_INLINE void CRLPerformBlockOnQueueAndWait(dispatch_block_t block, dispatch_queue_t queue)
{
    dispatch_sync(queue, block);
}

NS_INLINE void CRLPerformBlockOnMainThreadAfterDelay(dispatch_block_t block, NSTimeInterval delay)
{
    dispatch_after(CRLDispatchTimeForTimeIntervalFromNow(delay), dispatch_get_main_queue(), block);
}

NS_INLINE void CRLPerformBlockOnMainThreadAndWait(dispatch_block_t block)
{
    if([NSThread isMainThread])
        block();
    else
        dispatch_sync(dispatch_get_main_queue(), block);
}

NS_INLINE void CRLPerformBlockOnMainThread(dispatch_block_t block)
{
    dispatch_async(dispatch_get_main_queue(), block);
}

NS_INLINE void CRLPerformBlockInBackgroundAfterDelay(dispatch_block_t block, NSTimeInterval delay)
{
    dispatch_after(CRLDispatchTimeForTimeIntervalFromNow(delay), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

NS_INLINE void CRLPerformBlockInBackgroundAndWait(dispatch_block_t block)
{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

NS_INLINE void CRLPerformBlockInBackground(dispatch_block_t block)
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}