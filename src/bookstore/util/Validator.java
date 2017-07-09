package bookstore.util;

import java.io.PrintWriter;
import java.util.regex.Pattern;

public class Validator {
	public boolean ValidateNotEmpty(String value, String name, PrintWriter out) {
		if (value.equals("")) {
            out.println(new FailureMessage(name + " 不能为空。").toJson());
            out.flush();
            out.close();
            return false;
        }
		return true;
	}
	
	public boolean ValidatePattern(String value, String pattern, String name, PrintWriter out) {
		if (!Pattern.matches(pattern, value)) {
            out.println(new FailureMessage(name + " 格式不正确。").toJson());
            out.flush();
            out.close();
            return false;
        }
		return true;
	}
	
	public boolean ValidatePatternEx(String value, String pattern, String customMessage, PrintWriter out) {
		if (!Pattern.matches(pattern, value)) {
            out.println(new FailureMessage(customMessage).toJson());
            out.flush();
            out.close();
            return false;
        }
		return true;
	}
}
