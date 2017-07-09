package bookstore.action;

import bookstore.model.Order;
import bookstore.model.User;
import bookstore.service.AppService;
import bookstore.util.FailureMessage;
import bookstore.util.StringUtil;
import bookstore.util.SuccessMessage;
import bookstore.util.Validator;

public class OrderAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	
	private String id;
	
	private Object retJson;
	
	private AppService appService;
	
	// Getters and setters
	
	public String getId() {
		return StringUtil.replaceNull(id);
	}

	public void setId(String id) {
		this.id = StringUtil.replaceNullAndTrim(id);
	}
	
	public Object getRetJson() {
		return retJson;
	}

	public void setRetJson(Object retJson) {
		this.retJson = retJson;
	}

	public AppService getAppService() {
		return appService;
	}

	public void setAppService(AppService appService) {
		this.appService = appService;
	}
	
	
	// Actions
	
	public String ordersView() {
		if (session().getAttribute("user") == null) {
			return LOGIN;
		}
		
		setPageTitle("我的历史订单");
		setViewProfile();
		return SUCCESS;
	}
	
	public String getAllOrders() {
		User user = (User) session().getAttribute("user");
		if (user == null) {
			retJson = new FailureMessage("请先登录");
			return LOGIN;
		}
		
		retJson = appService.getUserOrders(user.getId());
		return SUCCESS;
	}
	
	public String getOrderDetail() {
		User user = (User) session().getAttribute("user");
		if (user == null) {
			retJson = new FailureMessage("请先登录");
			return LOGIN;
		}
		
		Validator vd = new Validator(getId(), "编号");
		if (!vd.validateNotEmpty() || !vd.validatePositiveInt()) {
			retJson = vd.getFailureMessage();
			return ERROR;
		}
		
		Order order = appService.getOrderById(Integer.parseInt(getId()));
		if (order == null) {
			retJson = new FailureMessage("该订单编号不存在。");
			return NONE;
		}
		
		if (order.getUserId() != user.getId()) {
			retJson = new FailureMessage("禁止访问非本人的订单。");
			return "forbidden";
		}
		
		if (order.getId() == appService.getUserCart(user.getId()).getId()) {
			retJson = new FailureMessage("禁止的操作。"); // Cannot get cart detail by this API.
			return "forbidden";
		}
		
		retJson = appService.getOrderItemsByOrder(order, false);
		return SUCCESS;
	}
	
	public String deleteOrder() {
		User user = (User) session().getAttribute("user");
		if (user == null) {
			retJson = new FailureMessage("请先登录");
			return LOGIN;
		}
		
		Validator vd = new Validator(getId(), "编号");
		if (!vd.validateNotEmpty() || !vd.validatePositiveInt()) {
			retJson = vd.getFailureMessage();
			return ERROR;
		}
		
		Order order = appService.getOrderById(Integer.parseInt(getId()));
		if (order == null) {
			retJson = new FailureMessage("该订单编号不存在。");
			return NONE;
		}
		
		if (order.getUserId() != user.getId()) {
			retJson = new FailureMessage("禁止删除非本人的订单。");
			return "forbidden";
		}
		
		if (order.getId() == appService.getUserCart(user.getId()).getId()) {
			retJson = new FailureMessage("禁止的操作。"); // Cannot delete cart.
			return "forbidden";
		}
		
		appService.deleteOrder(order);
		retJson = new SuccessMessage();
		return SUCCESS;
	}
}
