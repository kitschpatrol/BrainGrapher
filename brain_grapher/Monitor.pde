class Monitor {
	int x, y, w, h, currentValue, targetValue, backgroundColor;
	Channel sourceChannel;
	CheckBox showGraph;	
	Textlabel label;
	PApplet parent;	
	
	Monitor(Channel _sourceChannel, int _x, int _y, int _w, int _h, PApplet _parent) {
		sourceChannel = _sourceChannel;
		x = _x;
		y = _y;
		w = _w;
		h = _h;
		parent = _parent;
		currentValue = 0;
		backgroundColor = color(255);
		showGraph = controlP5.addCheckBox("showGraph",x + 16, y + 34);  		
		showGraph.addItem("GRAPH",0);
		showGraph.activate(0);
		showGraph.setColorForeground(sourceChannel.drawColor);
		showGraph.setColorActive(color(0));
		
 		label = new Textlabel(parent,sourceChannel.name, x + 16, y + 16);
		label.setFont(ControlP5.grixel);
		label.setColorValue(0);

	}
	
	void update() {

	}
	
	void draw() {
		// this technically only neds to happen on the packet, not every frame
		if(showGraph.getItem(0).value() == 0) {
			sourceChannel.graphMe = false;
		}
		else {
			sourceChannel.graphMe = true;
		}
		

		pushMatrix();
		translate(x, y);		
		// Background
		noStroke();
		fill(backgroundColor);
		rect(0, 0, w, h);

		// border line
		strokeWeight(1);
		stroke(220);
		line(w - 1, 0, w - 1, h);

		
		if(sourceChannel.points.size() > 0) {
		
			Point targetPoint = (Point)sourceChannel.points.get(sourceChannel.points.size() - 1);
			targetValue = round(map(targetPoint.value, sourceChannel.minValue, sourceChannel.maxValue, 0, h));

			if((scaleMode == "Global") && sourceChannel.allowGlobal) {					
				targetValue = (int)map(targetPoint.value, 0, globalMax, 0, h);	
			}	
							
			// Calculate the new position on the way to the target with easing
    	currentValue = currentValue + round(((float)(targetValue - currentValue) * .08));
			
			// Bar
			noStroke();
			fill(sourceChannel.drawColor);
			rect(0, h - currentValue, w, h);
		}

		// Draw the checkbox matte
		
		noStroke();
		fill(255, 150);		
		rect(10, 10, w - 20, 40);

			popMatrix();


 		label.draw(parent);		
	}
	
	

}

