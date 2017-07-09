package bookstore.action;

import bookstore.model.Book;
import bookstore.model.BookCategory;
import bookstore.model.Category;
import bookstore.model.User;
import bookstore.model.result.FailureMessage;
import bookstore.model.result.SuccessMessage;
import bookstore.service.AppService;
import bookstore.util.StringUtil;
import bookstore.util.Validator;

public class AdminCategoryAction extends BaseAction {
    
    private static final long serialVersionUID = 1L;
    
    private String id;
    private String bookId;
    private String name;
    
    private Object retJson;
    
    private AppService appService;
    
    // Getters and setters
    
    public String getId() {
        return StringUtil.replaceNull(id);
    }

    public void setId(String id) {
        this.id = StringUtil.replaceNullAndTrim(id);
    }
    
    public String getBookId() {
        return StringUtil.replaceNull(bookId);
    }

    public void setBookId(String bookId) {
        this.bookId = StringUtil.replaceNullAndTrim(bookId);
    }
    
    public String getName() {
        return StringUtil.replaceNull(name);
    }

    public void setName(String name) {
        this.name = StringUtil.replaceNullAndTrim(name);
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

    public String allCategoriesView() {
        User user = (User) session().getAttribute("user");
        if (user == null)
            return LOGIN;
        if (!user.isAdmin())
            return "forbidden";
        
        setPageTitle("网上书店管理系统 - 分类管理");
        setViewProfile();
        return SUCCESS;
    }
    
    public String getAllCategories() {
        User user = (User) session().getAttribute("user");
        if (user == null) {
            retJson = new FailureMessage("请先登录");
            return LOGIN;
        }
        if (!user.isAdmin()) {
            retJson = new FailureMessage("禁止访问");
            return "forbidden";
        }
        
        retJson = appService.getAllCategories(true);
        return SUCCESS;
    }
    
    public String getCategoryDetail() {
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
        
        Category category = appService.getCategoryById(Integer.parseInt(getId()));
        if (category == null) {
            retJson = new FailureMessage("该分类编号不存在。");
            return NONE;
        }
        
        retJson = appService.getCategoryBooks(Integer.parseInt(getId()));
        return SUCCESS;
    }
    
    public String addCategory() {
        User user = (User) session().getAttribute("user");
        if (user == null) {
            retJson = new FailureMessage("请先登录");
            return LOGIN;
        }
        if (!user.isAdmin()) {
            retJson = new FailureMessage("禁止访问");
            return "forbidden";
        }
        
        Validator vd = new Validator(getName(), "分类名称");
        if (!vd.validateNotEmpty()) {
            retJson = vd.getFailureMessage();
            return ERROR;
        }
           
        Category category = new Category(getName());
        appService.addCategory(category);

        retJson = new SuccessMessage(category.getId());
        return SUCCESS;
    }
    
    public String updateCategory() {
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
        vd = new Validator(getName(), "分类名称");
        if (!vd.validateNotEmpty()) {
            retJson = vd.getFailureMessage();
            return ERROR;
        }

        Category category = appService.getCategoryById(Integer.parseInt(getId()));
        if (category == null) {
            retJson = new FailureMessage("该分类编号不存在。");
            return NONE;
        }
        
        category.setName(getName());
        appService.updateCategory(category);
        
        retJson = new SuccessMessage();
        return SUCCESS;
    }
    
    public String deleteCategory() {
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
        
        Category category = appService.getCategoryById(Integer.parseInt(getId()));
        if (category == null) {
            retJson = new FailureMessage("该分类编号不存在。");
            return NONE;
        }
        
        appService.deleteCategory(category);
        
        retJson = new SuccessMessage();
        return SUCCESS;
    }
    
    public String addBookToCategory() {
        User user = (User) session().getAttribute("user");
        if (user == null) {
            retJson = new FailureMessage("请先登录");
            return LOGIN;
        }
        if (!user.isAdmin()) {
            retJson = new FailureMessage("禁止访问");
            return "forbidden";
        }
        
        Validator vd = new Validator(getId(), "分类编号");
        if (!vd.validateNotEmpty() || !vd.validatePositiveInt()) {
            retJson = vd.getFailureMessage();
            return ERROR;
        }
        vd = new Validator(getBookId(), "书籍编号");
        if (!vd.validateNotEmpty() || !vd.validatePositiveInt()) {
            retJson = vd.getFailureMessage();
            return ERROR;
        }
        
        Category category = appService.getCategoryById(Integer.parseInt(getId()));
        if (category == null) {
            retJson = new FailureMessage("该分类编号不存在。");
            return NONE;
        }
        
        Book book = appService.getBookById(Integer.parseInt(getBookId()));
        if (book == null) {
            retJson = new FailureMessage("该书籍编号不存在。");
            return NONE;
        }
        
        BookCategory bc = appService.findBC(category.getId(), book.getId());
        if (bc != null) {
            retJson = new FailureMessage("该书籍已经属于该分类。");
            return ERROR;
        }
        
        bc = new BookCategory(category.getId(), book.getId());
        appService.addBC(bc);
        
        retJson = new SuccessMessage();
        return SUCCESS;
    }
    
    public String deleteBookFromCategory() {
        User user = (User) session().getAttribute("user");
        if (user == null) {
            retJson = new FailureMessage("请先登录");
            return LOGIN;
        }
        if (!user.isAdmin()) {
            retJson = new FailureMessage("禁止访问");
            return "forbidden";
        }
        
        Validator vd = new Validator(getId(), "关联编号");
        if (!vd.validateNotEmpty() || !vd.validatePositiveInt()) {
            retJson = vd.getFailureMessage();
            return ERROR;
        }
        
        BookCategory bc = appService.getBCById(Integer.parseInt(getId()));
        if (bc == null) {
            retJson = new FailureMessage("该关联编号不存在。");
            return NONE;
        }
        
        appService.deleteBC(bc);
        
        retJson = new SuccessMessage();
        return SUCCESS;
    }
    
}
