#ifndef TEST_DIGITAL_WATCH_INCLUDED
#define TEST_DIGITAL_WATCH_INCLUDED

class Test_DigitalWatch
{
  public:
    explicit Test_DigitalWatch();
    virtual ~Test_DigitalWatch();

  private:
    Test_DigitalWatch(const Test_DigitalWatch&);
    Test_DigitalWatch& operator=(const Test_DigitalWatch&);
};

#endif
