package bookstore.action;

import java.io.File;
import java.util.concurrent.ThreadLocalRandom;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;

import bookstore.util.FailureMessage;
import bookstore.util.HashUtil;
import bookstore.util.SuccessMessage;

public class UploadImageAction extends BaseAction {
	
	private static final long serialVersionUID = 1L;
	
	private File file;
	private String filename;
    
    private String uploadPath = "img/upload/";
    
    private Object retJson;
    
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
	
	
	// Actions

    public String execute() {
    	
    	if (session().getAttribute("user") == null) {
    		retJson = new FailureMessage("请先登录");
        	return LOGIN;
    	}
    	
    	try {
    		String uploadDir = FilenameUtils.concat(application().getRealPath("/"), uploadPath);
    		String newName = HashUtil.sha1File(file) + "_" + Long.toString(System.currentTimeMillis()) + "_" + Integer.toString(ThreadLocalRandom.current().nextInt(1, 1001)) + "." + FilenameUtils.getExtension(filename);
    		File newFile = new File(uploadDir, newName);
    		FileUtils.copyFile(file, newFile);
    		retJson = new SuccessMessage(newName);
        	return SUCCESS;
    	}
    	catch (Exception e) {
    		retJson = new FailureMessage("上传失败！请检查文件大小和格式。");
    		return ERROR;
    	}
    }

}
