package bookstore.action;

import bookstore.model.Order;
import bookstore.model.User;
import bookstore.model.result.FailureMessage;
import bookstore.service.AppService;
import bookstore.util.StringUtil;
import bookstore.util.Validator;

public class AdminOrderAction extends BaseAction {

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
    
    public String allOrdersView() {
        User user = (User) session().getAttribute("user");
        if (user == null)
            return LOGIN;
        if (!user.isAdmin())
            return "forbidden";
        
        setPageTitle("网上书店管理系统 - 订单查询");
        setViewProfile();
        return SUCCESS;
    }
    
    public String getAllOrders(){
        User user = (User) session().getAttribute("user");
        if (user == null) {
            retJson = new FailureMessage("请先登录");
            return LOGIN;
        }
        if (!user.isAdmin()) {
            retJson = new FailureMessage("禁止访问");
            return "forbidden";
        }
        
        retJson = appService.getAllOrders();
        return SUCCESS;
    }
    
    public String getOrderDetail() {
        User user = (User) session().getAttribute("user");
        if (user == null) {
            retJson = new FailureMessage("请先登录");
            return LOGIN;
        }
        if (!user.isAdmin()) {
            retJson = new FailureMessage("禁止访问");
            return "forbidden";
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
        
        retJson = appService.getOrderItemsByOrder(order, true);
        return SUCCESS;
    }
}
