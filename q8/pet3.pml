
// Aughdon Breslin and Jason Rossi

byte last = 1;
bool wantP = false;
bool wantQ = false;
byte critical = 0;

proctype P() {
    do
     :: last = 1;
        wantP = true;
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
     :: last = 2;
        wantQ = true;
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