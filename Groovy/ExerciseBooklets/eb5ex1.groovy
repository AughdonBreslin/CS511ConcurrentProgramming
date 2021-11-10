import java.util.concurrent.Semaphore;
Semaphore ticket = new Semaphore(0);
Semaphore accessProtocol = new Semaphore(1);

50.times{
    Thread.start{ //Patriots
        ticket.release();
        //go into bar
    }
}
50.times{
    Thread.start{ //Jets
        if(not lateFlag) {
            accessProtocol.acquire();
            ticket.acquire();
            ticket.acquire();
            accessProtocol.release();
            //go into bar
        }
    }
}

//pt 2 modification
Thread.start { //LateFlagHandler
    sleep(5000);
    lateFlag=true;
    // When its late, free any blocked Jets fans
    ticket.release();
    ticket.release();
}