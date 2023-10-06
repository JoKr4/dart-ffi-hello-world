#include <stdio.h>
#include "hello.h"

void hello_world()
{
    printf("Hello World in c lib\n");
    onSensorUpdate(NULL);
}

int registerCallback(OnSensorUpdate in) {
    onSensorUpdate = in;
}