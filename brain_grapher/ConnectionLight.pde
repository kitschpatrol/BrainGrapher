class ConnectionLight {
  // View class to display EEG connection strength.
  // Used as a singleton.

  int x, y, diameter, latestConnectionValue;
  int currentColor = 0;
  int goodColor = color(0, 255, 0);
  int badColor = color(255, 255, 0);
  int noColor = color(255, 0, 0);
  Textlabel label;

  ConnectionLight(int _x, int _y, int _diameter) {
    x = _x;
    y = _y;
    diameter = _diameter;

    // Set up the text label
    label = new Textlabel(controlP5, "CONNECTION QUALITY", 32, 6, 50, 20);
    label.setMultiline(true);	
    label.setFont(ControlP5.standard58);
    label.setColorValue(color(0));
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
  }

  void draw() {
    pushMatrix();
    translate(x, y);

    noStroke();
    fill(255, 150);
    rect(0, 0, 88, 28);

    noStroke();
    fill(currentColor);
    ellipseMode(CORNER);
    ellipse(5, 4, diameter, diameter);

    label.draw(); 		
    popMatrix();
  }
}

