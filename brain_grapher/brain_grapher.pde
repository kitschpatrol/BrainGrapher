import processing.serial.*;

Serial serial;
int lf = 10;	// ASCII linefeed
Channel[] channels = new Channel[11];
Graph graph;

void setup() {
	size(800, 600);
	
	// Create each channel
	serial = new Serial(this, Serial.list()[0], 9600);	
	serial.bufferUntil(10);
	
	// Creat the channel objects
	// yellow to purple and then the space in between, grays for the alphas
	channels[0] = new Channel("Signal Quality", color(20), "");
	channels[1] = new Channel("Attention", color(30), "");
	channels[2] = new Channel("Meditation", color(40), "");
	channels[3] = new Channel("Delta", color(50), "Dreamless Sleep");
	channels[4] = new Channel("Theta", color(60), "Drowsy");
	channels[5] = new Channel("Low Alpha", color(70), "Relaxed");
	channels[6] = new Channel("High Alpha", color(80), "Relaxed");
	channels[7] = new Channel("Low Beta", color(90), "Alert");
	channels[8] = new Channel("High Beta", color(100), "Alert");
	channels[9] = new Channel("Low Gamma", color(110), "???");
	channels[10] = new Channel("High Gamma", color(120), "???");
	
	// Set up the graph
	graph = new Graph(0, 0, width, height / 2);
}

void draw() {
	background(255);
	
	graph.update();
	graph.draw();
}

void serialEvent(Serial p) {
	String[] incomingValues = split(p.readString(), ',');

	println(incomingValues);

	// Add the data to the logs
	if (incomingValues.length > 1) {
		for (int i = 0; i < incomingValues.length; i++) {
			int newValue = Integer.parseInt(incomingValues[i].trim());
			channels[i].addDataPoint(newValue);
		}
	}
}



// Extend core's Map function to the Long datatype.
long mapLong(long x, long in_min, long in_max, long out_min, long out_max)  { 
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min; 
}

long constrainLong(long value, long min_value, long max_value) {
  if(value > max_value) return max_value;
  if(value < min_value) return min_value;
  return value;
}
