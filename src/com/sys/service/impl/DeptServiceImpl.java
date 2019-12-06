package com.sys.service.impl;

import com.sys.dao.DeptDao;
import com.sys.entity.Dept;
import com.sys.entity.Page;
import com.sys.service.DeptService;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 *
 * @Auther: xueYaDong
 * @Company: 东方标准
 * @Date: 2019/12/02/19:56
 * @Description:
 */
public class DeptServiceImpl implements DeptService {
    private DeptDao deptDao = new DeptDao();

    @Override
    public List<Dept> listAll() {
        return deptDao.listAll();
    }

    @Override
    public Integer listAll(Dept dept) {
        return deptDao.listAll(dept);
    }

    @Override
    public List<Dept> listAllPage(String name, Page page) {
        return deptDao.listAllPage(name,page);
    }

    @Override
    public Integer getCount(String name) {
        return deptDao.getCount(name);
    }

    @Override
    public void add(Dept dept) {
        deptDao.add(dept);
    }

    @Override
    public boolean deleteById(Integer id) {
        boolean falg;
        Dept dept = new Dept();
        dept.setId(id);
        Integer count = deptDao.listAll(dept);
        if (count==0){
            deptDao.deleteById(id);
            falg = true;
        } else {
            falg = false;
        }
        return falg;
    }

}