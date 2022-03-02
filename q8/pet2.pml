
// Aughdon Breslin and Jason Rossi

byte last = 1;
bool wantP = false;
bool wantQ = false;
byte critical = 0;

proctype P() {
    do
     :: wantP = true;
        last = 1;
        do
         :: wantQ == false || last == 2 -> break;
            else
        od;
        critical++;
        assert (critical == 1);
        critical--;
        wantP = false;
    od;
}

proctype Q() {
    do
     :: wantQ = true;
        last = 2;
        do
         :: wantP == false || last == 1 -> break;
            else
        od;
        critical++;
        assert (critical == 1);
        critical--;
        wantQ = false;
    od;
}

init {
    atomic {
        run P();
        run Q();
    }
}