
bool wantP = false;
bool wantQ = false;

proctype P() {
    do
     :: 
        do
         :: !wantQ -> break
         :: else
        od;
        wantP = true;
        wantP = false;
    od
}

proctype Q() {
    do
     :: 
        do
         :: !wantP -> break
         :: else
        od;
        wantQ = true;
progress1:
        wantQ = false;
    od
}

init {
    atomic {
        run P();
        run Q();
    }
}