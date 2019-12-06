package com.sys.dao;

import com.sys.entity.Page;
import com.sys.entity.User;
import com.utils.DBUtil;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

/**
 * @author admin
 * @version 1.0.1
 * @company 东方标准
 * @date 2019/12/2 11:27
 * @description
 */
public class UserDao {

    private JdbcTemplate template = new JdbcTemplate(DBUtil.getDataSource());

    public List<User> listAll(String account,String startTime,String endTime, Page page) {
        String sql = "SELECT " +
                "d.NAME deptName," +
                "u.id id," +
                "u.account account," +
                "u.NAME name," +
                "u.email email," +
                "u.age age," +
                "u.sex sex," +
                "u.birth_date birthDate," +
                "u.create_time createTime " +
                "FROM " +
                "sys_user u " +
                "LEFT JOIN sys_dept d ON u.dept_id = d.id " +
                "where u.account like ? and u.create_time BETWEEN ? AND ? limit ?,?";
        return template.query(sql, new BeanPropertyRowMapper<>(User.class), "%" + account + "%",startTime,endTime, (page.getPageCurrent() - 1) * page.getPageSize(), page.getPageSize());
    }

    public Integer getCount(String account,String startTime,String endTime) {
        String sql = "select count(*) from sys_user where account like ? and create_time BETWEEN ? AND ?";
        return template.queryForObject(sql, Integer.class, "%" + account + "%",startTime,endTime);
    }

    public void add(User user) {
        String sql = "insert into sys_user (id,dept_id,account,password,name,age,sex,email,birth_date,create_time,create_by) values (null,?,?,?,?,?,?,?,?,?,?)";
        template.update(sql, user.getDeptId(), user.getAccount(), user.getPassword(), user.getName(), user.getAge(), user.getSex(), user.getEmail(), user.getBirthDate(), user.getCreateTime(),user.getCreateBy());
    }

    public void deleteById(Integer id) {
        String sql = "delete from sys_user where id = ?";
        template.update(sql, id);
    }

    public User listById(Integer id) {
        String sql = "select * from sys_user where id = ?";
        return template.queryForObject(sql,new BeanPropertyRowMapper<>(User.class),id);
    }
    public void update(User user) {
        String sql = "update sys_user set dept_id = ? ,account = ?,password = ?,name = ?,age = ?,sex = ?,email = ?,birth_date = ? where id = ?";
        template.update(sql,user.getDeptId(),user.getAccount(), user.getPassword(), user.getName(), user.getAge(), user.getSex(), user.getEmail(), user.getBirthDate(),  user.getId());
    }
    public void updatePassword(User user) {
        //系统account唯一
        String sql = "update sys_user set password =? where account = ? ";
        template.update(sql, user.getPassword(), user.getAccount());
    }
    public List<User> Login(User user) {
        String sql = "select * from sys_user where account= ? and password = ? ";
        return template.query(sql, new BeanPropertyRowMapper<>(User.class), user.getAccount(), user.getPassword());
    }
}