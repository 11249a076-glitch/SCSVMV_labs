
import java.util.Scanner;

class Binary_search {
    public static void main(String ar[]) {
        int i, mid, first, last, x, n, flag = 0;

        Scanner sc = new Scanner(System.in);

        System.out.println("Enter number of elements:");
        n = sc.nextInt();

        if (n <= 0) {
            System.out.println("Please enter a positive number.");
            sc.close();
            return;
        }

        int a[] = new int[n];

        System.out.println("Enter elements of array in ascending order:");
        for (i = 0; i < n; ++i) {
            a[i] = sc.nextInt();
        }

        System.out.println("Enter element to search:");
        x = sc.nextInt();

        first = 0;
        last = n - 1;

        while (first <= last) {
            mid = (first + last) / 2;

            if (a[mid] > x) {
                last = mid - 1;
            } else if (a[mid] < x) {
                first = mid + 1;
            } else {
                flag = 1;
                System.out.println("Element found");
                break;
            }
        }

        if (flag == 0) {
            System.out.println("Element not found");
        }

        sc.close();
    }
}