package com.filters;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.constants.SysConstant;
import com.sys.entity.User;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLDecoder;

/**
 * Created with IntelliJ IDEA.
 *
 * @Auther: xueYaDong
 * @Company: 东方标准
 * @Date: 2019/12/04/17:59
 * @Description:
 */
@WebFilter("/*")
public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession();
        //获取请求路径
        String uri = request.getRequestURI();
        if (uri.endsWith("index.jsp") && session.getAttribute(SysConstant.SESSION_LOGIN_NAME)!=null) {
            //获取所有的cookie信息
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (int i = 0; i < cookies.length; i++) {
                    //如果cookie中有登录信息，则直接跳转到home.jsp
                    if ("cookieLoginUser".equals(cookies[i].getName())) {
                        //获取cookie中的值，并解码，得到json字符串
                        String strJson = URLDecoder.decode(cookies[i].getValue(), "utf-8");
                        //把json字符串转换成java对象
                        User loginUser = JSON.parseObject(strJson, new TypeReference<User>() {
                        });
                        //把从cookie中取出的登陆信息放入到session中
                        session.setAttribute(SysConstant.SESSION_LOGIN_NAME, loginUser);

                        //登陆成功，跳转到home.jsp
                        response.sendRedirect("/view/common/home.jsp");
                    }
                }
            }
        }
        else if (uri.endsWith("index.jsp") || uri.endsWith("/sys/login/login") || uri.endsWith("/sys/login/getPic") || uri.endsWith("/view/sys/user/forget.jsp")) {

        } else {
            Object obj = session.getAttribute(SysConstant.SESSION_LOGIN_NAME);
            //非法登陆
            if (obj == null) {
                response.sendRedirect("/index.jsp");
            }
        }
        filterChain.doFilter(request, response);
    }
}