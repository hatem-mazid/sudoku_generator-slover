class rules { //<>// //<>// //<>// //<>//
  ArrayList<numberBox> boxes;
  numberBox selectedCell;

  //display info
  float xOffset;
  float yOffset;

  //generate 
  boolean sloveable;

  ////////////////////////////////////////////////
  //constructor
  ////////////////////////////////////////////////
  rules(float x, float y) {
    boxes = new ArrayList<numberBox>();

    for (int i = 0; i < 9; i++)
      for (int j = 0; j < 9; j++) {
        numberBox nb = new numberBox(j*38, i*38); 
        nb.row = i;
        nb.col = j;
        nb.box = floor(nb.col/3) + floor(nb.row/3) * 3;

        if (floor(i / 3) == 1) nb.gray = !nb.gray;
        if (floor(j / 3) == 1) nb.gray = !nb.gray;

        boxes.add(nb);
      }

    selectedCell = null;

    xOffset = x;
    yOffset = y;

    sloveable = true;
  }
  ///////////////////////////////////////
  //main methods
  ///////////////////////////////////////
  void display() {
    translate(xOffset, yOffset);
    for (numberBox b : boxes)
      b.display();
  }
  //////////////////////////////
  //rules methods
  //////////////////////////////
  void checkErrors() {
    resetErrors();
    for (numberBox b1 : boxes)
      for (numberBox b2 : boxes) {
        if (b1.getValue() != 0 && !b1.equals(b2) && b1.getValue() == b2.getValue()) 
          if (b1.box == b2.box || b1.row == b2.row || b1.col == b2.col) {
            b1.wrong = true;
            b2.wrong = true;
          }
      }
  }

  void resetErrors() {
    for (numberBox b : boxes) {
      b.wrong = false;
    }
  }

  void setProbabilities() {
    for (numberBox b1 : boxes) {
      b1.resetProbabilies();
      for (numberBox b2 : boxes) {
        if (b1.getValue() == 0 && b2.getValue() != 0 && !b1.equals(b2)) 
          if (b1.box == b2.box || b1.row == b2.row || b1.col == b2.col) {
            b1.removeProbability(b2.getValue());
          }
      }
    }
  }

  boolean allValuesNonZero() {
    for (numberBox b1 : boxes)
      if (b1.getValue() == 0) return false;
    return true;
  }

  boolean isSloveable() {
    for (numberBox b1 : boxes)
      if (b1.isDeadEnd()) return false;
    return true;
  }

  boolean isCorrect() {
    for (numberBox b1 : boxes)
      if (b1.wrong) return false;
    return true;
  }
  ///////////////////////////////////////////
  //generate
  ///////////////////////////////////////////
  boolean distrbuteDone;
  boolean generateDone;


  void generate() {
    if (!generateDone) {
      while (!distrbuteDone) {
        fewestProbabilities();
        setProbabilities();
      }
      if (distrbuteDone) {
        int deleted = 0;
        while (deleted < 50) {
          int index = floor(random(0, 81));
          if (boxes.get(index).getValue() != 0) {
            boxes.get(index).setValue(0);
            deleted++;
          }
        }
        for (numberBox nb : boxes) {
          if (nb.getValue() != 0) nb.onlyRead = true;
        }
        generateDone = true;
      }
    } else println("s");
  }

  void fewestProbabilities() {
    if (isSloveable() && isCorrect()) {
      numberBox fnb = boxes.get(0);
      for (numberBox nb : boxes) {
        if (nb.getValue() == 0)
          if (fnb.probabilities.size() > nb.probabilities.size()) {
            fnb = nb;
          }
      } //<>//
      if (fnb.getValue() == 0)
        fnb.setValue(fnb.probabilities.get(floor(random(fnb.probabilities.size()))));
    } else restart();

    distrbuteDone = allValuesNonZero();
  }

  void restart() {
    boxes = new ArrayList<numberBox>();

    for (int i = 0; i < 9; i++)
      for (int j = 0; j < 9; j++) {
        numberBox nb = new numberBox(j*38, i*38); 
        nb.row = i;
        nb.col = j;
        nb.box = floor(nb.col/3) + floor(nb.row/3) * 3;

        if (floor(i / 3) == 1) nb.gray = !nb.gray;
        if (floor(j / 3) == 1) nb.gray = !nb.gray;

        boxes.add(nb);
      }
    distrbuteDone = false;
    generateDone = false;
  }

  void customPuzzle(int[]p) {
    if (p.length == 81) {
      for (int i = 0; i < 81; i++) {
        boxes.get(i).setValue(p[i]);
        if (boxes.get(i).getValue() != 0)
          boxes.get(i).onlyRead = true;
      }
    }
  }
  ///////////////////////////////////////////
  //slover
  ///////////////////////////////////////////
  void oneProbabilitiesInCell() {
    if (isSloveable() && isCorrect()) {
      for (numberBox nb : boxes) {
        if (nb.probabilities.size() == 1 && nb.getValue() == 0) {
          nb.setValue(nb.probabilities.get(0));
        }
      }
    }
  }

  ///////////////////////////////////////////
  //control section
  ///////////////////////////////////////////
  void mouseSelect(float x, float y) {
    selectedCell = null;
    for (numberBox b : boxes) {
      if (b.select(x - xOffset, y - yOffset)) {
        selectedCell = b;
      }
    }
  }

  void changeSelectedValue(char input) {
    if (selectedCell != null && !selectedCell.onlyRead) {
      if (input == '0') {
        selectedCell.setValue(0);
      } else if (parseInt(input+"") != 0) {
        selectedCell.setValue(parseInt(input+""));
      }
    }
    checkErrors();
    setProbabilities();
  }

  void moveSelected(int dir) {
    if (selectedCell != null) {
      int row = selectedCell.row;
      int col = selectedCell.col;

      if (dir == LEFT && col != 0) col--;
      else if (dir == DOWN && row < 8) row++;
      else if (dir == RIGHT && col < 8) col++;
      else if (dir == UP && row != 0) row--;

      selectedCell.selected = false;
      selectedCell = boxes.get(col + row * 9);
      selectedCell.selected = true;
    }
  }
}
