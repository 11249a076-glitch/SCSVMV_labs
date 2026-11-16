
import java.util.Scanner;

public class Fibonacci_series {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);

        System.out.print("Enter the value of n: ");
        int n = s.nextInt();

        if (n <= 0) {
            System.out.println("Please enter a positive number.");
        } else {
            fibonacci(n);
        }

        s.close();
    }

    public static void fibonacci(int n) {
        int a = 0;
        int b = 1;

        for (int i = 0; i < n; i++) {
            System.out.print(a + " ");
            int nextNumber = a + b;
            a = b;
            b = nextNumber;
        }

        System.out.println();
    }
}