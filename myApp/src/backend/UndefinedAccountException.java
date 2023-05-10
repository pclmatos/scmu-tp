package backend;

public class UndefinedAccountException extends RuntimeException  {

    public UndefinedAccountException() {
        super("Name not defined as account name.");
    }
}
