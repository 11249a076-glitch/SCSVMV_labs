
import java.util.Scanner;
public class Multiplication_table {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter the number: ");
        int no = sc.nextInt();

        for (int i = 1; i <= 5; i++) {
            System.out.println(no + " * " + i + " = " + (no * i));
        }
        sc.close();
    }
}