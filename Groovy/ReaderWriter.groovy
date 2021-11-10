//Readers can read alongside other readers
//If a writer wants to write, no other writers OR readers
    //can be inside the crit section

Semaphore resource = new Semaphore(1);
Semaphore readers = new Semaphore(1);
Semaphore accessProtocol = new Semaphore(1);
int numReaders = 0;

W.times{
    Thread.start{ //Writer
        accessProtocol.acquire();
        resource.acquire(); //entry protocol
        accessProtocol.release();
        // write(resource)
        resource.release();
    }
}

R.times{
    Thread.start{ //Reader
        accessProtocol.acquire();
        //reader entry protocol -- now two readers cant say
            //hey! im the first reader
        readers.acquire();
        //Am i the first reader to read?
        if(numReaders == 0){
            resource.acquire();
        }
        numReaders++;
        readers.release();
        accessProtocol.release();
        // CRITICAL SECTION
        // read(resource)
        //reader exit protocol -- protect decrement as well
            //now last n readers cant say hey! im not last
            //and then decrement 
        readers.acquire();
        if(numReaders == 1){
            resource.release();
        }
        nr--;
        readers.release();
    }
}