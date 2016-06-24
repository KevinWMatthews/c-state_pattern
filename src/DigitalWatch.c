#include "DigitalWatch.h"

typedef struct DigitalWatchStateStruct * DigitalWatchState;
typedef struct DigitalWatchStateStruct
{
    char * name;
} DigitalWatchStateStruct;

typedef struct DigitalWatchStruct
{
    DigitalWatchStateStruct state;
} DigitalWatchStruct;

static DigitalWatchStruct watchStruct;
static DigitalWatch watch;

DigitalWatch DigitalWatch_Create(void)
{
    watch = &watchStruct;
    watch->state.name = "Stopped";
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
    self->state.name = "Stopped";
}

void DigitalWatch_StartWatch(DigitalWatch self)
{
    if (self == 0)
    {
        return;
    }
    self->state.name = "Started";
}
