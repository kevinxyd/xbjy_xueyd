package com.sys.controller;

import com.alibaba.fastjson.JSON;
import com.sys.entity.Dept;
import com.sys.entity.Page;
import com.sys.entity.User;
import com.sys.service.DeptService;
import com.sys.service.impl.DeptServiceImpl;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 *
 * @Auther: xueYaDong
 * @Company: 东方标准
 * @Date: 2019/12/03/10:34
 * @Description:
 */
@WebServlet("/sys/dept/*")
public class DeptServlet extends BaseServlet{
    private DeptService deptService = new DeptServiceImpl();
    //用于用户查询
    public void listAll(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Dept> list = deptService.listAll();
        String s = JSON.toJSONString(list);
        PrintWriter writer = response.getWriter();
        writer.append(s);
    }

    //分页模糊查询
    public void listAllPage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //分页
        Page page = new Page();
        String name = request.getParameter("name");
        name = name == null ? "" : name;
        //当前页
        String pageStr = request.getParameter("page");
        //查询总记录数
        Integer count = deptService.getCount(name);
        page.setCount(count);
        Integer pageCurrent = pageStr == null ? 1 : Integer.valueOf(pageStr);
        page.setPageCurrent(pageCurrent);
        //查询传输到前端页面
        List<Dept> list = deptService.listAllPage(name,page);
        //查询的数据
        request.setAttribute("list", list);
        //查询条件
        request.setAttribute("name", name);
        //分页信息
        request.setAttribute("page", page);

        try {
            request.getRequestDispatcher("/view/sys/dept/list.jsp").forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //添加部门
    /*public void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Dept dept = new Dept();
        Map<String, String[]> map = request.getParameterMap();
        try {
            BeanUtils.populate(dept,map);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        deptService.add(dept);
        response.sendRedirect("/sys/dept/listAllPage");
    }*/

    public void add(HttpServletRequest request, HttpServletResponse response) throws Exception {
        User user = (User)request.getSession().getAttribute("sessionLoginName");
        Map<String, String[]> map = request.getParameterMap();
        Dept dept = new Dept();
        dept.setCreateBy(user.getId());
        dept.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        BeanUtils.populate(dept, map);
        dept.setCreateBy(getLoginUser().getId());
        deptService.add(dept);
        response.sendRedirect("/sys/dept/listAllPage");
    }

    public void deleteById(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        boolean b = deptService.deleteById(id);
        request.setAttribute("b",b);
        request.getRequestDispatcher("/sys/dept/listAllPage").forward(request,response);
    }
}