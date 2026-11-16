
class College {
    String collegeName, principalName;

    College(String collegeName, String principalName) {
        this.collegeName = collegeName;
        this.principalName = principalName;
    }

    void displayCollegeDetails() {
        System.out.println("College Name: " + collegeName);
        System.out.println("Principal Name: " + principalName);
    }
}

class Department extends College {
    String departmentName, HODName;

    Department(String collegeName, String principalName,
               String departmentName, String HODName) {
        super(collegeName, principalName);
        this.departmentName = departmentName;
        this.HODName = HODName;
    }

    void displayDepartmentDetails() {
        System.out.println("Department Name: " + departmentName);
        System.out.println("HOD Name: " + HODName);
    }
}

public class College_inheritance {
    public static void main(String[] args) {
        Department obj = new Department(
            "NIT", "B.K.Sinha", "Electronics", "B.C.Rai"
        );

        obj.displayCollegeDetails();
        obj.displayDepartmentDetails();
    }
}