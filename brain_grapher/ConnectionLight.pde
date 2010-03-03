class ConnectionLight {
	int x, y;
	int currentColor = 0;
	int goodColor = color(0, 255, 0);
	int badColor = color(255, 255, 0);
	int noColor = color(255, 0, 0);
	int diameter;
	int latestConnectionValue;
	Textlabel label;
	PApplet parent;

	ConnectionLight(int _x, int _y, int _diameter, PApplet _parent) {
		x = _x;
		y = _y;
		diameter = _diameter;
		parent = _parent;
		
 		label = new Textlabel(parent,"CONNECTION\nQUALITY", 32, 6);		
		label.setFont(ControlP5.standard58);
		label.setColorValue(color(0));
	}
	
	void update() {
		latestConnectionValue = channels[0].getLatestPoint().value;
		if(latestConnectionValue == 200) currentColor = noColor;
		if(latestConnectionValue < 200) currentColor = badColor;
		if(latestConnectionValue == 00) currentColor = goodColor;
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
		
 		label.draw(parent); 		
		popMatrix();
	}

}