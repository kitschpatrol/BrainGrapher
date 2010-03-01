class Graph {
	int x, y, w, h, pixelsPerSecond, gridColor, gridX;
	long leftTime, rightTime, gridTime;
	boolean scrollGrid;
	float gridSeconds;

	Graph(int _x, int _y, int _w, int _h) {
		x = _x;
		y = _y;
		w = _w;
		h = _h;
		pixelsPerSecond = 50;
		gridColor = color(0);
		gridSeconds = 1; // seconds per grid line
		scrollGrid = false;
		
		// temporary overdraw kludge to keep graph smooth
		w += (pixelsPerSecond * 2);
		x -= pixelsPerSecond;
		
	}
	
	void update() {
		
	}
	
	void draw() {
		// Figure out the left and right time bounds of the graph, based on
		// the pixels per second value
		rightTime = System.currentTimeMillis();
		leftTime = rightTime - ((w / pixelsPerSecond) * 1000);
		
		
		pushMatrix();
		translate(x, y);

		noStroke();		
		
		// Background
		fill(220);
		rect(0, 0, w, h);


		// Draw the background graph
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
	
		


		// Draw each channel (pass in as constructor arg?)
		noFill();		
		strokeWeight(2);
		
		for (int i = 0; i < channels.length; i++) {
			Channel thisChannel = channels[i];
			
			// Draw the line
			stroke(thisChannel.drawColor);


			beginShape();
			for (int j = 0; j < thisChannel.points.size(); j++) {
				Point thisPoint = (Point)thisChannel.points.get(j);
					
				// check bounds
				if((thisPoint.time >= leftTime) && (thisPoint.time <= rightTime)) {
				
					int pointX = (int)mapLong(thisPoint.time, leftTime, rightTime, 0L, (long)w);
					int pointY = (int)map(thisPoint.value, thisChannel.minValue, thisChannel.maxValue, h, 0);
				
					//ellipseMode(CENTER);
					//ellipse(pointX, pointY, 5, 5);
				
					vertex(pointX, pointY);
				}
			}
			endShape();

		}
		
		
		popMatrix();
	}
	
}