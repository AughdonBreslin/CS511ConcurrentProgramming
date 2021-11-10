


class PC { //prod cons
    Object buffer;
    
    public synchronized void produce(Object o) {
        while(buffer != null) {
            wait();
        }
        buffer = o;
        notifyAll();
    }
    
    public synchronized Object consume() {
         while(buffer == null) {
            wait();
        }
        Object o = buffer;
        buffer = null;
        notifyAll();
        return o;
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