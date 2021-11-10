
import java.util.concurrent.locks.*;


class PC { //prod cons
    Lock lock = new ReentrantLock();
    Condition full  = lock.newCondition();
    Condition empty = lock.newCondition();

    Object buffer;
    
    public void produce(Object o) {
        lock.lock();
        try {
            while(buffer != null) {
                empty.await(); // Wait for buffer to be empty
            }
            buffer = o;
            full.signal(); // Signal to the threads waiting for the buffer to be full
        } finally {
            lock.unlock();
        }
    }
    
    public synchronized Object consume() {
        lock.lock();
        try {
            while(buffer == null) {
                full.await(); // Wait for buffer to be full
            }
            Object o = buffer;
            buffer = null;
            empty.signal(); // Signal to the threads waiting for the buffer to be empty
            return o;
        } finally {
            lock.unlock();
        }
    }
}

PC b = new PC(); //buffer

100.times {
    int id = it;
    Thread.start { // Producer
        b.produce((new Random()).nextInt(33));
        println "$id produced";
    }
}

100.times {
    int id = it;
    Thread.start { // Consumer
        b.consume();
        println "$id consumed";
    }
}