
/*
AIM:
To write a Java program to demonstrate thread priorities
using the setPriority(), getPriority(), MAX_PRIORITY,
and MIN_PRIORITY methods.

ALGORITHM:
1. Start the program.
2. Create three thread classes A, B, and C by extending Thread.
3. Override the run() method in each class.
4. Create objects threadA, threadB, and threadC.
5. Set threadC to maximum priority using MAX_PRIORITY.
6. Set threadB to one priority level higher than threadA's
   default priority using getPriority() + 1.
7. Set threadA to minimum priority using MIN_PRIORITY.
8. Start all three threads using the start() method.
9. Display the messages and numbers printed by each thread.
10. Stop the program.

*/

class A extends Thread {
    public void run() {
        System.out.println("Thread A started");

        for (int i = 1; i <= 4; i++) {
            System.out.println("from thread A i=" + i);
        }

        System.out.println("exit from A");
    }
}

class B extends Thread {
    public void run() {
        System.out.println("Thread B started");

        for (int j = 1; j <= 4; j++) {
            System.out.println("from thread B j=" + j);
        }

        System.out.println("exit from B");
    }
}

class C extends Thread {
    public void run() {
        System.out.println("thread C started");

        for (int k = 1; k <= 4; k++) {
            System.out.println("thread c =" + k);
        }

        System.out.println("exit from c");
    }
}

public class Thread_priority {
    public static void main(String[] args) {
        A threadA = new A();
        B threadB = new B();
        C threadC = new C();

        threadC.setPriority(Thread.MAX_PRIORITY);
        threadB.setPriority(threadA.getPriority() + 1);
        threadA.setPriority(Thread.MIN_PRIORITY);

        System.out.println("start thread A");
        threadA.start();

        System.out.println("start thread B");
        threadB.start();

        System.out.println("start thread C");
        threadC.start();

        System.out.println("end of main thread");
    }
}

/*
SAMPLE OUTPUT (one possible execution):

start thread A
start thread B
start thread C
Thread A started
end of main thread
Thread B started
thread C started
thread c =1
thread c =2
thread c =3
thread c =4
exit from c
from thread A i=1
from thread A i=2
from thread A i=3
from thread A i=4
exit from A
from thread B j=1
from thread B j=2
from thread B j=3
from thread B j=4
exit from B

RESULT:
Thus, the Java program to demonstrate thread priorities
using setPriority() and getPriority() was implemented
and executed successfully.
*/