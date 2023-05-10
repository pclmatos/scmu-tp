package backend;

public class AuthenticationErrorException extends RuntimeException {

    public AuthenticationErrorException() {
        super("Password does not match.");
    }
    
}
