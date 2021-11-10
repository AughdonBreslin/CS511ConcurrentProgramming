import java.util.concurrent.Semaphore;

Semaphore mutex = new Semaphore(1);
Semaphore done = new Semaphore(??);
c=0;

Thread.start {
    50.times {
        mutex.acquire();
        c++;
        mutex.release();
    }
}

Thread.start {
    50.times {
        mutex.acquire();
        c++;
        mutex.release();
    }
}

done.acquire()
println c;    