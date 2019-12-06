package com.sys.service.impl;

import com.sys.dao.UserDao;
import com.sys.entity.Page;
import com.sys.entity.User;
import com.sys.service.UserService;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 *
 * @Auther: xueYaDong
 * @Company: 东方标准
 * @Date: 2019/12/02/17:04
 * @Description:
 */
public class UserServiceImpl implements UserService {
    private UserDao userDao = new UserDao();
    @Override
    public List<User> listAll(String account,String startTime,String endTime, Page page) {
        return userDao.listAll(account, startTime, endTime,page);
    }

    @Override
    public int getCount(String account ,String startTime,String endTime) {
        return userDao.getCount(account,startTime,endTime);
    }

    @Override
    public void add(User user) {
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        user.setCreateTime(simpleDateFormat.format(date));
        userDao.add(user);
    }

    @Override
    public void deleteById(Integer id) {
        userDao.deleteById(id);
    }

    @Override
    public User listById(Integer id) {
        return userDao.listById(id);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public void updatePassword(User user) {
        userDao.updatePassword(user);
    }

    @Override
    public List<User> Login(User user) {
        return userDao.Login(user);
    }

}