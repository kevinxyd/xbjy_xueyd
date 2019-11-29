package com.sys.dao;

import com.sys.entity.Menu;
import com.utils.DBUtil;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 *
 * @Auther: xueYaDong
 * @Company: 东方标准
 * @Date: 2019/11/29/16:45
 * @Description:
 */
public class MenuDao {

    private JdbcTemplate template = new JdbcTemplate(DBUtil.getDataSource());

    public List<Menu> listAll() {
        //物理删除，逻辑删除  del_flag
        String sql = "select * from sys_menu";
        return template.query(sql, new BeanPropertyRowMapper<>(Menu.class));
    }
}
