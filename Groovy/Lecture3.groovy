int x = 0;

Thread.start { // P
  int local = x;
  x = local + 1; // atomic
}

Thread.start { // Q
  int local = x;
  x = local + 1; // atomic
}