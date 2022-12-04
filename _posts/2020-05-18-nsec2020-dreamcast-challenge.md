---
title: 'Nsec2020: Dreamcast Challenge'
layout: post
---

This year was my third year at northsec and it was also my best year. My team was "skiddies as a service" and we placed 4th this year at 125 points. I personally participated in many challenges and scored 23 points.

## Dreamcast Challenge
The first challenge I picked up was called "Dreamcast Japanese Imports". It started with four files:

* dc_rom_r0.elf
* dc_rom_r0.cdi
* dc_rom_r1.elf
* dc_rom_r1.cdi

The cdi images were roms that could be run on an emulator. Running them led to the following:

![Initial Screen](/assets/nsec/dreamcast_rom_challenge_boot.PNG)

If an invalid code was entered, the following would display:

![Invalid Code](/assets/nsec/dreamcast_rom_challenge_inval.PNG)

The elf files were compiled version of the roms that were not scrambled. I loaded them into ghidra, looked at the functions and searched for "flag". I found a function called "\_draw_flag" that was called by a function called "\_process_code". 

![\_process_code](/assets/nsec/dreamcast_rom_challenge_process_code0.PNG)

At first I thought the goal was to reverse the code from the function and I tried but I couldn't find it so what I did was looked at what bytes would change if I patched the "mov.l  ->\_failure,r1" to "mov.l  ->\_draw_flag,r1". I copied the address of "\_draw_flag" and pasted it into the first mov.l instruction. the bytes at offset 0x01068A changed from "10 D1" to "11 D1". 

![Bytes before](/assets/nsec/dreamcast_rom_challenge_process_bytes_before.PNG)

![Bytes after](/assets/nsec/dreamcast_rom_challenge_process_bytes_after.PNG)

Next came the challenge of applying the patch to the cdi file. I first tried to put the cdi into ghidra but after some research, I found out that dreamcast images are scrambled on the cd images (Probably to help with loading/seeking times). So with that idea out of the window I loaded up my favorite hex editor, [*010editor*](https://www.sweetscape.com/010editor/) (Thanks @Jax), and opened the cdi file. I looked for the pattern "0A 89 10 D1 0B" which are the mov instruction and the bytes around it. I then changed the 10 to 11 and saved the file. I booted up the rom and pressed start to accept the _000000_ code. And I was greeted with this:

![gotta go fast!](/assets/nsec/dreamcast_rom_challenge_flag1.PNG)

I repeated the same process for the second rom. Turns out that in the end, because the code between the two roms is so similar, the patch "0A 89 10 D1 0B" -> "0A 89 11 D1 0B" works for both files. The second flag was found:

![code veronica](/assets/nsec/dreamcast_rom_challenge_flag2.PNG)

That is how I completed the dreamcast challenge. I enjoyed it quite a bit as it was the first time I worked with roms and an emulator. Thank you to @vincelesal for the wonderful challenge.
