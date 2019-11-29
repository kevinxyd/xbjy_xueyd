package com.sys.service.impl;

import com.sys.dao.MenuDao;
import com.sys.entity.Menu;
import com.sys.service.MenuService;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 *
 * @Auther: xueYaDong
 * @Company: 东方标准
 * @Date: 2019/11/29/16:27
 * @Description:
 */
public class MenuServiceImpl implements MenuService {

    private MenuDao menuDao = new MenuDao();
    @Override
    public List<Menu> listAll() {
        return menuDao.listAll();
    }
}
