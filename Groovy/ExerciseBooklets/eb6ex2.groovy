
/*
 *  We wish to implement athree-way sequencerusing monitors in order to
 *  coordinate N threads.  A three-way sequencer provides the following
 *  operations: first, second, third.  The idea is that each of the threads
 *  can invoke any of these operations.  The sequencer will alternate 
 *  cyclically the execution of first, then second, and finally third.
 */

import java.util.concurrent.locks.*;

class TWS {
    private int state = 1;
    public synchronized void one() {
        while(state != 1) {
            wait();
        }
        state = 2;
        notifyAll();
    }
    public synchronized void two() {
        while(state != 2) {
            wait();
        }
        state = 3;
        notifyAll();
    }
    public synchronized void three() {
        while(state != 3) {
            wait();
        }
        state = 1;
        notifyAll();
    }   
}