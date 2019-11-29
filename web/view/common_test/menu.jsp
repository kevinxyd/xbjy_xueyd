<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>$Title$</title>
    <script src="/static/js/jquery-3.3.1.js"></script>
</head>
<script>
    $(function () {
        $.ajax({
            url: "/sys/menu",
            type: "get",
            data: "",
            dataType: "json",
            success: function (data) {
                var html = '';
                //外层循环（取出1级菜单数据）
                for (var i = 0; i < data.length; i++) {
                    //只选择1级菜单
                    if (data[i].type == 1) {
                        html = html + data[i].name + "</br>";
                        html = html + '<ul>';
                        //内层循环（取出2级菜单数据）
                        for (var j = 0; j < data.length; j++) {
                            //2级菜单和1级菜单产生关联
                            if (data[j].pId == data[i].id) {
                                //只选择2级菜单
                                if (data[j].type == 2) {
                                    html = html + '<li><a href="' + data[j].menuUrl + '">' + data[j].name + '</a></li>';
                                }
                            }
                        }
                        html = html + '</ul>';
                    }
                }
                $("#div-menu").append(html);
            }
        });


    });

</script>

<body>
<div id="div-menu" style="border: 1px solid red;width: 10%;height: 85%;float: left;">
    <%--系统管理--%>
    <%--<ul>--%>
    <%--<li><a href="user.jsp">用户管理</a></li>--%>
    <%--<li><a href="dept.jsp">部门管理</a></li>--%>
    <%--<li><a href="">字典管理</a></li>--%>
    <%--</ul>--%>
    <%--权限管理--%>
    <%--<ul>--%>
    <%--<li><a href="">角色管理</a></li>--%>
    <%--<li><a href="">权限管理</a></li>--%>
    <%--</ul>--%>

    <%--订单管理--%>
    <%--<ul>--%>
    <%--<li><a href="">物流管理</a></li>--%>
    <%--<li><a href="">订单管理</a></li>--%>
    <%--</ul>--%>

</div>

<!--
<div style="border: 1px solid red;width: 10%;height: 85%;float: left;">
    系统管理
    <ul>
        <li><a href="user.jsp">用户管理</a></li>
        <li><a href="dept.jsp">部门管理</a></li>
        <li><a href="">字典管理</a></li>
    </ul>
    权限管理
    <ul>
        <li><a href="">角色管理</a></li>
        <li><a href="">权限管理</a></li>
    </ul>

    订单管理
    <ul>
        <li><a href="">物流管理</a></li>
        <li><a href="">订单管理</a></li>
    </ul>

</div>
-->
</body>
</html>
