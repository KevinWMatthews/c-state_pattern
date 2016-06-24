#ifndef DIGITAL_WATCH_PRIVATE_INCLUDED
#define DIGITAL_WATCH_PRIVATE_INCLUDED

#include "DigitalWatch.h"

typedef struct DigitalWatchStateStruct * DigitalWatchState;

typedef void (*StopWatch)(DigitalWatch);
typedef void (*StartWatch)(DigitalWatch);

typedef struct DigitalWatchStateStruct
{
    char * name;
    StopWatch stopWatch;
    StartWatch startWatch;
} DigitalWatchStateStruct;

typedef struct DigitalWatchStruct
{
    DigitalWatchStateStruct state;
} DigitalWatchStruct;

void setWatchToDefaultState(DigitalWatch);

#endif
