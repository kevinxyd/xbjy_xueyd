package com.sys.dao;

import com.sys.entity.Dept;
import com.sys.entity.Page;
import com.utils.DBUtil;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 *
 * @Auther: xueYaDong
 * @Company: 东方标准
 * @Date: 2019/12/02/19:37
 * @Description:
 */
public class DeptDao {


    private JdbcTemplate template = new JdbcTemplate(DBUtil.getDataSource());
    public List<Dept> listAll() {
        String sql = "select * from sys_dept";
        return template.query(sql,new BeanPropertyRowMapper<>(Dept.class));
        //return template.queryForObject(sql,new BeanPropertyRowMapper<>(User.class),id);
    }
    //根据id查询
    public Integer listAll(Dept dept) {
        String sql = "select count(1)  from sys_dept  d right join sys_user u  on  d.id = u.dept_id where d.id = ?";
        return template.queryForObject(sql,Integer.class,dept.getId());
        //return template.queryForObject(sql,new BeanPropertyRowMapper<>(User.class),id);
    }
    //分页模糊查询
    public List<Dept> listAllPage(String name,Page page) {
        String sql = "SELECT " +
                "d.id," +
                "d.name name," +
                "u.name userName," +
                "d.create_time " +
                "FROM " +
                "sys_dept d " +
                "LEFT JOIN sys_user u ON u.id = d.create_by " +
                "WHERE " +
                "d.NAME LIKE ? " +
                "ORDER BY " +
                "d.create_time DESC " +
                "LIMIT ?,?";
        return template.query(sql, new BeanPropertyRowMapper<>(Dept.class), "%" + name + "%", (page.getPageCurrent() - 1) * page.getPageSize(), page.getPageSize());
    }

    public Integer getCount(String name) {
        String sql = "select count(*) from sys_dept where name like ? ";
        return template.queryForObject(sql, Integer.class, "%" + name + "%");
    }

    public void add(Dept dept) {
        String sql = "insert into sys_dept(name,create_time,create_by) values(?,?,?)";
        template.update(sql,dept.getName(),dept.getCreateTime(),dept.getCreateBy());
    }

    public void deleteById(Integer id){
        String sql = "delete from sys_dept where id = ?";
        template.update(sql,id);
    }
}