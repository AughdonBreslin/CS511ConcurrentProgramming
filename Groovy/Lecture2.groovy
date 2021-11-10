int x = 0;
Thread.start { // P
  x:=2;
}

Thread.start { // Q
  3.times {
    x = x + 1; // atomic
  }
}