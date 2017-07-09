package bookstore.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Pattern;

import bookstore.model.result.FailureMessage;

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
        if (!Pattern.matches("^\\d+$", value) || Integer.parseInt(value) == 0) {
            msg = new FailureMessage(name + " 必须是一个正整数。");
            return false;
        }
        
        return true;
    }
    
    public boolean validateNonNegativeInt() {
        if (!Pattern.matches("^\\d+$", value)) {
            msg = new FailureMessage(name + " 必须是一个非负整数。");
            return false;
        }
        
        return true;
    }
    
    public boolean validateDate() {
        if (!Pattern.matches("^\\d{4}-\\d{1,2}-\\d{1,2}$", value)) {
            msg = new FailureMessage(name + " 不是一个有效的日期。");
            return false;
        }
        
        try {
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            df.setLenient(false);
            Date date = df.parse(value);
            if (date.before(df.parse("1970-01-02")) || date.after(df.parse("2038-01-18"))) {
                msg = new FailureMessage(name + " 超出可表示的日期范围。");
                return false;
            }
        } catch (ParseException e) {
            msg = new FailureMessage(name + " 不是一个有效的日期。");
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
