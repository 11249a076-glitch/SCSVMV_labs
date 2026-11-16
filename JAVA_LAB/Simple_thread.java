
/*
AIM:
To write a Java program to demonstrate multithreading
using the Thread class, yield(), sleep(), and multiple threads.

ALGORITHM:
1. Start the program.
2. Create three thread classes A, B, and C by extending Thread.
3. Override the run() method in each thread class.
4. In thread A, print numbers from 1 to 5 and use yield()
   to allow other threads an opportunity to execute.
5. In thread B, print numbers from 1 to 5 and stop the loop
   when j equals 3.
6. In thread C, print numbers from 1 to 5 and pause execution
   for 1500 milliseconds when k equals 1.
7. In the main() method, create objects of A, B, and C.
8. Start all three threads using the start() method.
9. Display the output produced by the threads.
10. Stop the program.
*/

class A extends Thread {
    public void run() {
        for (int i = 1; i <= 5; i++) {
            if (i == 1) {
                Thread.yield();
            }
            System.out.println("from thread A i=" + i);
        }
        System.out.println("exit from A");
    }
}

class B extends Thread {
    public void run() {
        for (int j = 1; j <= 5; j++) {
            System.out.println("from thread B j=" + j);

            if (j == 3) {
                System.out.println("exit from B");
                break;
            }
        }
    }
}

class C extends Thread {
    public void run() {
        for (int k = 1; k <= 5; k++) {
            System.out.println("thread c =" + k);

            if (k == 1) {
                try {
                    Thread.sleep(1500);
                } catch (InterruptedException e) {
                    System.out.println("Thread C interrupted");
                    Thread.currentThread().interrupt();
                    return;
                }
            }
        }
        System.out.println("exit from C");
    }
}

public class Simple_thread {
    public static void main(String[] args) {
        A a = new A();
        B b = new B();
        C c = new C();

        System.out.println("Start thread A");

        a.start();
        b.start();
        c.start();

        System.out.println("exit from main thread");
    }
}


/*
SAMPLE OUTPUT:
Start thread A
exit from main thread
from thread A i=1
from thread A i=2
from thread A i=3
from thread A i=4
from thread A i=5
exit from A
from thread B j=1
from thread B j=2
from thread B j=3
exit from B
thread c =1
thread c =2
thread c =3
thread c =4
thread c =5
exit from C

RESULT:
Thus, the Java program to demonstrate multithreading using
the Thread class, yield(), and sleep() methods was executed.
*/