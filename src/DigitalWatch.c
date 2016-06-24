#include "DigitalWatch.h"
#include "WatchStopped.h"

// This is currently implemented as a single-instance module.
static DigitalWatchStruct watchStruct;
static DigitalWatch watch;

static void defaultStop(DigitalWatch self)
{
}

static void defaultStart(DigitalWatch self)
{
}

void setWatchToDefaultState(DigitalWatch self)
{
    DigitalWatchState state = &self->state;
    state->stopWatch = defaultStop;
    state->startWatch = defaultStart;
}

DigitalWatch DigitalWatch_Create(void)
{
    watch = &watchStruct;
    setWatchToDefaultState(watch);
    WatchStopped_TransitionToStopped(watch);
    return watch;
}

void DigitalWatch_Destroy(DigitalWatch self)
{
}

char * DigitalWatch_GetStateName(DigitalWatch self)
{
    if (self == 0)
    {
        return "Null digital watch";
    }
    return self->state.name;
}

void DigitalWatch_StopWatch(DigitalWatch self)
{
    if (self == 0)
    {
        return;
    }
    self->state.stopWatch(self);
}

void DigitalWatch_StartWatch(DigitalWatch self)
{
    if (self == 0)
    {
        return;
    }
    self->state.startWatch(self);
}
