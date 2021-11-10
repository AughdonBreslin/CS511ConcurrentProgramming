class Bar {
    // your code here
    int pats = 0
    int pc = 0
    int jc = 0
    public synchronized void patriots() {
        pc++;
        println ("patriot " +pc+ " went in");
        pats++;
        if(pats >= 2) {
            notify();
        }
        // printState();
    }
    public synchronized void jets() {
        while (pats < 2){
            wait();
        }
        jc++;
        println("jet " +jc+ " went in");
        pats -=2;

        // jc++;
        // printState();
    }

    public synchronized void printState() {
        println "--> jf " +jc+ " pf " +pc;
    }
}

Bar b = new Bar();
50.times {
    Thread.start { // jets
        b.jets();
    }
}

100.times {
    Thread.start { //patriots
        b.patriots();
    }
}