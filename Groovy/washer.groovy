

Semaphore clean = new Semaphore(10);
Semaphore dirty = new Semaphore(90);

100.times {
    Thread.start { //Worker
        clean.acquire();
        //work
        dirty.release();
    }
}

20.times {
    Thread.start {
        while(true) {
            dirty.acquire();
            //clean
            clean.release();
        }
    }
}