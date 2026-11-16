import java.util.Scanner;

interface Shape {
    final float pi = 3.14f;
    float area(int r);
}

interface CylinderShape {
    final float pie = 3.14f;
    float volume(int r, int h);
}

class Cylinder implements CylinderShape {
    public float volume(int r, int h) {
        return pie * r * r * h;
    }
}

class Sphere implements Shape {
    public float area(int r) {
        return 4 * pi * r * r;
    }
}

public class Cylinder_Sphere_interface {
    public static void main(String[] args) {
        int r, h;
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter radius and height: ");
        r = sc.nextInt();
        h = sc.nextInt();

        Cylinder c1 = new Cylinder();
        Sphere s1 = new Sphere();

        System.out.println("Volume of Cylinder: " + c1.volume(r, h));
        System.out.println("Surface Area of Sphere: " + s1.area(r));

        sc.close();
    }
}