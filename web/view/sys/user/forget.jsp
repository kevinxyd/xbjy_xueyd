<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="/static/plug-in/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/plug-in/css/style.css">
    <link rel="stylesheet" href="/static/plug-in/css/form-elements.css">
    <link rel="stylesheet" href="/static/plug-in/css/font-awesome.min.css">
    <title>重置密码</title>
    <style>
        body {
            background: url("/static/plug-in/img/bg.jpg") no-repeat fixed;
            background-size: cover;
            overflow: hidden;
        }

    </style>
</head>
<body>

<div class="container myBox">
    <div class="col-xs-8 col-xs-offset-4 col-sm-6 col-sm-offset-3 form-box">
        <div class="form-top">
            <div class="form-top-left">
                <h3>重置密码</h3>
                <p>请输入您的邮箱:</p>
            </div>
            <div class="form-top-right">
                <i class="fa fa-key"></i>
            </div>
        </div>
        <div class="form-bottom">
            <form role="form" action="/sys/user/forgetPassword" method="post" class="login-form">

                <!--上面的输入框尽可能不需要外边距，使用row解决-->
                <div class="row">

                    <div class="form-group">
                        账号：
                        <input type="text" name="account" placeholder="新密码" class="form-password form-control">
                    </div>
                    <div class="form-group">
                        新密码
                        <input type="password" name="password" placeholder="新密码" class="form-password form-control">
                    </div>
                    <div style="margin-bottom: 15px" class="form-inline">
                        邮箱
                        <input type="text" name="form-username"  placeholder="邮箱" class="form-username"id="email">
                        <input type="button" class="btn btn-primary" id="btn-send" value="发送验证码">
                    </div>
                    <div class="form-group">
                        验证码<span id="time"></span>
                        <input type="text" name="code" placeholder="验证码" class="form-control">
                    </div>
                </div>
                <!--上面的输入框尽可能不需要外边距，使用row包裹起来解决-->

                <!--<div class="checkbox">-->
                    <!--<label>-->
                        <!--<input type="checkbox"> 记住我-->
                    <!--</label>-->
                <!--</div>-->
                <button type="submit" class="btn">修改</button>

                <div class="row">
                    <div style="padding: 10px 25px">
                        <div style="display: inline-block;float: left" class="text-left"><a href="/index.jsp">返回登录</a></div>
                        <!--<div style="display: inline-block;float: right" class="text-right"><a href="#">没有账号?</a></div>-->
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>


<!-- Javascript -->
<script src="/static/plug-in/js/jquery-1.11.1.min.js"></script>
<script src="/static/plug-in/bootstrap/js/bootstrap.min.js"></script>
<script src="/static/plug-in/js/jquery.backstretch.min.js"></script>
<script src="/static/plug-in/js/scripts.js"></script>
<script>

    var time = 60;
    //定时器
    var dsq;

    $(function () {
        $("#btn-send").click(function () {

            dsq = window.setInterval("changeTime()", 1000);
            $("#btn-send").attr("disabled", "disabled");

            var email = $("#email").val();
            $.ajax({
                url: "/sys/email/sendEmail",
                data: {email: email},
                type: "get",
                dataType: "text",
                success: function (data) {
                    alert(data);
                }
            });

        });
    });

    function changeTime() {
        --time;
        $("#time").text(time);
        if (time == 0) {
            $("#time").text("");
            time = 60;
            window.clearInterval(dsq);
            $("#btn-send").attr("disabled", null);
        }
    }

</script>
</body>
</html>