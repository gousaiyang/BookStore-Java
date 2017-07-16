package bookstore.action;

import bookstore.model.Book;
import bookstore.model.User;
import bookstore.model.result.BookDetail;
import bookstore.model.result.FailureMessage;
import bookstore.model.result.SuccessMessage;
import bookstore.service.AppService;
import bookstore.util.StringUtil;
import bookstore.util.Validator;

public class AdminBookAction extends BaseAction {
    
    private static final long serialVersionUID = 1L;
    
    private String id;
    private String name;
    private String image;
    private String author;
    private String press;
    private String price;
    private String stock;
    private String description;
    
    private Object retJson;
    
    private AppService appService;
    
    // Getters and setters
    
    public String getId() {
        return StringUtil.replaceNull(id);
    }

    public void setId(String id) {
        this.id = StringUtil.replaceNullAndTrim(id);
    }

    public String getName() {
        return StringUtil.replaceNull(name);
    }

    public void setName(String name) {
        this.name = StringUtil.replaceNullAndTrim(name);
    }

    public String getImage() {
        return StringUtil.replaceNull(image);
    }

    public void setImage(String image) {
        this.image = StringUtil.replaceNullAndTrim(image);
    }

    public String getAuthor() {
        return StringUtil.replaceNull(author);
    }

    public void setAuthor(String author) {
        this.author = StringUtil.replaceNullAndTrim(author);
    }

    public String getPress() {
        return StringUtil.replaceNull(press);
    }

    public void setPress(String press) {
        this.press = StringUtil.replaceNullAndTrim(press);
    }

    public String getPrice() {
        return StringUtil.replaceNull(price);
    }

    public void setPrice(String price) {
        this.price = StringUtil.replaceNullAndTrim(price);
    }

    public String getStock() {
        return StringUtil.replaceNull(stock);
    }

    public void setStock(String stock) {
        this.stock = StringUtil.replaceNullAndTrim(stock);
    }

    public String getDescription() {
        return StringUtil.replaceNull(description);
    }

    public void setDescription(String description) {
        this.description = StringUtil.replaceNullAndTrim(description);
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
    
    public String allBooksView() {
        User user = (User) session().getAttribute("user");
        if (user == null)
            return LOGIN;
        if (!user.isAdmin())
            return "forbidden";
        
        setPageTitle("网上书店管理系统 - 书籍管理");
        setViewProfile();
        return SUCCESS;
    }
    
    public String getAllBooks() {
        User user = (User) session().getAttribute("user");
        if (user == null) {
            retJson = new FailureMessage("请先登录");
            return LOGIN;
        }
        if (!user.isAdmin()) {
            retJson = new FailureMessage("禁止访问");
            return "forbidden";
        }
        
        retJson = appService.getAllBooks(true);
        return SUCCESS;
    }
    
    public String getBookDetail() {
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
        
        BookDetail bookDetail = appService.getBookDetailById(Integer.parseInt(getId()), true);
        if (bookDetail == null) {
            retJson = new FailureMessage("该书籍编号不存在。");
            return NONE;
        }
        
        retJson = bookDetail;
        return SUCCESS;
    }
    
    public String addBook() {
        User user = (User) session().getAttribute("user");
        if (user == null) {
            retJson = new FailureMessage("请先登录");
            return LOGIN;
        }
        if (!user.isAdmin()) {
            retJson = new FailureMessage("禁止访问");
            return "forbidden";
        }
        
        Validator vd = new Validator(getName(), "书名");
        if (!vd.validateNotEmpty()) {
            retJson = vd.getFailureMessage();
            return ERROR;
        }
        vd = new Validator(getPrice(), "单价");
        if (!vd.validateNotEmpty() || !vd.validatePattern("^[0-9]+(?:\\.[0-9]{1,2})?$")) {
            retJson = vd.getFailureMessage();
            return ERROR;
        }
        vd = new Validator(getStock(), "库存");
        if (!vd.validateNotEmpty() || !vd.validateNonNegativeInt()) {
            retJson = vd.getFailureMessage();
            return ERROR;
        }
        
        retJson = new SuccessMessage(appService.addBook(getName(), getImage(), getAuthor(), getPress(),
                getPrice(), getStock(), getDescription()));
        return SUCCESS;
    }
    
    public String updateBook() {
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
        vd = new Validator(getName(), "书名");
        if (!vd.validateNotEmpty()) {
            retJson = vd.getFailureMessage();
            return ERROR;
        }
        vd = new Validator(getPrice(), "单价");
        if (!vd.validateNotEmpty() || !vd.validatePattern("^[0-9]+(?:\\.[0-9]{1,2})?$")) {
            retJson = vd.getFailureMessage();
            return ERROR;
        }
        vd = new Validator(getStock(), "库存");
        if (!vd.validateNotEmpty() || !vd.validateNonNegativeInt()) {
            retJson = vd.getFailureMessage();
            return ERROR;
        }

        Book book = appService.getBookById(Integer.parseInt(getId()));
        if (book == null) {
            retJson = new FailureMessage("该书籍编号不存在。");
            return NONE;
        }
        
        appService.updateBook(book, getName(), getImage(), getAuthor(), getPress(), getPrice(), getStock(), getDescription());
        
        retJson = new SuccessMessage();
        return SUCCESS;
    }
    
    public String deleteBook() {
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
        
        Book book = appService.getBookById(Integer.parseInt(getId()));
        if (book == null) {
            retJson = new FailureMessage("该书籍编号不存在。");
            return NONE;
        }
        
        appService.deleteBook(book);
        
        retJson = new SuccessMessage();
        return SUCCESS;
    }
}
