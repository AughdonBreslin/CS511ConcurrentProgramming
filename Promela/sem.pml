
byte cBeforeA = 0;

inline acquire(s) {
    atomic {
        s>0;
        s--;
    }
}
inline release(s) {
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


