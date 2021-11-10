Object[] buffer; //buffer of size N
fint int P = 100; //100 producers
final int Q = 20; //20 consumers

Semaphore consume = new Semaphore(0);
Semaphore produce = new Semaphore(N);
Semaphore mutexP = new Semaphore(1);
Semaphore mutexC = new Semaphore(1);

P.times {
    Thread.start { //Producer
        while(true){
            //make sure theres nothing being overwritten
            produce.acquire();
            mutexP.acquire(); //GO INTO CRITICAL SECTION
            //make the item
            buffer[start]=produceItem();
            start = (start + 1) % N;
            mutexP.release();
            //Allow the consumer to eat
            consume.release();
        }
    }
}
Q.times {
    Thread.start { //Consumer
        while(true){
            //make sure theres something to consume
            consume.acquire();
            mutexC.acquire(); //GO INTO CRITICAL SECTION
            //Eat the item in the buffer
            consume(buffer[rear]);
            rear = (rear + 1) % N;
            mutexC.release()
            //Allow the producer to make
            produce.release();
        }
    }
}