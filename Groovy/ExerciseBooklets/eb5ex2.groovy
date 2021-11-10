import java.util.concurrent.Semaphore;

//Semaphores
Semaphore access = new Semaphore(1);
Semaphore feedingLot = new Semaphore(20);
Semaphore mice = new Semaphore(1);
Semaphore felines = new Semaphore(1);
numMice = 0;
numFelines = 0;

20.times {
    Thread.start { //Felines
        felines.acquire();
        if(numFelines == 0){
            access.acquire();
            println("felines come");
        }
        numFelines++;
        felines.release();
        feedingLot.acquire();
        //eat
        println("feline eating");
        feedingLot.release();
        felines.acquire();
        if(numFelines == 1){
            access.release();
            println("felines go");
        }
        numFelines--;
        felines.release();
    }
}

20.times {
    Thread.start { //Mice
        mice.acquire();
        if(numMice == 0){
            access.acquire();
            println("mice come");
        }
        numMice++;
        mice.release();
        feedingLot.acquire();
        //eat
         println("mouse eating");
        feedingLot.release();
        mice.acquire();
        if(numMice == 1){
            access.release();
            println("mice go");
        }
        numMice--;
        mice.release();
    }
}



