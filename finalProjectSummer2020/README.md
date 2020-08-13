![](Enticingphoto)

**Colors of the Piano**

[Video](https://youtu.be/SFE_4Ii6NKU)

What if you could see what the piano sounded like?

Chromesthesia or sound-to-color synesthesia is a type of synesthesia in which sound involuntarily evokes an experience of color, shape, and movement. And while many piano players have hints of this condition, including me, we rarely can fully flesh out the grand multitude of colors that a piano piece creates when we are playing it.

I wanted to undertake this project to create a fully functional, piano visualizer that utilizes LEDs to create an artificial "chromesthesia"; by hooking up microphone input to processing and my arduino to a strip of LEDs, I was able to design and engineer an interactive auditory and visual experience that can be enjoyed by professional piano players to beginners who have never touched an instrument before.

Functionality wise, this visualizer pairs LED brightness with the volume of the piano, LED color with the pitch of the piano, and LED pattern with the complexity of the chords played on the piano.  It utilizes the R2D2 Processing Pitch program for [FFT analysis written by L. Anton-Canalis (info@luisanton.es)](https://github.com/Notnasiul/R2D2-Processing-Pitch/blob/FFT/PitchProject/PitchProject.pde) and builds on top of it to send values over serial to the Arduino which will then control the LED strip. Best results can be seen when played in the evening within a darker setting.

I had a lot of problems with this project as audio detection algorithims and LED strips were completely new topics for me; I started by conducting a lot of research about the different audio parsing methods out there, including FFT, autocorrelation, and others. After I had a basic understanding of the topic, I was able to figure out what the R2D2 program was doing with help from Professor Shiloh and Chris Parcell from the Jacobs Institute. I utilized this basic understanding to begin to build on top of it - I recorded
the frequency values of each key that was outputted from the R2D2 program and then built functions in order to analyze these functions to detect what note(s) were being played. Once this was done, I had to figure out how to send multiple values at the same time over serial to the arduino so that it could use those values to power the LED. Using the FastLED library was tricky at first but not very hard to understand and somehow all of these complex parts came together magically at the end. Even though there was a minor fire and my first adapter fried, I'm really proud of what I accomplished and looking forward to expanding on this project in the future!

[Electronics](electronics.jpg), Arduino Schematic, [Arduino Code](final_arduino.ino), [Processing Code](PitchProject.pde).
