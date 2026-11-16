
/*
AIM:
To write a Java program to read and display the contents
of a text file using the FileReader class.

ALGORITHM:
1. Start the program.
2. Create a FileReader object to open "sample2.txt".
3. Read the file character by character using the read() method.
4. Continue reading until read() returns -1, indicating
   the end of the file.
5. Convert each character value into a character and display it.
6. Close the file using the close() method.
7. Handle any exceptions using the catch block.
8. Stop the program.
*/

import java.io.*;

public class File_reader {
    public static void main(String[] args) {
        try {
            FileReader fr = new FileReader("sample2.txt");
            int i;

            while ((i = fr.read()) != -1) {
                System.out.println((char) i);
            }

            fr.close();
        } catch (Exception e) {
            System.out.println("Exception: " + e);
        }
    }
}

/*
SAMPLE OUTPUT:

If sample2.txt contains:
Hello Java
Welcome to File Handling

The output will be:
H
e
l
l
o

J
a
v
a

W
e
l
c
o
m
e

t
o

F
i
l
e

H
a
n
d
l
i
n
g

NOTE:
Each character is displayed on a separate line because
System.out.println() is used inside the loop.

RESULT:
Thus, the Java program to read and display the contents
of a text file using the FileReader class was implemented
and executed successfully.
*/