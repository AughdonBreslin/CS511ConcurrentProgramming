byte np = 0;
byte nq = 0;
byte crit = 0;

proctype P() {
    do
     :: //non critical
        np = nq+1;
        do
         :: (nq==0) || (np<=nq) -> break;
            else
        od;
        //critical
        crit++;
        assert(crit==1);
        crit--;
        np = 0;
        //non critical
    od;
}

proctype Q() {
    do
     :: //non critical
        nq = np+1;
        do
         :: (np==0) || (nq<np) -> break;
            else
        od;
        //critical
        crit++;
        assert(crit==1);
        crit--;
        nq = 0;
        //non critical
    od;
}

init {
    atomic {
        run P();
        run Q();
    }
}