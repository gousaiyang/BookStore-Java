package bookstore.util;

import com.google.gson.Gson;

public class FailureMessage {
	@SuppressWarnings("unused")
	private String result = "failed";
	@SuppressWarnings("unused")
	private String msg;
	
	public FailureMessage(String msg) {
		this.msg = msg;
	}
	
	public String toJson() {
		Gson gson = new Gson();
		return gson.toJson(this);
	}
}
