For my interactive piano project I will be using a microphone connected to my laptop to catch the audio coming from my piano; then, I will use processing (band pass filters)
into it's respective pitch + audio components. These values will then be sent through serial over to my arduino which will be powering a RGB LED 300 Pixels (WS2812B) light strip
which is powered by an ALITOVE 5V 15A AC to DC Power Supply Adapter. The arduino will read these values over serial and control the LED strip accordingly.

As for the actual colors and patterns, I'm planning on having major and minor tones correspond to the warmth/coolness of the color while the volume of the tones correspond to the
saturation of the colors. For now, I will start with programming all of the LEDs the same color and then experiment with more complex patterns after (patterns that individually program
the LEDs).

The riskiest part of this project would probably be programming the LEDs and also creating the band pass filters; for the LED programming, I found someone who made a similar
visualizer using these lights and the libraries that correspond with it so I will look towards there for inspiration. For the band pass filters, I will look through the Sound
documentation page on Processing and hopefully figure that out before the lights come on Friday.
