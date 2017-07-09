package bookstore.util;

public class PasswordUtil {
    
    public static String passwordHash(String password) {
        return HashUtil.sha256(password);
    }
    
    public static boolean checkPassword(String password, String hash) {
        return passwordHash(password).equals(hash);
    }
}
