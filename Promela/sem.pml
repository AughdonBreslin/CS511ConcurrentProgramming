
byte cBeforeA = 0;

inline acquire(int s) {
    atomic {
        s>0;
        s--;
    }
}
inline release(int s) {
    s++;
}

proctype P() {
    acquire(cBeforeA);
    printf("A\n");
    printf("B\n");
}

proctype Q() {
    printf("C\n");
    release(cBeforeA);
    printf("D\n");
}

init {
    atomic {
        run P();
        run Q();
    }
}


