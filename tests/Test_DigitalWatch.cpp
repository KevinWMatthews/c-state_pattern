extern "C"
{
#include "DigitalWatch.h"
}

#include "Test_DigitalWatch.h"
#include "CppUTest/TestHarness.h"
#include "CppUTestExt/MockSupport.h"

TEST_GROUP(DigitalWatch)
{
    void setup()
    {
    }

    void teardown()
    {
    }
};


TEST(DigitalWatch, it_can_fail)
{
    FAIL("Start here");
}
