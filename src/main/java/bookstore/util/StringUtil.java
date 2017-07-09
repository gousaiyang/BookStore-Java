package bookstore.util;

public class StringUtil {
	public static String replaceNull(String s) {
		return s == null ? "" : s;
	}
	
	public static String replaceNullAndTrim(String s) {
		return s == null ? "" : s.trim();
	}
}
