Object[] buffer; //buffer of size N

Semaphore consume = new Semaphore(0);
Semaphore produce = new Semaphore(N);

Thread.start { //Producer
    while(true){
        //make sure theres nothing being overwritten
        produce.acquire();
        //make the item
        buffer[start]=produceItem();
        start = (start + 1) % N;
        //Allow the consumer to eat
        consume.release();
    }
}
Thread.start { //Consumer
    while(true){
        //make sure theres something to consume
        consume.acquire();
        //Eat the item in the buffer
        consume(buffer[rear]);
        rear = (rear + 1) % N;
        //Allow the producer to make
        produce.release();
    }
}
