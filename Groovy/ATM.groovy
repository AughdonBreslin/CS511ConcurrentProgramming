


Semaphore atm = new Semaphore(7, true);
Semaphore mutex = new Semaphore(1);
Semaphore empCount = new Semaphore(1);

100.times{
    Thread.start { // Client
        atm.acquire();
        //use atm
        atm.release();
    }
}

200.times {
    Thread.start { //Employee


        mutex.acquire();
        if(emp == 0) {
            7.times{
                atm.acquire();
            }
        }
        empCount.acquire();
        emp++;
        empCount.release();
        mutex.release();

        //refill

        mutex.release();
        if(emp == 1) {
            7.times{
                atm.release();
            }
        }
        empCount.acquire();
        emp--;
        empCount.release();
        mutex.release();
    }
}