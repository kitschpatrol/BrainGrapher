##Processing Brain Grapher

####Overview
This is a simple Processing application for graphing changes in brain waves over time. It's designed to read data from a hacked MindFlex EEG headset connected via USB.

It's mostly a proof of concept, demonstrating how to parse serial packets from the Arduino Brain Library, monitor signal strength, etc.

`brain_grapher.pde` is the main project file. Open this in the Processing PDE to work with the project.

You may need to modfiy the index value in the line `serial = new Serial(this, Serial.list()[0], 9600);` inside the app's `setup()` function file depending on which serial / USB port your Arduino is connected to. (Try ` Serial.list()[1]`, ` Serial.list()[2]`, ` Serial.list()[3]`, etc.)


####Technical Minutia
**Dependencies:**

- The core Processing project. Tested with [Processing 1.5.1](http://processing.org/download/) and [Processing 2.0a5](http://code.google.com/p/processing/downloads/list).
- [ControlP5 GUI Library](http://www.sojamo.de/libraries/controlP5/). Follow the [library installation instructions](http://wiki.processing.org/w/How_to_Install_a_Contributed_Library). Tested with version 0.7.2.
- If you're using this with a hacked MindFlex, you'll need the [Arduino Brain Library](https://github.com/kitschpatrol/Arduino-Brain-Library) installed and running on your Arduino. Additional instructions at [frontiernerds.com/brain-hack](](http://frontiernerds.com/brain-hack). 

**Known Issues:**

- A [bug in ControlP5](http://code.google.com/p/controlp5/issues/detail?id=41) causes a NoSuchMethodException every time a radio button is pressed. These errors are annoying, but harmless. The issue should be fixed in subsequent releases of ControlP5.

**To Do List:**

- Monitor local vs. global maxima
- More graph, less bar?
- Record / replay / export

####Colophon
Created by Eric Mika at NYU ITP in the spring of 2010. Revised in Spring 2012 to keep up with Processing and ControlP5 updates.

####Contact
Eric Mika  
ermika@gmail.com  
@kitschpatrol