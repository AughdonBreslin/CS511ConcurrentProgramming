
byte turn = 1;

proctype P(){
    do
     :: do
         :: turn == 1 -> break;
            else
        od;
        printf("P went in.");
        turn = 2;
    od;
}

proctype Q(){
    do
     :: do
         :: turn == 2 -> break;
            else
        od;
        printf("Q went in.");
        turn = 1;
    od;
}

init {
    atomic {
        run P();
        run Q();
    }
}