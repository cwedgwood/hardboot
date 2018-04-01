DO NOT RUN THIS
---
... IT WILL REBOOT YOUR MACHINE ...
===
AND POTENTIALLY CAUSE CORRUPTION
===

This is a nasty hack to get machines unstuck when they can't reboot.
Originally written a long time ago to reboot a remote machine,
slightly updates and available in a container now.

It attempts to cold boot (vs warm) where it can (older kernels, BIOS
not UEFI mode).

If you are curious you can try:

~~~
docker run -ti --privileged --rm cwedgwood/hardboot NOW
~~~

and it *might* (should) reboot your machine.
