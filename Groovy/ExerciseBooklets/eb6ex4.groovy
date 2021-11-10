/*
 Quiz 5A - 15 Oct 2021

 Name1: Aughdon Breslin
 Name2: Jason Rossi
 Pledge: I pledge my honor that I have abided by the Stevens Honor System.

 */
import java.util.concurrent.locks.*;

// declarations
class TrainStation {
    int ntc=0; // for printing state
    int stc=0; // for printing state

    boolean nt=false;
    boolean st=false;

    // declare locks and condition variables
	Lock lock = new ReentrantLock();
	Condition northTrack = lock.newCondition();
	Condition southTrack = lock.newCondition();

    
    void acquireNorthTrackP() {
		lock.lock();
		try {
			// complete
			while(nt){
				northTrack.await();
			}
			nt = true;
			ntc++;
			println ("pass north")
			printState();
		} finally {
			lock.unlock();
			}
    }

    void releaseNorthTrackP() {
		lock.lock();
		try {
			// complete
			nt = false;
        	northTrack.signal();
			ntc--;
			println ("north hops off")
			printState();
		} finally {
			lock.unlock();
        }
    }

    void acquireSouthTrackP() {
		lock.lock();
		try {
			// complete
			while(st){
				southTrack.await();
			}
			st = true;
			stc++;
			println ("pass south")
			printState();

		} finally {
			lock.unlock();
    	}
    }

    void releaseSouthTrackP() {
		lock.lock();
		try {
			// complete
			st = false;
			southTrack.signal();
			stc--;
			println ("south hops off")
			printState();
		} finally {
			lock.unlock();
        }
    }

    void acquireTracksF() {
		lock.lock();
		try {
			// complete
			while(nt){
				northTrack.await();
			}
			nt = true;
			while(st){
				southTrack.await();
			}
			st = true;
			ntc++;
			stc++;
			println ("freight")
			printState();
		} finally {
			lock.unlock();
        }
    }

    void releaseTracksF() {
		lock.lock();
		try {
			// complete
			nt = false;
			northTrack.signal();
			st = false;
			southTrack.signal();
			ntc--;
			stc--;
			println ("freight hops off")
			printState();
		} finally {
			lock.unlock();
        }
    }

    void printState() {
		lock.lock();
		try {
			println "ntc: "+ntc+", stc: "+stc;	    
		} finally {
            lock.unlock();
        }
    }
}

TrainStation s = new TrainStation();


10.times {
    int id = it;
    Thread.start { // Freight Train going in any direction
	s.acquireTracksF();
	s.releaseTracksF()
    }
}

100.times{
    int id = it;
    Thread.start { // Passenger Train going North
	s.acquireNorthTrackP();
	s.releaseNorthTrackP()
    }
}

100.times{
    int id = it;
    Thread.start { // Passenger Train going South
	s.acquireSouthTrackP();
	s.releaseSouthTrackP()
    }
}

