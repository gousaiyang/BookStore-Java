package bookstore.model;

import java.util.List;

public class Address {
    private int userId;
    private List<String> address;
    
    public Address(int userId, List<String> address) {
        this.userId = userId;
        this.address = address;
    }
    
    public int getUserId() {
        return userId;
    }
    public List<String> getAddress() {
        return address;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public void setAddress(List<String> address) {
        this.address = address;
    }
}
