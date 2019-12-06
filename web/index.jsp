
<%@ page import="java.net.URLDecoder" %>
<%@ page import="com.alibaba.fastjson.JSON" %>
<%@ page import="com.alibaba.fastjson.TypeReference" %>
<%@ page import="com.sys.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="static/plug-in/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="static/plug-in/css/style.css">
  <link rel="stylesheet" href="static/plug-in/css/form-elements.css">
  <link rel="stylesheet" href="static/plug-in/css/font-awesome.min.css">

  <title>登录</title>
  <%
    Cookie[] cookies = request.getCookies();
    User loginUser = new User();
    String checked = "";
    if (cookies != null){
      for (Cookie cookie:cookies) {
          if ("cookieLoginUser".equals(cookie.getName())){
            String value = cookie.getValue();
            String decode = URLDecoder.decode(value, "utf-8");
            loginUser = JSON.parseObject(decode,new TypeReference<User>(){});
          }
          if ("checkedCookie".equals(cookie.getName())){
            checked = cookie.getValue();

          }
      }
    }
  %>
  <style>
    body {
      background: url("static/plug-in/img/bg.jpg") no-repeat fixed;
      background-size: cover;
      overflow: hidden;
    }

  </style>
</head>
<body>

<div class="container myBox text-center">
  <div class="col-xs-8 col-xs-offset-4 col-sm-6 col-sm-offset-3 form-box">
    <div class="form-top">
      <div class="form-top-left">
        <h3>小标交友</h3>
        <p>请输入您的信息:</p>
      </div>
      <div class="form-top-right">
        <i class="fa fa-key"></i>
      </div>
    </div>
    <div class="form-bottom">
      <form role="form" action="/sys/login/login" method="post" class="login-form">

        <!--上面的输入框尽可能不需要外边距，使用row解决-->
        <div class="row">
          <div class="form-group">
            <label class="sr-only" for="picCode">账号</label>
            <input type="text" name="account" class="form-control" value="<%=loginUser.getAccount() == null ? "" : loginUser.getAccount() %>" placeholder="账号">
          </div>
          <div class="form-group">
            <label class="sr-only" for="picCode">密码</label>
            <input type="text" name="password" class="form-control" value="<%=loginUser.getPassword() == null ? "" : loginUser.getPassword() %>" placeholder="密码" >
          </div>
          <c:if test="${sessionLogiNname == null or sessionLogiNname == ''}">
            <div class="form-group">
              <%--点击获取新的验证码--%>
              <img src="/sys/login/getPic" alt="无法加载" id="img" onclick="getPic()">
            </div>
            <div class="form-group">
              <label class="sr-only" for="picCode">验证码</label>
              <input type="text" name="picCode" class="form-control" placeholder="验证码" id="picCode">
            </div>
          </c:if>
        </div>
        <!--上面的输入框尽可能不需要外边距，使用row包裹起来解决-->

        <div class="checkbox">
          <label>
            <input type="checkbox" name="checked" value="checked"  <c:if test='<%=checked != "" %>'>checked</c:if>> 记住我
          </label>
        </div>
        <button type="submit" class="btn">登录</button>

        <div class="row">
          <div style="padding: 10px 25px">
            <div style="display: inline-block;float: left" class="text-left"><a href="/view/sys/user/forget.jsp">忘记密码?</a></div>
            <div style="display: inline-block;float: right" class="text-right"><a href="">没有账号?</a></div>
          </div>
        </div>

      </form>
    </div>
  </div>
</div>


<!-- Javascript -->
<script src="static/plug-in/js/jquery-1.11.1.min.js"></script>
<script src="static/plug-in/bootstrap/js/bootstrap.min.js"></script>
<script src="static/plug-in/js/jquery.backstretch.min.js"></script>
<script src="static/plug-in/js/scripts.js"></script>
<script>
  function getPic() {
    // $("#img").attr("src", $("#img").attr("src") + "?nocache="+new Date().getTime());
    document.getElementById("img").src = document.getElementById("img").src + "?nocache=" + new Date().getTime();
  }
</script>
</body>
</html>
