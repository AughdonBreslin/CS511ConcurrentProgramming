
import java.util.concurrent.Semaphore;

int x=0;
Semaphore mutex = new Semaphore(1);

def P = Thread.start {
    10.times {
        mutex.acquire();
        x=x+1;
        mutex.release();
    }
}

def Q = Thread.start {
    10.times {
        mutex.acquire();
        x=x+1;
        mutex.release();
    }
}

P.join()
Q.join()

println x;