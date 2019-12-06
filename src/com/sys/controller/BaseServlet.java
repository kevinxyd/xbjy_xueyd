package com.sys.controller;

import com.constants.SysConstant;
import com.sys.entity.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

/**
 * Created with IntelliJ IDEA.
 *
 * @Auther: xueYaDong
 * @Company: 东方标准
 * @Date: 2019/12/02/11:02
 * @Description:利用反射封装servlet请求
 */
public class BaseServlet extends HttpServlet {
    //登陆信息
    private User loginUser = new User();

    public User getLoginUser() {
        return loginUser;
    }

    public void setLoginUser(User loginUser) {
        this.loginUser = loginUser;
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        loginUser = (User)session.getAttribute(SysConstant.SESSION_LOGIN_NAME);

        //获取请求头地址/url/url/url
        String requestURI = request.getRequestURI();
        //分割地址
        String[] split = requestURI.split("/");
        //获取最后一个地址
        requestURI = split[split.length - 1];

        //通过反射获取调用对象
        Class aClass = this.getClass();
        try {
            //获取该对象的所有方法()参数一：方法名，参数二、三：该方法的参数类型
            Method method = aClass.getDeclaredMethod(requestURI, HttpServletRequest.class, HttpServletResponse.class);
            //暴力反射(针对私有方法)
            method.setAccessible(true);
            //动态调用方法
            method.invoke(this,request,response);
        } catch (NoSuchMethodException | IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }
    }
}