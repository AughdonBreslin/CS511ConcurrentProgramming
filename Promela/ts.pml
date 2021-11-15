
byte c = 0;

proctype P() {
    byte i = 0;
    do
     :: i < 10 ->
        c++;
        i++;
     :: else ->
        break
    od
}

proctype Q() {
    byte i=0;
    do
     :: i<10 ->
        c++;
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
}