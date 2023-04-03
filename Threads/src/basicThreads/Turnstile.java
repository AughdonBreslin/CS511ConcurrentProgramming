package basicThreads;

public class Turnstile {
	
	private static int counter = 0;
	
	public static class ATurnsTile implements Runnable {
		private int threshold;
		
		public ATurnsTile(int threshold) {
			this.threshold = threshold;
		}
		
		public void run() {
			for (int i = 0; i < threshold; i++) {
				counter++;
			}
		}
	}
	
	public static void main(String[] args) {
		Thread t1 = new Thread(new ATurnsTile(10));
		Thread t2 = new Thread(new ATurnsTile(10));
		t1.start();
		t2.start();
		
		try {
			t1.join();
			t2.join();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		System.out.println(counter);
	}
}