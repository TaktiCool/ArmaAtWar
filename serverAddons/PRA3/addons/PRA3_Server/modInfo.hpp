#define PREFIX PRA3
#define PATH pr
#define MOD PRA3_Server

// define Version Information
#define MAJOR 0
#define MINOR 14
#define PATCHLVL 0
#define BUILD 1800

#ifdef VERSION
    #undef VERSION
#endif
#ifdef VERSION_AR
    #undef VERSION_AR
#endif
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD
#define VERSION MAJOR.MINOR.PATCHLVL.BUILD

// dont release with this setting enabled
// #define DEBUGFULL // enable all Debug Methods
// #define isDev // enable better logging
// #define ENABLEPERFORMANCECOUNTER // enable Performance counter for Function calls
// #define ENABLEFUNCTIONTRACE // enable SQF based Function Tracer (Later Maybe Replace with ChromeTrace Repalced)
#define disableCompression
