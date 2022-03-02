
bool wantP = false;
bool wantQ = false;

proctype P() {
    do
     :: wantP = true;
        do
         :: wantQ == false -> break;
            else
        od;
progress1:
        printf("P went in.");
        wantP = false;
    od;
}

proctype Q() {
    do
     :: wantQ = true;
        do
         :: wantP == false -> break;
            else
        od;
progress2:
        printf("Q went in.");
        wantQ = false;
    od;
}

init {
    atomic {
        run P();
        run Q();
    }
}