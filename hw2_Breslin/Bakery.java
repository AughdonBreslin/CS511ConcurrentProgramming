import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;


public class Bakery implements Runnable {
    private static final int TOTAL_CUSTOMERS = 200;
    private static final int ALLOWED_CUSTOMERS = 50;
    private static final int FULL_BREAD = 20;
    private Map<BreadType, Integer> availableBread;
    private ExecutorService executor;
    private float sales = 0;
    //initialize semaphores
    // to avoid two people grabbing final loaf of bread
    Semaphore grabBread = new Semaphore(1);
    // to only allow four people paying at once
    Semaphore gotoCashier = new Semaphore(4);
    // to only allow one person to add to total at once
    Semaphore totalMoney = new Semaphore(1);

    // TODO
    /**
     * Shared Resources:
     * Shelves, Cashiers, Sales, 
     * Bakery itself (rather than using a semaphore
     *   for upholding this requirement you are to use the maximum of 
     *   TOTAL_CUSTOMERS as the size of your thread pool.)
     */

    /**
     * Bakery should generate customers randomly and have them do their shopping.
     * Simulation should print out when a customer:
     *      starts shopping,
     *      takes an item from the stock,
     *      when it buys,
     *      and then when it finishes
     * After all customers finish shopping, the program should 
     *      print the total sales and then exit
     */


    /**
     * Remove a loaf from the available breads and restock if necessary
     */
    public void takeBread(BreadType bread) {
        int breadLeft = availableBread.get(bread);
        if (breadLeft > 0) {
            availableBread.put(bread, breadLeft - 1);
        } else {
            System.out.println("No " + bread.toString() + " bread left! Restocking...");
            // restock by preventing access to the bread stand for some time
            try {
                Thread.sleep(1000);
            } catch (InterruptedException ie) {
                ie.printStackTrace();
            }
            availableBread.put(bread, FULL_BREAD - 1);
        }
    }

    /**
     * Add to the total sales
     */
    public void addSales(float value) {
        sales += value;
    }

    /**
     * Run all customers in a fixed thread pool
     */
    public void run() {
        availableBread = new ConcurrentHashMap<BreadType, Integer>();
        availableBread.put(BreadType.RYE, FULL_BREAD);
        availableBread.put(BreadType.SOURDOUGH, FULL_BREAD);
        availableBread.put(BreadType.WONDER, FULL_BREAD);

        // TODO
        Thread[] bobWorld = new Thread[TOTAL_CUSTOMERS];
        executor = Executors.newFixedThreadPool(ALLOWED_CUSTOMERS);
        for(int i = 0; i < TOTAL_CUSTOMERS;i++){

            //Generate customers randomly
            Thread bob = new Thread(new Customer(this));
            bobWorld[i] = bob;
            bob.start();
            
            executor.execute(bob);
            System.out.println(i);
        }
        int count = 0;
        while(count != TOTAL_CUSTOMERS){
            for (Thread bob : bobWorld) {
                try {
                    bob.join();
                    count++;
                } catch (InterruptedException e) { System.out.println("error");}
            }
        }

        executor.shutdown();
        //Wait 10 seconds max to shut down
        try {
            executor.awaitTermination(10000, TimeUnit.MILLISECONDS);
        } catch (InterruptedException e) { System.out.println("Forced shutdown");};
        //Does** kick out
        System.out.println(sales);

        return;
        
    }
}