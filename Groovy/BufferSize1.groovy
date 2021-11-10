Object buffer; //buffer of size 1


// Lock step!
Semaphore consume = new Semaphore(0);
Semaphore produce = new Semaphore(1);

Thread.start { //Producer
    while(true){
        //make sure theres nothing being overwritten
        produce.acquire();
        //make the item
        buffer=produceItem();
        //Allow the consumer to eat
        consume.release();
    }
}

Thread.start { //Consumer
    while(true){
        //make sure theres something to consume
        consume.acquire();
        //Eat the item in the buffer
        consume(buffer);
        //Allow the producer to make
        produce.release();
    }
}