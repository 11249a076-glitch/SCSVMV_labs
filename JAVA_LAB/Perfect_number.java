
import java.util.Scanner;

public class Perfect_number {
    public static void main(String[] args) {
        int n, sum = 0;

        Scanner s = new Scanner(System.in);

        System.out.print("Enter any integer you want to check: ");
        n = s.nextInt();

        if (n <= 0) {
            System.out.println("Please enter a positive integer.");
            s.close();
            return;
        }

        for (int i = 1; i < n; i++) {
            if (n % i == 0) {
                sum = sum + i;
            }
        }

        if (sum == n) {
            System.out.println("Given number is Perfect");
        } else {
            System.out.println("Given number is not Perfect");
        }

        s.close();
    }
}