import java.util.concurrent.Semaphore;
Semaphore A = new Semaphore(0);
Semaphore E = new Semaphore(0);
Semaphore G = new Semaphore(0);

Thread.start {
    3.times {
        print("A");
        A.release();
        print("B");
        G.acquire();
        print("C");
        print("D");
    }
}

Thread.start {
    3.times {
        print("E");
        E.release();
        A.acquire();
        print("F");
        print("G");
        G.release();
    }
}

Thread.start {
    3.times {
        E.acquire();
        print("H");
        print("I");
    }
}

