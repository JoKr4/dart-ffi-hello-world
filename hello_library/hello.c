#include <stdio.h>
#include "hello.h"

void hello_world()
{
    printf("Hello World in c lib\n");
    int sensors = 6;
    unsigned char sensorValues[] = {0,1,2,3,0,1};
    onSensorUpdate(sensorValues, sensors);
}

int registerCallback(OnSensorUpdate in) {
    onSensorUpdate = in;
}