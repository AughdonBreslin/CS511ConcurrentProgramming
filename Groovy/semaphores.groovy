import java.util.concurrent.Semaphore;


Semaphore cAfterA = new Sempahore(0);

Thread.start { //P
    println "A";
    cAfterA.release();
    println "B";
}

Thread.start { //Q
    cAfterA.acquire();
    println "C";
    println "D";
}