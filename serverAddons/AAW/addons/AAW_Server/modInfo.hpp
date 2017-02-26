#define PREFIX AAW
#define PATH tc
#define MOD AAW_Server

// define Version Information
#define MAJOR 0
#define MINOR 17
#define PATCHLVL 0
#define BUILD 1983

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
#define ISDEV // enable better logging
// #define ENABLEPERFORMANCECOUNTER // enable Performance counter for Function calls
// #define ENABLEFUNCTIONTRACE // enable SQF based Function Tracer (Later Maybe Replace with ChromeTrace Repalced)
// #define DISABLECOMPRESSION
