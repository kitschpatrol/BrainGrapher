// Main controller / model file for the the Processing Brain Grapher.

// See README.markdown for more info.
// See http://frontiernerds.com/brain-hack for a tutorial on getting started with the Arduino Brain Library and this Processing Brain Grapher.

// Latest source code is on https://github.com/kitschpatrol/Processing-Brain-Grapher
// Created by Eric Mika in Fall 2010, updates Spring 2012, early 2014, and Spring 2016.

import processing.serial.*;
import controlP5.*;

ControlP5 controlP5;

Serial serial;

Channel[] channels = new Channel[11];
Monitor[] monitors = new Monitor[10];
Graph graph;
ConnectionLight connectionLight;

int packetCount = 0;
int globalMax = 0;
String scaleMode;

void setup() {
  // Set up window
  size(1024, 768);
  frameRate(60);
  smooth();
  surface.setTitle("Processing Brain Grapher");  

  // Set up serial connection
  println("Find your Arduino in the list below, note its [index]:\n");
  
  for (int i = 0; i < Serial.list().length; i++) {
    println("[" + i + "] " + Serial.list()[i]);
  }
  
  // Put the index found above here:
  serial = new Serial(this, Serial.list()[0], 9600);

  serial.bufferUntil(10);

  // Set up the ControlP5 knobs and dials
  controlP5 = new ControlP5(this);
  
  controlP5.setColorValueLabel(color(0));
  controlP5.setColorCaptionLabel(color(0)); 
  controlP5.setColorBackground(color(0));
  controlP5.disableShortcuts(); 
  controlP5.setMouseWheelRotation(0);
  controlP5.setMoveable(false);

  // Create the channel objects
  channels[0] = new Channel("Signal Quality", color(0), "");
  channels[1] = new Channel("Attention", color(100), "");
  channels[2] = new Channel("Meditation", color(50), "");
  channels[3] = new Channel("Delta", color(219, 211, 42), "Dreamless Sleep");
  channels[4] = new Channel("Theta", color(245, 80, 71), "Drowsy");
  channels[5] = new Channel("Low Alpha", color(237, 0, 119), "Relaxed");
  channels[6] = new Channel("High Alpha", color(212, 0, 149), "Relaxed");
  channels[7] = new Channel("Low Beta", color(158, 18, 188), "Alert");
  channels[8] = new Channel("High Beta", color(116, 23, 190), "Alert");
  channels[9] = new Channel("Low Gamma", color(39, 25, 159), "Multi-sensory processing");
  channels[10] = new Channel("High Gamma", color(23, 26, 153), "???");

  // Manual override for a couple of limits.
  channels[0].minValue = 0;
  channels[0].maxValue = 200;
  channels[1].minValue = 0;
  channels[1].maxValue = 100;
  channels[2].minValue = 0;
  channels[2].maxValue = 100;
  channels[0].allowGlobal = false;
  channels[1].allowGlobal = false;
  channels[2].allowGlobal = false;

  // Set up the monitors, skip the signal quality
  for (int i = 0; i < monitors.length; i++) {
    monitors[i] = new Monitor(channels[i + 1], i * (width / 10), height / 2, width / 10, height / 2);
  }

  monitors[monitors.length - 1].w += width % monitors.length;

  // Set up the graph
  graph = new Graph(0, 0, width, height / 2);

  // Set yup the connection light
  connectionLight = new ConnectionLight(width - 140, 10, 20);
}

void draw() {
  // Keep track of global maxima
  if (scaleMode == "Global" && (channels.length > 3)) {
    for (int i = 3; i < channels.length; i++) {
      if (channels[i].maxValue > globalMax) globalMax = channels[i].maxValue;
    }
  }

  // Clear the background
  background(255);

  // Update and draw the main graph
  graph.update();
  graph.draw();

  // Update and draw the connection light
  connectionLight.update();
  connectionLight.draw();

  // Update and draw the monitors
  for (int i = 0; i < monitors.length; i++) {
    monitors[i].update();
    monitors[i].draw();
  }
}

void serialEvent(Serial p) {
  // Split incoming packet on commas
  // See https://github.com/kitschpatrol/Arduino-Brain-Library/blob/master/README for information on the CSV packet format
  
  String incomingString = p.readString().trim();
  print("Received string over serial: ");
  println(incomingString);  
  
  String[] incomingValues = split(incomingString, ',');

  // Verify that the packet looks legit
  if (incomingValues.length > 1) {
    packetCount++;

    // Wait till the third packet or so to start recording to avoid initialization garbage.
    if (packetCount > 3) {
      
      for (int i = 0; i < incomingValues.length; i++) {
        String stringValue = incomingValues[i].trim();

      int newValue = Integer.parseInt(stringValue);

        // Zero the EEG power values if we don't have a signal.
        // Can be useful to leave them in for development.
        if ((Integer.parseInt(incomingValues[0]) == 200) && (i > 2)) {
          newValue = 0;
        }

        channels[i].addDataPoint(newValue);
      }
    }
  } 
}


// Utilities

// Extend Processing's built-in map() function to support the Long datatype
long mapLong(long x, long in_min, long in_max, long out_min, long out_max) { 
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

// Extend Processing's built-in constrain() function to support the Long datatype
long constrainLong(long value, long min_value, long max_value) {
  if (value > max_value) return max_value;
  if (value < min_value) return min_value;
  return value;
}