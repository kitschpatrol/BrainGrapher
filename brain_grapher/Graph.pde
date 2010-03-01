class Graph {
	int x, y, w, h, pixelsPerSecond;
	long leftTime, rightTime;

	Graph(int _x, int _y, int _w, int _h) {
		x = _x;
		y = _y;
		w = _w;
		h = _h;
		pixelsPerSecond = 10;
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
		fill(200);
		rect(0, 0, w, h);
		
		strokeWeight(3);
		
		
		// Draw each channel (pass in as constructor arg?)
		for (int i = 0; i < channels.length; i++) {
			Channel thisChannel = channels[i];
			
			// Draw the line
			stroke(thisChannel.drawColor);
			fill(thisChannel.drawColor);
							
			//println(channels[i].points);
			
			for (int j = 0; j < thisChannel.points.size(); j++) {
				Point thisPoint = (Point)thisChannel.points.get(j);
								
				// check bounds
				int xPos = (int)mapLong(thisPoint.time, leftTime, rightTime, 0L, (long)w);
				
				ellipseMode(CENTER);
				ellipse(xPos, 0, 5, 5);
				
				
				
				
			}

		}
		
		
		popMatrix();
	}
	
}