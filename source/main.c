/*
 * PS3drome - Subsonic/Navidrome client for PS3
 *
 * Entry point. For now just proves the app boots and can reach the network.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ppu-lv2.h>
#include <net/net.h>
#include <net/netctl.h>
#include <sysutil/sysutil.h>

/* Placeholder - will become the real app */

static void sys_callback(u64 status, u64 param, void *userdata)
{
    (void)param;
    (void)userdata;

    switch (status) {
    case SYSUTIL_EXIT_GAME:
        /* User pressed PS button -> Quit Game */
        exit(0);
        break;
    default:
        break;
    }
}

int main(void)
{
    /* Init networking */
    netInitialize();
    netCtlInit();

    /* Register system callback so the XMB overlay works */
    sysUtilRegisterCallback(SYSUTIL_EVENT_SLOT0, sys_callback, NULL);

    /* Check network state */
    s32 state;
    netCtlGetState(&state);

    if (state != NET_CTL_STATE_IPObtained) {
        /* No network - can't do much */
        printf("PS3drome: no network connection\n");
    } else {
        printf("PS3drome: network OK, ready to connect\n");
    }

    /* Main loop - just processes system events for now */
    while (1) {
        sysUtilCheckCallback();
        /* TODO: UI + subsonic client goes here */
    }

    netCtlTerm();
    netDeinitialize();

    return 0;
}
