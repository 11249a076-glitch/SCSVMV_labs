
import java.util.Scanner;

public class Armstrong_number {
    public static void main(String args[]) {
        int n, nu, num = 0, rem;

        Scanner scan = new Scanner(System.in);

        System.out.print("Enter any Positive Number: ");
        n = scan.nextInt();

        if (n < 0) {
            System.out.println("Please enter a positive number.");
            scan.close();
            return;
        }

        nu = n;

        while (nu != 0) {
            rem = nu % 10;
            num = num + rem * rem * rem;
            nu = nu / 10;
        }

        if (num == n) {
            System.out.println("Armstrong Number");
        } else {
            System.out.println("Not an Armstrong Number");
        }

        scan.close();
    }
}