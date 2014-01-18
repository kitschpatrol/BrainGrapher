class Point {
  // Value object class to store time / value tuple. 
  // One instance per data point per channel.
  long time;
  int value;

  Point(long _time, int _value) {
    time = _time;
    value = _value;
  }
}
