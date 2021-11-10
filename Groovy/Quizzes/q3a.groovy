
/*
Quiz 3A - 29 Sep 2021

You may not add print statements nor additional semaphores.
Add ONLY acquire and release operations to the following code so that the output is:

aabaabaab....

*/

import java.util.concurrent.Semaphore;
Semaphore a = new Semaphore(2);
Semaphore b = new Semaphore(0);


//Aughdon Breslin & Jason Rossi
Thread.start {
    while (true) {
          a.acquire();
	print("a");
	b.release();
    }
}

Thread.start {

    while (true) {
          b.acquire();
          b.acquire();
	print("b");
	a.release();
	a.release();
    }
}