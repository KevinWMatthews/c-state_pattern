#ifndef DIGITAL_WATCH_INCLUDED
#define DIGITAL_WATCH_INCLUDED

typedef struct DigitalWatchStruct * DigitalWatch;

DigitalWatch DigitalWatch_Create(void);
void DigitalWatch_Destroy(DigitalWatch);

char * DigitalWatch_GetStateName(DigitalWatch);
void DigitalWatch_StopWatch(DigitalWatch);
void DigitalWatch_StartWatch(DigitalWatch);

#include "DigitalWatchPrivate.h"

#endif
