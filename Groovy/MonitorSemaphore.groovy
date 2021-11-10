

class Semaphore {
    private int perm=0;
    
    Semaphore(int init) {
        perm=init;
    }
    
    public synchronized void acquire() {
        while(perm==0) {
            wait(); // place thread on wait-set
        }
        perm--;
    }
    
    public synchronized void release() {
        notify(); // wake the next one up
        perm++;
    }
}

Semaphore mutex = new Semaphore(1);
c = 0;

def P = Thread.start {
    10.times {
        mutex.acquire();
        c++;
        mutex.release();
    }
}

def Q = Thread.start {
    10.times {
        mutex.acquire();
        c++;
        mutex.release();
    }
}
P.join();
Q.join();
println(c)