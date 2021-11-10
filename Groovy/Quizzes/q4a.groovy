/*
Quiz 4A - 6 Oct 2021
Aughdon Breslin & Jason Rossi
 */
import java.util.concurrent.Semaphore;

Semaphore station0 = new Semaphore(1);
Semaphore station1 = new Semaphore(1);
Semaphore station2 = new Semaphore(1);
List<Semaphore> permToProcess = [new Semaphore(0), new Semaphore(0), new Semaphore(0)] // list of semaphores for machines
List<Semaphore> doneProcessing =[new Semaphore(0), new Semaphore(0), new Semaphore(0)] // list of semaphores for machines

100.times {
    Thread.start { // Car
        // Go to station 0
        station0.acquire() // Car comes in 
        println("Car comes into station 0")

        permToProcess[0].release() // give machine perm to start
        doneProcessing[0].acquire() // wait for machine to say its finished

        // Move on to station 1
        station1.acquire(); // Car comes in 
        println("Car comes into station 1")
        println("Car exits station 0")
        station0.release(); // Car exits

        permToProcess[1].release(); //give machine perm to start
        doneProcessing[1].acquire(); // wait for machine to say its finished
        
        // Move on to station 2
        station2.acquire(); // Car comes in 
        println("Car comes into station 2")
        println("Car exits station 1")
        station1.release(); // Car exits

        permToProcess[2].release(); //give machine perm to start
        doneProcessing[2].acquire(); // wait for machine to say its finished
        println("Car exits station 2")
        station2.release(); // Car exits
        

      }
}

3.times { 
    int id = it; // iteration variable
    Thread.start { // Machine at station id
        while (true) {
            // Wait for car to arrive
	    permToProcess[id].acquire();
            // Process car when it has arrived
	    doneProcessing[id].release();
            }
    }
} 

return;
