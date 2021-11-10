import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Customer implements Runnable {
    private Bakery bakery;
    private Random rnd;
    private List<BreadType> shoppingCart;
    private int shopTime;
    private int checkoutTime;

    /**
     * Initialize a customer object and randomize its shopping cart
     */
    public Customer(Bakery bakery) {
        // TOD
        this.bakery = bakery;
        this.rnd = new Random();
        this.shoppingCart = new ArrayList<BreadType>();
        fillShoppingCart();
        shopTime = rnd.nextInt(4);
        checkoutTime = rnd.nextInt(4);
    }

    /**
     * Run tasks for the customer
     */
    public void run() {
        // The Customer
        System.out.println(this.toString()+ " started shopping.");

        // TODo Have them do their shopping in here
        for(BreadType bread : shoppingCart){
            // stand in front of stock
            try {
                bakery.grabBread.acquire();
            } catch(InterruptedException e) {};

            // grab a piece of bread
            bakery.takeBread(bread);
            System.out.println("Customer " +hashCode()+ " grabbed a piece of bread.");

            //take time to grab bread
            try {
                Thread.sleep(shopTime); 
            } catch (InterruptedException e) {};

            // leave specific bread stock
            bakery.grabBread.release();
        }
               

        try { // go to checkout
            bakery.gotoCashier.acquire();
        } catch(InterruptedException e) {};
        System.out.println("Customer " +hashCode()+ " went to check out.");

            // Once inside checkout, have cashier add sales to total amount
            try {
                bakery.totalMoney.acquire();
            } catch(InterruptedException e) {};
                bakery.addSales(getItemsValue());

            bakery.totalMoney.release(); // Allow other cashiers to total the money from their sales
            System.out.println("Customer " +hashCode()+ " checked out successfully.");

            //take time to check out
            try {
                Thread.sleep(checkoutTime); 
            } catch (InterruptedException e) {};
        bakery.gotoCashier.release(); // leave checkout
    }

    /**
     * Return a string representation of the customer
     */
    public String toString() {
        return "Customer " + hashCode() + ": shoppingCart=" + Arrays.toString(shoppingCart.toArray()) + ", shopTime=" + shopTime + ", checkoutTime=" + checkoutTime;
    }

    /**
     * Add a bread item to the customer's shopping cart
     */
    private boolean addItem(BreadType bread) {
        // do not allow more than 3 items, chooseItems() does not call more than 3 times
        if (shoppingCart.size() >= 3) {
            return false;
        }
        shoppingCart.add(bread);
        return true;
    }

    /**
     * Fill the customer's shopping cart with 1 to 3 random breads
     */
    private void fillShoppingCart() {
        int itemCnt = 1 + rnd.nextInt(3);
        while (itemCnt > 0) {
            addItem(BreadType.values()[rnd.nextInt(BreadType.values().length)]);
            itemCnt--;
        }
    }

    /**
     * Calculate the total value of the items in the customer's shopping cart
     */
    private float getItemsValue() {
        float value = 0;
        for (BreadType bread : shoppingCart) {
            value += bread.getPrice();
        }
        return value;
    }
}