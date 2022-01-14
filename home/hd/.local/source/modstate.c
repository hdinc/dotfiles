#include <X11/XKBlib.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char** argv)
{
    if (argc != 2) {
        fprintf(stderr, "wrong number of arguments\n");
        exit(1);
    }

    if (strcmp(argv[1], "Shift") != 0) {
        fprintf(stderr, "Wrong argument\n");
        exit(1);
    }

    Display* dsp = XOpenDisplay(0);

    XkbStateRec kbdstate;
    XkbGetState(dsp, XkbUseCoreKbd, &kbdstate);

    int state = 0x01 & kbdstate.base_mods;

    XCloseDisplay(dsp);
    return !state;
}
