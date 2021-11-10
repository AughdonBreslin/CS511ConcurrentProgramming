import java.util.concurrent.Semaphore;
Semaphore Aenter = new Semaphore(1);
Semaphore Benter = new Semaphore(1);

Thread.start { //p
    while (true) {
        Aenter.acquire();
        print("A");
        Benter.release();
    }
}
//To make it ABABABAB exclusively, start Benter on 0
Thread.start { //q
    while (true) {
        Benter.acquire();
        print("B");
        Aenter.release();
    }
}