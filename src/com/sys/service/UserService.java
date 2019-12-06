package com.sys.service;
import com.sys.entity.Page;
import com.sys.entity.User;
import org.springframework.jdbc.core.BeanPropertyRowMapper;

import java.util.List;

public interface UserService {
    List<User> listAll(String account,String startTime,String endTime, Page page);
    int getCount(String account, String startTime,String endTime);
    void add(User user);
    void deleteById(Integer id);
    User listById(Integer id);
    void update(User user);
    void updatePassword(User user);
    List<User> Login(User user);
}
