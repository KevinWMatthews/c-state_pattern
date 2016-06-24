#include "WatchStopped.h"
#include "WatchStarted.h"

static void startWatch(DigitalWatch self)
{
    WatchStarted_TransitionToStarted(self);
}

void WatchStopped_TransitionToStopped(DigitalWatch self)
{
    setWatchToDefaultState(self);
    self->state.name = "Stopped";
    self->state.startWatch = startWatch;
}
