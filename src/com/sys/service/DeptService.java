package com.sys.service;

import com.sys.entity.Dept;
import com.sys.entity.Page;

import java.util.List;

public interface DeptService {
    List<Dept> listAll();
    Integer listAll(Dept dept);
    List<Dept> listAllPage(String name,Page page);
    Integer getCount(String name);
    void add(Dept dept);
    boolean deleteById(Integer id);
}
