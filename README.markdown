## Processing Brain Grapher

#### Overview

<img width="500" src="screenshot.jpg" />

This is a simple Processing application for graphing changes in brain waves over time. It's designed to read data from a hacked MindFlex EEG headset connected via USB.

It's mostly a proof of concept, demonstrating how to parse serial packets from the Arduino Brain Library, monitor signal strength, etc.

`BrainGrapher.pde` is the main project file. Open this in the Processing PDE to work with the project.

You may need to modfiy the index value in the line `serial = new Serial(this, Serial.list()[0], 9600);` inside the app's `setup()` function file depending on which serial / USB port your Arduino is connected to. (Try ` Serial.list()[1]`, ` Serial.list()[2]`, ` Serial.list()[3]`, etc.)

#### Repository Rename
This project was formerly “Processing-Brain-Grapher” on GitHub, but was renamed to just “BrainGrapher” in 2014 for simplicity's sake.

#### Dependencies
- The core Processing project. Tested with [Processing 3.0.2](http://processing.org/download/).

- Version 2.2.5 of the [ControlP5 GUI Library](http://www.sojamo.de/libraries/controlP5/) is included with this project in the `/code` folder. No installation is necessary.

- If you're using this with a hacked MindFlex, you'll need the [Arduino Brain Library](https://github.com/kitschpatrol/Brain) installed and running on your Arduino. Additional instructions at [frontiernerds.com/brain-hack]](http://www.frontiernerds.com/brain-hack).


#### Colophon
Created by Eric Mika at NYU ITP in the spring of 2010. Revised in Spring 2012 to keep up with Processing and ControlP5 updates. Updated in early 2014 with bundled dependencies and more fixes for Control P5. Update in Spring 2016 with Processing 3 support.

#### Contact
Eric Mika  
eric@ericmika.com  
[https://github.com/kitschpatrol](https://github.com/kitschpatrol)  
[http://frontiernerds.com](http://frontiernerds.com)  
