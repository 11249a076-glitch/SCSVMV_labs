
/*
AIM:
To write a Java program to write characters from A to Z
into a text file using the FileWriter class.

ALGORITHM:
1. Start the program.
2. Create a FileWriter object to open "sample2.txt".
3. Initialize a character variable i with ASCII value 65 (A).
4. Repeat the loop while i is less than 91.
5. Write each character into the file using the write() method.
6. Close the file using the close() method.
7. Handle any exceptions using the catch block.
8. Stop the program.
*/

import java.io.*;

public class File_writer
{
public static void main(String[] args)
{
try
{
// Open the file for writing
FileWriter fw = new FileWriter("sample2.txt");

        // Write uppercase alphabets from A to Z
        for (char i = 'A'; i <= 'Z'; i++)
        {
            fw.write(i);
        }

        // Close the file
        fw.close();

        // Display success message
        System.out.println("Data written successfully.");
    }
    catch (IOException e)
    {
        // Handle file-related exceptions
        System.out.println("Exception: " + e.getMessage());
    }
}


}

/*
SAMPLE OUTPUT:

Data written successfully to sample2.txt

CONTENTS OF sample2.txt:
ABCDEFGHIJKLMNOPQRSTUVWXYZ

RESULT:
Thus, the Java program to write characters from A to Z
into a text file using the FileWriter class was
implemented and executed successfully.
*/