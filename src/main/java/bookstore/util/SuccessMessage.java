package bookstore.util;

public class SuccessMessage {
	private String result = "success";
	private Object param;
	
	public SuccessMessage() {}
	
	public SuccessMessage(Object param) {
		this.param = param;
	}
	
	public String getResult() {
		return result;
	}
	
	public void setResult(String result) {
		this.result = result;
	}
	
	public Object getParam() {
		return param;
	}
	
	public void setParam(Object param) {
		this.param = param;
	}
}
