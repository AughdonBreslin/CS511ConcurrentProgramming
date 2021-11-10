import java.util.concurrent.Semaphore;
// Semaphore declarations here:
Semaphore bed = new Semaphore(4);
Semaphore access = new Semaphore(1);
int beds = 4;
Semaphore mag = new Semaphore(10);

100.times{
    int id = it;
    Thread.start { // Donor
        
        Thread.start {
            // Role: Competing for beds
            bed.acquire();
            println(id+" got a bed")
            access.acquire();
                beds--;
            access.release();
            //donate
            bed.release();
            println(id+" left a bed")
            access.acquire();
                beds++;
            access.release();
        }
        
        Thread.start {
            // Role: Competing for magazines
            while(beds == 0) {
                mag.acquire();
                //read
                println(id+" read a mag")
                mag.release();
            }
        }
    }
}