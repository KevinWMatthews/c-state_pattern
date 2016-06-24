#include "DigitalWatch.h"

typedef struct DigitalWatchStruct
{
    char * state_name;
} DigitalWatchStruct;

static DigitalWatchStruct watchStruct;
static DigitalWatch watch;

DigitalWatch DigitalWatch_Create(void)
{
    watch = &watchStruct;
    watch->state_name = "Stopped";
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
    return self->state_name;
}

void DigitalWatch_StopWatch(DigitalWatch self)
{
    if (self == 0)
    {
        return;
    }
    self->state_name = "Stopped";
}

void DigitalWatch_StartWatch(DigitalWatch self)
{
    if (self == 0)
    {
        return;
    }
    self->state_name = "Started";
}
