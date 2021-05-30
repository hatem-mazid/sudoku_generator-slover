class numberBox {
  //display info
  float xAxis;
  float yAxis;
  int size;
  int alpha;

  //state secton
  boolean gray;
  boolean selected;
  boolean wrong;
  boolean onlyRead;

  int row;
  int col;
  int box;
  private int _value;

  ArrayList<Integer> probabilities;

  numberBox(float x, float y) {
    xAxis = x;
    yAxis = y;

    rectMode(CENTER);

    size = 35;

    probabilities = new ArrayList<Integer>(java.util.Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9));

    alpha = 255;

    Ani.from(this, .7, "xAxis", 0, Ani.BACK_OUT);
    Ani.from(this, .7, "yAxis", 0, Ani.BACK_OUT);
  }
  /////////////////////////////////////
  //properties
  /////////////////////////////////////
  void setValue(int v) {
    Ani.from(this, 1, "alpha", 0);
    println(alpha);
    _value = v;
  }

  int getValue() {
    return _value;
  }
  //////////////////////////////////////

  void display() {
    if (gray) fill(255);
    else fill(200);

    //float c = map(_value, 0, 9, 50, 200);
    //fill(c);

    if (selected) {
      fill(200, 150, 150);
    } 
    if (isDeadEnd()) fill(200, 0, 0);
    //Ani.to(this, 3, "xAxis", 0);
    rect(xAxis, yAxis, size, size);

    if (_value != 0) {
      if (wrong) fill(200, 0, 0, alpha);
      else if (onlyRead) fill(0, 150, 0, alpha);
      else fill(0, alpha);

      textAlign(CENTER, CENTER);
      textSize(size/2);
      text(_value, xAxis, yAxis);
    }
  }

  boolean select(float x, float y) {
    if (x > xAxis - size/2 && x < xAxis + size/2 &&
      y > yAxis - size/2 && y < yAxis + size/2) {
      selected = true;
      return true;
    }
    selected = false;
    return false;
  }

  void removeProbability(int v) {
    if (v != 0) {
      probabilities.remove((Object)v);
    }
  }

  void resetProbabilies() {
    probabilities = new ArrayList<Integer>(java.util.Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9));
  }

  boolean isDeadEnd() {
    if (probabilities.size() == 0) return true;
    return false;
  }
}
