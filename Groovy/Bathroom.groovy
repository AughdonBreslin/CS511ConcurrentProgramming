import java.util.concurrent.Semaphore;
Semaphore bathroom = new Semaphore(1);
Semaphore men = new Semaphore(1);
Semaphore women = new Semaphore(1);
numMen = 0;
numWomen = 0;

Thread.start { //men
    while (true) {
        men.acquire();
        if(numMen == 0) {
            bathroom.acquire();
        }
        numMen++;
        men.release();
        //enter bathroom
        println ("guy using bathroom");
        men.acquire();
        if(numMen == 1) {
            bathroom.release();
        }
        numMen--;
        men.release();
    }
}

Thread.start { //women
    while (true) {
        women.acquire();
        if(numWomen == 0) {
            bathroom.acquire();
        }
        numWomen++;
        women.release();
        //enter bathroom
        println ("girl using bathroom");
        women.acquire();
        if(numWomen == 1) {
            bathroom.release();
        }
        numWomen--;
        women.release();
    }
}