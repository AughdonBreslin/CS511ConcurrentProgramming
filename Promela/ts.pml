// turnstile
byte c = 0;

proctype P() {
    byte i = 0;
    byte temp = 0;
    do
     :: i < 10 ->
        temp = c;
        c = temp+1;
        i++;
     :: else ->
        break
    od
}

proctype Q() {
    byte i=0;
    byte temp = 0;
    do
     :: i<10 ->
        temp = c;
        c = temp+1;
        i++;
     :: else ->
        break
    od
}

init {
    atomic {
        run P();
        run Q();
    }
    (_nr_pr == 1);
    printf("Total %d\n", c);
    assert(c>2);
}