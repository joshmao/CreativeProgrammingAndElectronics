![](buttonmidterm.gif)

For this assignment, I added a button from the arduino to send serial data to my midterm computer vision program; I made it so that when someone pressed the button, it would cause the video to blur within processing.

One of the biggest problems was actually figuring out where to place the serial code within my processing program; I ended up placing it after the computer vision functions as it would affect the next frame instead of trying to affect the current frame of the video.

Other than that, it was just implementing the serial communication code within both the arduino and processing IDE's; was a bit challenging but I figured it out.

Here are the [schematic](schematic.jpg), [electronics](electronics.jpg), [arduino program](arduinotoprocessing.ino), and [processing file](midtermbutton.pde).
