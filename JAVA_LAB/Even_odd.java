
import java.util.*;

class Even_odd {
    public static void main(String args[]) {
        int n;
        Scanner s = new Scanner(System.in);

        System.out.print("Enter a number: ");
        n = s.nextInt();

        switch (n % 2) {
            case 0:
                System.out.println("This number is even");
                break;

            default:
                System.out.println("This number is odd");
        }

        s.close();
    }
}