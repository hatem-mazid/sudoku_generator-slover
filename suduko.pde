import de.looksgood.ani.*;

rules r;

void setup() {
  Ani.init(this);

  size(500, 500);
  r = new rules(30, 30);
}

void draw() {
  background(240);
  r.display();
}

void mousePressed() {
  r.mouseSelect(mouseX, mouseY);
}

void keyPressed(KeyEvent e) {
  r.moveSelected(e.getKeyCode());  //move by arrow
  r.changeSelectedValue(key);      //change value by numbers
  if (key == 'g') {
    r.generate();
  }
  if (key == 's') {
    r.oneProbabilitiesInCell();
  }
  if (key == 'f') {
    r.fewestProbabilities();
  }
  if (key == 'r') {
    r.restart();
  }

  if (key == 'a') {
    r.customPuzzle(new int[]{
      5, 3, 0, /**/ 0, 7, 0, /**/ 0, 0, 0, 
      6, 0, 0, /**/ 1, 9, 5, /**/ 0, 0, 0, 
      0, 9, 8, /**/ 0, 0, 0, /**/ 0, 6, 0, 
      //**********************************
      8, 0, 0, /**/ 0, 6, 0, /**/ 0, 0, 3, 
      4, 0, 0, /**/ 8, 0, 3, /**/ 0, 0, 1, 
      7, 0, 0, /**/ 0, 2, 0, /**/ 0, 0, 6, 
      //**********************************
      0, 6, 0, /**/ 0, 0, 0, /**/ 2, 8, 0, 
      0, 0, 0, /**/ 4, 1, 9, /**/ 0, 0, 5, 
      0, 0, 0, /**/ 0, 8, 0, /**/ 0, 7, 9
      });
  }
}
