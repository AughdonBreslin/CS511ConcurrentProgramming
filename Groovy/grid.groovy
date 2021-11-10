
class Grid {
    int p=0;
    int c=0;

    void synchronized startConsuming() {
        while(c==p) {
            wait();
        }
    }

    void synchronized stopConsuming() {
        c--;
        notify(); //either let someone else start consuming or
                    //let a producer leave
    }

    void synchronized startProducing() {
        p++;
        notify(); //either wake up a consumer or stop another producer
    }

    void synchronized stopProducing() {
        while(c==p) {
            wait();
        }
    }
}