package bookstore.action;

import java.io.File;
import org.apache.commons.io.FilenameUtils;

import bookstore.model.result.FailureMessage;
import bookstore.model.result.SuccessMessage;
import bookstore.service.AppService;

public class UploadImageAction extends BaseAction {
    
    private static final long serialVersionUID = 1L;
    
    private File file;
    private String filename;
    
    private final static String uploadPath = "img/upload/";
    
    private Object retJson;
    
    private AppService appService;
    
    // Getters and setters

    public void setImage(File file) {
       this.file = file;
    }
    
    public void setImageFileName(String filename) {
        this.filename = filename;
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

    public String execute() {
        
        if (session().getAttribute("user") == null) {
            retJson = new FailureMessage("请先登录");
            return LOGIN;
        }
        
        String newFilename = appService.uploadImage(FilenameUtils.concat(application().getRealPath("/"), uploadPath),
                file, filename);
        
        if (newFilename.isEmpty()) {
            retJson = new FailureMessage("上传失败！请检查文件大小和格式。");
            return ERROR;
        }
        
        retJson = new SuccessMessage(newFilename);
        return SUCCESS;
        
    }

}
