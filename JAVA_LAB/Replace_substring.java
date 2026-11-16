
import java.util.*;

public class Replace_substring {
    public static void main(String args[]) {
        String a, e;

        Scanner sc = new Scanner(System.in);

        System.out.println("Enter the original string:");
        String s1 = sc.nextLine();

        System.out.println("Enter the text to replace:");
        a = sc.next();

        System.out.println("Enter the replacement text:");
        e = sc.next();

        String replaceString = s1.replace(a, e);

        System.out.println("Modified string: " + replaceString);

        sc.close();
    }
}