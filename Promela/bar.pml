
byte ticket = 0;
byte mutex = 1;

/* additional declarations here */
byte p = 0;
byte j = 0;

inline acquire(sem) {
    atomic {
        sem>0 -> sem--
    }
}

inline release(sem) {
    sem++
}

active [20] proctype Jets() {
    /* complete */
end1: /* valid end state */
    acquire(mutex);
end2:
    acquire(ticket);
    acquire(ticket);
    release(mutex);
    //go in
    atomic {
        j++;
        // printf("J: %d, P: %d\n", j, p);
        assert(j*2 <= p);
    }
}
active [20] proctype Patriots() {
    /* complete */
    release(ticket);
    //go in
    atomic {
        p++;
        // printf("J: %d, P: %d\n", j, p);
        assert(j*2 <= p);
    }
}