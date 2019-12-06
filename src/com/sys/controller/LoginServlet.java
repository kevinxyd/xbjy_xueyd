package com.sys.controller;

import com.alibaba.fastjson.JSON;
import com.constants.SysConstant;
import com.sys.entity.User;
import com.sys.service.UserService;
import com.sys.service.impl.UserServiceImpl;
import com.utils.ImgCodeUtil;
import com.utils.MDUtil;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 *
 * @Auther: xueYaDong
 * @Company: 东方标准
 * @Date: 2019/12/04/17:41
 * @Description:
 */
@WebServlet("/sys/login/*")
public class LoginServlet extends BaseServlet {

    private UserService userService = new UserServiceImpl();
    //登录
    public void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String account = request.getParameter("account");
        String password = request.getParameter("password");
        String checked = request.getParameter("checked");
        String picCode = request.getParameter("picCode");
        HttpSession session = request.getSession();
        //验证码
        Object obj = session.getAttribute(SysConstant.SESSION_PIC_CODE_NAME);
        if (session.getAttribute(SysConstant.SESSION_LOGIN_NAME) == null) {
            if (obj == null || !obj.toString().equalsIgnoreCase(picCode)) {
                //验证码不正确
                response.sendRedirect("/index.jsp");
                return;
            }
        }
        User user = new User();
        user.setAccount(account);
        //密文
        user.setPassword(MDUtil.md5(password));

        List<User> list = userService.Login(user);
        //账号或密码不正确或系统存在相同的账号和密码
        if (list == null || list.size() == 0 || list.size() > 1) {
            //登录失败，跳转到登录界面
            response.sendRedirect("/index.jsp");
            return;
        } else {
            //验证通过
            session.setAttribute(SysConstant.SESSION_LOGIN_NAME, list.get(0));

            //在线人数
            ServletContext application = getServletContext();
            //取出application中的在线人数
            Object countObj = application.getAttribute(SysConstant.APPLICATION_LOGIN_COUNT);
            int count = 1;
            if (countObj != null) {
                count = Integer.valueOf(countObj.toString()) + 1;
            }
            //把新的在线人数存入application中
            application.setAttribute(SysConstant.APPLICATION_LOGIN_COUNT, count);


            //记住账号密码
            User loginUser = list.get(0);

            if ("checked".equals(checked)){
                loginUser.setPassword(password);

                String strJson = JSON.toJSONString(loginUser);
                //解决方案二：先编码，取值的时候再解码
                strJson = URLEncoder.encode(strJson, "utf-8");
                Cookie cookLoginUser = new Cookie(SysConstant.COOKIE_LOGIN_USER, strJson);
                Cookie checkedCookie = new Cookie("checkedCookie", checked);
                //7天有效期（单位是秒）
                cookLoginUser.setMaxAge(7 * 24 * 60 * 60);
                checkedCookie.setMaxAge(7 * 24 * 60 * 60);
                //任何请求都能获取cookie
                cookLoginUser.setPath("/");
                checkedCookie.setPath("/");
                response.addCookie(cookLoginUser);
                response.addCookie(checkedCookie);
            } else {
                Cookie cookLoginUser = new Cookie("cookieLoginUser","");//cookie名字要相同
                Cookie checkedCookie = new Cookie("checkedCookie","");//cookie名字要相同
                cookLoginUser.setMaxAge(0);
                checkedCookie.setMaxAge(0); //
                checkedCookie.setPath("/");  // 相同路径
                cookLoginUser.setPath("/");
                response.addCookie(checkedCookie);
                response.addCookie(cookLoginUser);
            }
            request.getRequestDispatcher("/view/common/home.jsp").forward(request, response);
            return;
        }
    }
    //获取图片验证码
    public void getPic(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ImgCodeUtil imgCodeUtil = new ImgCodeUtil();
        //获取验证码图片
        BufferedImage image = imgCodeUtil.getImage();

        ////获取验证码文本内容
        String code = imgCodeUtil.getText();

        //把图片验证码存入session
        HttpSession session = request.getSession();
        session.setAttribute(SysConstant.SESSION_PIC_CODE_NAME, code);

        // 禁止图像缓存。
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("image/jpeg");
        // 将图像输出到Servlet输出流中。
        ServletOutputStream sos = response.getOutputStream();
        ImageIO.write(image, "jpeg", sos);
        sos.flush();
        sos.close();
    }

    //退出
    public void exit(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.getSession().removeAttribute(SysConstant.SESSION_LOGIN_NAME);
        response.sendRedirect("/index.jsp");
    }
}