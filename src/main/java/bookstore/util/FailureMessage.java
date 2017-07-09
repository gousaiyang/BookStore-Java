package bookstore.util;

public class FailureMessage {
	
	private String result = "failed";
	private String msg;
	
	public FailureMessage(String msg) {
		this.msg = msg;
	}
	
	public String getResult() {
		return result;
	}
	
	public void SetResult(String result) {
		this.result = result;
	}
	
	public String getMsg() {
		return msg;
	}
	
	public void setMsg(String msg) {
		this.msg = msg;
	}
}
