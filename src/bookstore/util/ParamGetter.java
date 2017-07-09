package bookstore.util;

import javax.servlet.http.HttpServletRequest;

public class ParamGetter {
	public String getTrimmedParam(HttpServletRequest request, String name) {
		String value = request.getParameter(name);
		if (value == null)
			return "";
		else
			return value.trim();
	}
	public String getParamStr(HttpServletRequest request, String name) {
		String value = request.getParameter(name);
		if (value == null)
			return "";
		else
			return value;
	}
}
