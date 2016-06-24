extern "C"
{
#include "DigitalWatch.h"
}

#include "Test_DigitalWatch.h"
#include "CppUTest/TestHarness.h"
#include "CppUTestExt/MockSupport.h"

TEST_GROUP(DigitalWatch)
{
    DigitalWatch watch;

    void setup()
    {
        watch = DigitalWatch_Create();
    }

    void teardown()
    {
        DigitalWatch_Destroy(watch);
    }
};

TEST(DigitalWatch, it_can_be_stopped)
{
    DigitalWatch_StopWatch(watch);
    STRCMP_EQUAL( "Stopped", DigitalWatch_GetState(watch) );
}

IGNORE_TEST(DigitalWatch, it_can_be_started)
{
    DigitalWatch_StartWatch(watch);
    STRCMP_EQUAL( "Started", DigitalWatch_GetState(watch) );
}
