/**
 * We wish to implement abarrier using monitors in order to coordinate N threads.
 * A barrier provides a unique operation called waitAtBarrier. The idea is that 
 * each of the N threads invokes the operation waitAtBarrier and its effect is that
 * the thread will block, and cannot continue, until all remaining threads invoke 
 * the waitAtBarrier operation. For example, if b is a barrier for coordinating 3
 * threads, the following use of b in each thread guarantees that the letters will 
 * be displayed before the numbers. Supply an implementation for the barrier
 * monitor. You may assume that once all N processes reach the barrier, they will
 * be allowed to continue and so will all subsequent threads that call waitAtBarrier
 * (non-cyclic barrier or count down latch).
 */

class Barrier {
    // complete
    final int resistance = 0;
    int count = 0;
    public synchronized void waitAtBarrier() {
        count++;
        while(count < resistance) {
            wait();
        }
        notify(); //cascading signaling
    }
}

Barrier b = new Barrier();

Thread.start { //T1
    print('a');
    b.waitAtBarrier();
    print(1);
}

Thread.start { //T1
    print('b');
    b.waitAtBarrier();
    print(2);
}

Thread.start { //T1
    print('c');
    b.waitAtBarrier();
    print(3);
}