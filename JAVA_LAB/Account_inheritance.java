
class Account {
    int accountNumber, balance;

    Account(int accountNumber, int balance) {
        this.accountNumber = accountNumber;
        this.balance = balance;
    }

    void credit(int amount) {
        balance = balance + amount;
    }

    void debit(int amount) {
        balance = balance - amount;
    }

    void displayBalance() {
        System.out.println("Balance = " + balance);
    }
}

class SBAccount extends Account {
    double rate;

    SBAccount(int accountNumber, int balance, double rate) {
        super(accountNumber, balance);
        this.rate = rate;
    }

    void displayInterestRate() {
        System.out.println("Interest Rate = " + rate);
    }
}

public class Account_inheritance {
    public static void main(String[] args) {
        SBAccount obj1 = new SBAccount(1001, 5000, 6.5);

        obj1.credit(2000);
        obj1.debit(1000);

        obj1.displayBalance();
        obj1.displayInterestRate();
    }
}