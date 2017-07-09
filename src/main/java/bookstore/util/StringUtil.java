package bookstore.util;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.ArrayUtils;

import com.google.gson.JsonArray;
import com.google.gson.JsonParser;

public class StringUtil {
    public static String likeEscapeCharacter = "`";
    
    public static String replaceNull(String s) {
        return s == null ? "" : s;
    }
    
    public static String replaceNullAndTrim(String s) {
        return s == null ? "" : s.trim();
    }
    
    public static String EscapeLike(String s) {
        String ret = '%' + s.replace(likeEscapeCharacter, likeEscapeCharacter + likeEscapeCharacter)
            .replace("%", likeEscapeCharacter + "%").replace("_", likeEscapeCharacter + "_") + '%';
        return ret;
    }
    
    public static String decodeUTF8(String s) {
        List<Byte> bytes = new ArrayList<Byte>();
        for (int i = 0; i < s.length(); ++i)
            bytes.add((byte)s.charAt(i));
        
        try {
            return new String(ArrayUtils.toPrimitive(bytes.toArray(new Byte[s.length()])), "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return s;
        }
    }
    
    public static List<String> JSONStringArrayParse(String jsonStr) {
        try {
            JsonArray jsonArray = (JsonArray) new JsonParser().parse(jsonStr);
            List<String> result = new ArrayList<String>();
            for (int i = 0; i < jsonArray.size(); ++i) {
                result.add(jsonArray.get(i).getAsString());
            }
            return result;
        } catch (Exception e) {
            return null;
        }
    }

}
