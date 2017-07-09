package bookstore.util;

import java.util.regex.Pattern;

public class Validator {
	private String value;
	private String name;
	private FailureMessage msg;
	
	public Validator(String value, String name) {
		this.value = value;
		this.name = name;
	}
	
	public boolean validateNotEmpty() {
		if (value == null || value.equals("")) {
			msg = new FailureMessage(name + " 不能为空。");
			return false;
		}
		
		return true;
	}
	
	public boolean validatePositiveInt() {
		if (!Pattern.matches("^\\d+$", value)) {
			msg = new FailureMessage(name + " 必须是一个正整数。");
			return false;
		}
		
		return true;
	}
	
	public boolean validatePattern(String pattern) {
		if (!Pattern.matches(pattern, value)) {
			msg = new FailureMessage(name + " 格式不正确。");
			return false;
		}
		
		return true;
	}
	
	public boolean validatePattern(String pattern, String customMessage) {
		if (!Pattern.matches(pattern, value)) {
			msg = new FailureMessage(customMessage);
			return false;
		}
		
		return true;
	}
	
	public FailureMessage getFailureMessage() {
		return msg;
	}
}
