void hello_world();

typedef int (*OnSensorUpdate)(const unsigned char* const values);

int registerCallback(OnSensorUpdate onSensorUpdate);

static OnSensorUpdate onSensorUpdate = NULL;