class Graph {
  // View class to draw a graph of the channel model's values over time.
  // Used as a singleton.

  int x, y, w, h, pixelsPerSecond, gridColor, gridX, originalW, originalX;
  long leftTime, rightTime, gridTime;
  boolean scrollGrid;
  String renderMode;
  float gridSeconds;
  Slider pixelSecondsSlider;
  RadioButton renderModeRadio;
  RadioButton scaleRadio;

  Graph(int _x, int _y, int _w, int _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;

    pixelsPerSecond = 50;
    gridColor = color(0);
    gridSeconds = 1; // seconds per grid line
    scrollGrid = false;

    originalW = w;
    originalX = x;    

    // Set up GUI controls
    pixelSecondsSlider = controlP5.addSlider("PIXELS PER SECOND", 10, width, 50, 16, 16, 100, 10);
    pixelSecondsSlider.setColorForeground(color(180));
    pixelSecondsSlider.setColorActive(color(180));
    pixelSecondsSlider.setColorValueLabel(color(255));

    renderModeRadio = controlP5.addRadioButton("RENDER MODE", 16, 36);
    renderModeRadio.setColorForeground(color(255));
    renderModeRadio.setColorActive(color(0));
    renderModeRadio.setColorBackground(color(180));
    renderModeRadio.setSpacingRow(4);    
    renderModeRadio.addItem("Lines", 1);
    renderModeRadio.addItem("Curves", 2);
    renderModeRadio.addItem("Shaded", 3);
    renderModeRadio.addItem("Triangles", 4);
                
    renderModeRadio.activate(0);

    scaleRadio = controlP5.addRadioButton("SCALE MODE", 104, 36);
    scaleRadio.setColorForeground(color(255));
    scaleRadio.setColorActive(color(0));
    scaleRadio.setColorBackground(color(180));
    scaleRadio.setSpacingRow(4);    
    scaleRadio.addItem("Local Maximum", 1);
    scaleRadio.addItem("Global Maximum", 2);        
    scaleRadio.activate(0);
  }

  void update() {
    // Set pixels per second from GUI slider
    pixelsPerSecond = round(pixelSecondsSlider.getValue());

    // Set render mode from GUI radio buttons
    switch (round(renderModeRadio.getValue())) {
    case 1:
      renderMode = "Lines";
      break;
    case 2:
      renderMode = "Curves";
      break;
    case 3:
      renderMode = "Shaded";
      break;
    case 4:
      renderMode = "Triangles";
      break;
    }

    // Set scale mode from GUI radio buttons
    switch(round(scaleRadio.getValue())) {
    case 1:
      scaleMode = "Local";
      break;
    case 2:
      scaleMode = "Global";
      break;
    }

    // Smooth drawing kludge
    w = originalW;
    x = originalX;    

    w += (pixelsPerSecond * 2);
    x -= pixelsPerSecond;

    // Figure out the left and right time bounds of the graph, based on
    // the pixels per second value
    rightTime = System.currentTimeMillis();
    leftTime = rightTime - ((w / pixelsPerSecond) * 1000);
  }

  void draw() {
    pushMatrix();
    translate(x, y);

    // Background



    fill(220);
    rect(0, 0, w, h);

    // Draw the background graph paper grid
    strokeWeight(1);
    stroke(255);

    if (scrollGrid) {
      // Start from the first whole second and work right           
      gridTime = (rightTime / (long)(1000 * gridSeconds)) * (long)(1000 * gridSeconds);
    }
    else {
      gridTime = rightTime;
    }

    while (gridTime >= leftTime) {
      int gridX = (int)mapLong(gridTime, leftTime, rightTime, 0L, (long)w);
      line(gridX, 0, gridX, h);
      gridTime -= (long)(1000 * gridSeconds);
    }

    // Draw square horizontal grid for now
    int gridY = h;
    while (gridY >= 0) {
      gridY -= pixelsPerSecond * gridSeconds; 
      line(0, gridY, w, gridY);
    }

    // Draw each channel
    noFill();               
    if (renderMode == "Shaded" || renderMode == "Triangles") noStroke();        
    if (renderMode == "Curves" || renderMode == "Lines") strokeWeight(2);

    for (int i = 0; i < channels.length; i++) {
      Channel thisChannel = channels[i];

      if (thisChannel.graphMe) {
        // Draw the graph line
        if (renderMode == "Lines" || renderMode == "Curves") stroke(thisChannel.drawColor);

        if (renderMode == "Shaded" || renderMode == "Triangles") {
          noStroke();
          fill(thisChannel.drawColor, 120);
        }

        if (renderMode == "Triangles") {
          beginShape(TRIANGLES);
        } 
        else {
          beginShape();
        }

        if (renderMode == "Curves" || renderMode == "Shaded") vertex(0, h);

        for (int j = 0; j < thisChannel.points.size(); j++) {
          Point thisPoint = (Point)thisChannel.points.get(j);

          // check bounds
          if ((thisPoint.time >= leftTime) && (thisPoint.time <= rightTime)) {

            int pointX = (int)mapLong(thisPoint.time, leftTime, rightTime, 0L, (long)w);
            int pointY = 0;

            if ((scaleMode == "Global") && (i > 2)) {
              // Global scale                   
              pointY = (int)map(thisPoint.value, 0, globalMax, h, 0);
            }
            else {
              // Local scale
              pointY = (int)map(thisPoint.value, thisChannel.minValue, thisChannel.maxValue, h, 0);
            }

            if (renderMode == "Curves") {
              curveVertex(pointX, pointY);
            }
            else {
              vertex(pointX, pointY);
            }
          }
        }
      }

      if (renderMode == "Curves" || renderMode == "Shaded") vertex(w, h);
      if (renderMode == "Lines" || renderMode == "Curves" || renderMode == "Triangles") endShape();
      if (renderMode == "Shaded") endShape(CLOSE);
    }

    popMatrix();

    // GUI background matte
    noStroke();
    fill(255, 150);
    rect(10, 10, 195, 81);
  }
}