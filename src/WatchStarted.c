#include "WatchStarted.h"
#include "WatchStopped.h"

static void stopWatch(DigitalWatch self)
{
    WatchStopped_TransitionToStopped(self);
}

void WatchStarted_TransitionToStarted(DigitalWatch self)
{
    setWatchToDefaultState(self);
    self->state.name = "Started";
    self->state.stopWatch = stopWatch;
}
