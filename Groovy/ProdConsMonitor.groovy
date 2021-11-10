


class PC { //prod cons
    Object buffer;
    
    synchronized void produce(Object o) {
        buffer = o;
    }
    
    synchronized void consume() {
        Object o = buffer;
        buffer = null;
        return o;
    }
}