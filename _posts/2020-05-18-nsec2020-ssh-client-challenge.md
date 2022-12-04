---
title: 'Nsec2020: SSH Client challenge'
layout: post
---

Another challenge I picked up was the SSH-Client challenge. It started with a linux ssh binary. The premise was that this was an ssh client with a secret in it. At first I didn't know what to do with it, as I didn't have a version of this that I could compare it to. My teammate had already uncovered that it was OpenSSH_8.2p1 with OpenSSL 1.0.2. I then set up a docker container running *Ubuntu 18.04* with *libssl1.0* and *gcc5*. I then downloaded [the source for OpenSSH](https://www.openssh.com/portable.html) and compiled it.

The first thing I tried was to diff the binaries, but everything was shifted and moved around, so obviously that didn't work. I then loaded the challenge binary into ghidra to look for obvious things. I searched the function list and the strings to no avail. I then took a break as I was not getting anywhere. 

After helping my teammates with the android part of the *Hey Kids* challenge, I got an idea. I loaded both the challenge binary and the binary I built into ghidra, and after going to the main function of both binaries, I opened the function graphs. This was the result:

![Both Function graphs](/assets/nsec/ssh_tree_comparison.png)

I began to compare the two  graphs side by side, and after a while I noticed that in the first quarter there was a difference in the peak. The binary I built looked like a pretty even triangle, while the challenge one was not a good-looking triangle, so I zoomed in and got this:

![Zoomed function graphs](/assets/nsec/ssh_tree_zoom.png)

Confirmed! Definitely a difference. After zooming a bit more, I found this:

![Ooooh A Secret!](/assets/nsec/ssh_tree_secret.PNG)

After going to that part of the code, I saw this:

![Secret Code](/assets/nsec/ssh_secret_code.PNG)

Comparing it with the [Source](https://cvsweb.openbsd.org/cgi-bin/cvsweb/src/usr.bin/ssh/ssh.c?annotate=1.527) (line 738) revealed that this was in the argument passing, and that this was the parsing for the -Q argument. Finally the solutin was to run *./ssh -Q secret*.

![SSH Flag](/assets/nsec/ssh_flag.PNG)

This was an interesting challenge that I solved in a weird way, but hey, as long as it works! 

Thank you to @pmb for the challenge :D
