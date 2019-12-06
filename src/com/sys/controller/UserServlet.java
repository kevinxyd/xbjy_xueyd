package com.sys.controller;

import com.alibaba.fastjson.JSON;
import com.constants.SysConstant;
import com.sys.entity.Dept;
import com.sys.entity.Page;
import com.sys.entity.User;
import com.sys.service.DeptService;
import com.sys.service.UserService;
import com.sys.service.impl.DeptServiceImpl;
import com.sys.service.impl.UserServiceImpl;
import com.utils.MDUtil;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 *
 * @Auther: xueYaDong
 * @Company: 东方标准
 * @Date: 2019/11/29/16:30
 * @Description:
 */
@WebServlet("/sys/user/*")
public class UserServlet extends BaseServlet{

    private UserService userService = new UserServiceImpl();
    private DeptService deptService = new DeptServiceImpl();
    public void list(HttpServletRequest request, HttpServletResponse response){

        /**
         *根据时间范围查询
         */
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if (startTime == null && endTime == null || "".equals(startTime) && "".equals(endTime)) {
            startTime = "1949-10-01";
            endTime = sdf.format(new Date());

        } else if (startTime == null && endTime != null || "".equals(startTime)) {
            startTime = "1949-10-01";
            request.setAttribute("endTime", endTime);
        } else if (startTime != null && endTime == null || "".equals(endTime)) {
            endTime = sdf.format(new Date());
            request.setAttribute("startTime", startTime);
        } else {
            request.setAttribute("startTime", startTime);
            request.setAttribute("endTime", endTime);
        }

        /**
         *分页
         */
        String account = request.getParameter("account");
        account = account == null ? "" : account;
        //当前页
        String pageStr = request.getParameter("page");
        //查询总记录数
        Integer count = userService.getCount(account,startTime,endTime);

        Page page = new Page();
        page.setCount(count);
        Integer pageCurrent = pageStr == null ? 1 : Integer.valueOf(pageStr);
        page.setPageCurrent(pageCurrent);
        /**
         *查询传输到前端页面
         */
        List<User> list = userService.listAll(account,startTime,endTime,page);
        //查询的数据
        request.setAttribute("list", list);
        //查询条件
        request.setAttribute("account", account);
        //分页信息
        request.setAttribute("page", page);

        try {
            request.getRequestDispatcher("/view/sys/user/list.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            e.printStackTrace();
        }

    }



    public void add(HttpServletRequest request, HttpServletResponse response) throws Exception {
        User user = new User();
        user.setCreateBy(String.valueOf(getLoginUser().getId()));
        //获取请求体里面的数据
        Map<String, String[]> map = request.getParameterMap();
        BeanUtils.populate(user, map);

        userService.add(user);
        response.sendRedirect("/sys/user/list");
    }

    public void deleteById(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String id = request.getParameter("id");
        if (id == null) {
            return;
        }
        userService.deleteById(Integer.valueOf(id));
        response.sendRedirect("/sys/user/list");
    }

    public void listById(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Integer id = Integer.valueOf(request.getParameter("id"));
        if (id == null) {
            return;
        }
        User user = userService.listById(id);
        //List<Dept> listDept = deptService.listAll();
        System.out.println(user.getSex() + user.getName());
        request.setAttribute("userUpdate",user);
        request.getRequestDispatcher("/view/sys/user/update.jsp").forward(request,response);
    }

    public void update(HttpServletRequest request, HttpServletResponse response) throws InvocationTargetException, IllegalAccessException, IOException {
        User user = new User();
        //获取请求体里面的数据
        Map<String, String[]> map = request.getParameterMap();
        BeanUtils.populate(user, map);
        System.out.println(user.getId() + user.getBirthDate() + user.getEmail());
        userService.update(user);
        response.sendRedirect("/sys/user/list");
    }

    /***
     * @decription 修改密码
     * @author admin
     * @date 2019/12/3 12:29
     * @params [request, response]
     * @return void
     */
    public void forgetPassword(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String account = request.getParameter("account");
        String password = request.getParameter("password");
        //前端输入的验证码
        String code = request.getParameter("code");

        System.out.println(account + password + "验证码" + code);
        HttpSession session = request.getSession();
        //取出session中的code
        Object object = session.getAttribute(SysConstant.SESSION_EMAIL_CODE_NAME);

        //比较前端输入的code和session中的code
        if (object == null || !code.equals(object.toString())) {
            response.sendRedirect("/view/sys/user/forget.jsp");
            return;
        }

        User user = new User();
        user.setAccount(account);
        user.setPassword(MDUtil.md5(password));
        userService.updatePassword(user);
        //修改完毕，跳转到登录界面
        response.sendRedirect("/index.jsp");

    }

}
