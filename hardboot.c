/* hardboot
 *
 * This is a quick (x86 specific) to reboot by yanking the reset line
 * low, written a long time ago in a hurry as I needed to reboot a box
 * remotely.  This version is slightly updated.
 *
 * Chris Wedgwood <cw@f00f.org>
 * License; GPLv3 https://www.gnu.org/licenses/gpl-3.0.en.html
 */

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/io.h>
#include <unistd.h>

/*
#if !defined(i386)
#error This code is x86/ia32 specific
#endif
*/

void errfail(const char *msg)
{
    fprintf(stderr, "%s", msg);
    exit(1);
}

// our best effort of using /dev/mem we can get access to physical
// memory and putting 0x0000 into 0x472 (so BIOS will do a cold boot);
// as of writing this still works on most distro kernels but not on
// mainline
void pokebda()
{
    unsigned short reboot_mode = 0x0;
    int f;

    if ((f = open("/dev/mem", O_RDWR)) == -1)
	return;
    pwrite(f, &reboot_mode, sizeof reboot_mode, 0x472);
}


int main(int argc, char *argv[])
{
    if ((argc != 2) || strcmp(argv[1],"NOW"))
	errfail("hardboot NOW\n" "\tTo cause system to reboot (NOW should be in uppercase)\n");

    pokebda();

    if (iopl(3))
        errfail("hardboot: cannot get access to ioports\n");
    outb(0xfe, 0x64);    /* bang, you're dead */
    sleep(1);

    /* not expected that we would end up here */
    errfail("hardboot: reset failed\n");
}
