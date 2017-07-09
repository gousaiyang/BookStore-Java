package bookstore.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.jdbc.Work;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import bookstore.dao.StatDao;

public class StatDaoImpl extends HibernateDaoSupport implements StatDao {
    
    private String startStr = " 00:00:00";
    private String endStr = " 23:59:59";
    
    private Integer statPerson;
    private Integer statQuantity;
    private Integer statPrice;
    private Integer statOrders;
    private Integer statItems;
    
    public List<Integer> statAll(String startDate, String endDate) {
        getSession().doWork(new Work() {
            public void execute(Connection connection) throws SQLException {
                CallableStatement cstmt = connection.prepareCall("CALL statAll(?, ?, ?, ?, ?)");
                
                cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
                cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
                cstmt.registerOutParameter(5, java.sql.Types.INTEGER);
                cstmt.setString(1, startDate + startStr);
                cstmt.setString(2, endDate + endStr);
                cstmt.execute();
                
                statPerson = cstmt.getInt(3);
                statQuantity = cstmt.getInt(4);
                statPrice = cstmt.getInt(5);
            }
        });
        
        List<Integer> ret = new ArrayList<Integer>();
        ret.add(statPerson);
        ret.add(statQuantity);
        ret.add(statPrice);
        
        return ret;
    }
    
    public List<Integer> statCategory(int categoryId, String startDate, String endDate) {
        getSession().doWork(new Work() {
            public void execute(Connection connection) throws SQLException {
                CallableStatement cstmt = connection.prepareCall("CALL statCategory(?, ?, ?, ?, ?, ?)");
                
                cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
                cstmt.registerOutParameter(5, java.sql.Types.INTEGER);
                cstmt.registerOutParameter(6, java.sql.Types.INTEGER);
                cstmt.setInt(1, categoryId);
                cstmt.setString(2, startDate + startStr);
                cstmt.setString(3, endDate + endStr);
                cstmt.execute();
                
                statPerson = cstmt.getInt(4);
                statQuantity = cstmt.getInt(5);
                statPrice = cstmt.getInt(6);
            }
        });
        
        List<Integer> ret = new ArrayList<Integer>();
        ret.add(statPerson);
        ret.add(statQuantity);
        ret.add(statPrice);
        
        return ret;
    }
    
    public List<Integer> statBook(int bookId, String startDate, String endDate) {
        getSession().doWork(new Work() {
            public void execute(Connection connection) throws SQLException {
                CallableStatement cstmt = connection.prepareCall("CALL statBook(?, ?, ?, ?, ?, ?)");
                
                cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
                cstmt.registerOutParameter(5, java.sql.Types.INTEGER);
                cstmt.registerOutParameter(6, java.sql.Types.INTEGER);
                cstmt.setInt(1, bookId);
                cstmt.setString(2, startDate + startStr);
                cstmt.setString(3, endDate + endStr);
                cstmt.execute();
                
                statPerson = cstmt.getInt(4);
                statQuantity = cstmt.getInt(5);
                statPrice = cstmt.getInt(6);
            }
        });
        
        List<Integer> ret = new ArrayList<Integer>();
        ret.add(statPerson);
        ret.add(statQuantity);
        ret.add(statPrice);
        
        return ret;
    }
    
    public List<Integer> statUser(String username, String startDate, String endDate) {
        getSession().doWork(new Work() {
            public void execute(Connection connection) throws SQLException {
                CallableStatement cstmt = connection.prepareCall("CALL statUser(?, ?, ?, ?, ?, ?, ?)");
                
                cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
                cstmt.registerOutParameter(5, java.sql.Types.INTEGER);
                cstmt.registerOutParameter(6, java.sql.Types.INTEGER);
                cstmt.registerOutParameter(7, java.sql.Types.INTEGER);
                cstmt.setString(1, username);
                cstmt.setString(2, startDate + startStr);
                cstmt.setString(3, endDate + endStr);
                cstmt.execute();
                
                statOrders = cstmt.getInt(4);
                statItems = cstmt.getInt(5);
                statQuantity = cstmt.getInt(6);
                statPrice = cstmt.getInt(7);
            }
        });
        
        List<Integer> ret = new ArrayList<Integer>();
        ret.add(statOrders);
        ret.add(statItems);
        ret.add(statQuantity);
        ret.add(statPrice);
        
        return ret;
    }
}
