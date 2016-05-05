class ConnectionLight {
  // View class to display EEG connection strength.
  // Used as a singleton.

  int x, y, diameter, latestConnectionValue;
  int currentColor = 0;
  int goodColor = color(0, 255, 0);
  int badColor = color(255, 255, 0);
  int noColor = color(255, 0, 0);
  Textlabel label;
  Textlabel packetsRecievedLabel;

  ConnectionLight(int _x, int _y, int _diameter) {
    x = _x;
    y = _y;
    diameter = _diameter;

    // Set up the text label
    label = new Textlabel(controlP5, "CONNECTION QUALITY", 32, 11, 200, 30);
    label.setMultiline(true);	
    label.setColorValue(color(0));
    
    packetsRecievedLabel = new Textlabel(controlP5, "PACKETS RECEIVED: 0", 5, 35, 200, 30);
    packetsRecievedLabel.setMultiline(false);  
    packetsRecievedLabel.setColorValue(color(0));    
  }

  void update() {
    // Show red if no packets yet
    if (channels[0].points.size() == 0) {
      latestConnectionValue = 200;
    }
    else {
      latestConnectionValue = channels[0].getLatestPoint().value;
    }

    if (latestConnectionValue == 200) currentColor = noColor;
    if (latestConnectionValue < 200) currentColor = badColor;
    if (latestConnectionValue == 00) currentColor = goodColor;
    
    packetsRecievedLabel.setText("PACKETS RECIEVED: " + packetCount);
    
  }

  void draw() {
    pushMatrix();
    translate(x, y);

    noStroke();
    fill(255, 150);
    rect(0, 0, 132, 50);

    noStroke();
    fill(currentColor);
    ellipseMode(CORNER);
    ellipse(5, 4, diameter, diameter);

    label.draw();
   packetsRecievedLabel.draw(); 		
    popMatrix();
  }
}