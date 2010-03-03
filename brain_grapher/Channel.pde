class Channel { 

	String name;
	int drawColor;
	String description;
	boolean graphMe;
	boolean relative;
	int maxValue;
	int minValue;
	ArrayList points;
	boolean allowGlobal;
		


	Channel(String _name, int _drawColor, String _description) {
		name = _name;
		drawColor = _drawColor;
		description = _description;
		allowGlobal = true;
		points = new ArrayList();
	}
	
	
	void addDataPoint(int value) {
		
		long time = System.currentTimeMillis();
		
		if(value > maxValue) maxValue = value;
		if(value < minValue) minValue = value;
		
		points.add(new Point(time, value));
		
		// tk max length handling
	}
	
	Point getLatestPoint() {
		if(points.size() > 0) {
			return (Point)points.get(points.size() - 1);
		}
		else {
			return new Point(0, 0);
		}
	}


}