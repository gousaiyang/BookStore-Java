package bookstore.action;

import bookstore.model.Category;
import bookstore.model.result.BookDetail;
import bookstore.model.result.FailureMessage;
import bookstore.service.AppService;
import bookstore.util.StringUtil;
import bookstore.util.Validator;

public class HomeAction extends BaseAction {
    
    private static final long serialVersionUID = 1L;
    
    private String id;
    private String category;
    private String keyword;
    
    private Object retJson;
    
    private AppService appService;
    
    // Getters and setters

    public String getId() {
        return StringUtil.replaceNull(id);
    }

    public void setId(String id) {
        this.id = StringUtil.replaceNullAndTrim(id);
    }

    public String getCategory() {
        return StringUtil.replaceNull(category);
    }

    public void setCategory(String category) {
        this.category = StringUtil.replaceNullAndTrim(category);
    }

    public String getKeyword() {
        return StringUtil.replaceNull(keyword);
    }

    public void setKeyword(String keyword) {
        this.keyword = StringUtil.replaceNullAndTrim(keyword);
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
    
    public String homeView() {
        setPageTitle("欢迎来到网上书店");
        setViewProfile();
        request().setAttribute("categories", appService.getAllCategories(false));
        return SUCCESS;
    }
    
    public String getAllBooks() {
        retJson = appService.getAllBooks(false);
        return SUCCESS;
    }
    
    public String searchBooks() {
        Validator vd = new Validator(getCategory(), "分类");
        if (!vd.validateNotEmpty() || !vd.validateNonNegativeInt()) {
            retJson = vd.getFailureMessage();
            return ERROR;
        }
        
        int categoryId = Integer.parseInt(getCategory());
        if (categoryId > 0) {
            Category category = appService.getCategoryById(categoryId);
            if (category == null) {
                retJson = new FailureMessage("该分类编号不存在。");
                return NONE;
            }
        }
        
        retJson = appService.searchBooks(categoryId, getKeyword());
        return SUCCESS;
    }
    
    public String getBookDetail() {
        Validator vd = new Validator(getId(), "编号");
        if (!vd.validateNotEmpty() || !vd.validatePositiveInt()) {
            retJson = vd.getFailureMessage();
            return ERROR;
        }
        
        BookDetail bookDetail = appService.getBookDetailById(Integer.parseInt(getId()), false);
        if (bookDetail == null) {
            retJson = new FailureMessage("该书籍编号不存在。");
            return NONE;
        }
        
        retJson = bookDetail;
        return SUCCESS;
    }

}
