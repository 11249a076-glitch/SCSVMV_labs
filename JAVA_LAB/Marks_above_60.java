
import java.util.Scanner;

public class Marks_above_60 {
    public static void main(String args[]) {
        int marks[] = new int[6];
        int i;
        String name[] = new String[6];

        Scanner scanner = new Scanner(System.in);

        for (i = 0; i < 6; i++) {
            System.out.print("Enter Name of Student and Marks of Subject " + (i + 1) + ": ");
            name[i] = scanner.next();
            marks[i] = scanner.nextInt();
        }

        System.out.println("Students who scored 60 or above:");

        for (i = 0; i < 6; i++) {
            if (marks[i] >= 60) {
                System.out.println(name[i] + " " + marks[i]);
            }
        }

        scanner.close();
    }
}