<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>$Title$</title>

    <link rel="stylesheet" href="../../../static/plug-in/vendor/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="../../../static/plug-in/vendor/font-awesome/css/font-awesome.min.css">
    <!-- Custom Font Icons CSS-->
    <link rel="stylesheet" href="../../../static/plug-in/css/font.css">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="../../../static/plug-in/css/style.default.css" id="theme-stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="../../../static/plug-in/css/custom.css">
</head>
<style>

</style>
<body>
<%@ include file="/view/common/head.jsp" %>
<div class="d-flex align-items-stretch">
    <%@ include file="/view/common/menu.jsp"%>
    <div class="page-content" style="padding: 20px;color: antiquewhite;" >
        <form action="/sys/user/list" method="get" class="text-center">

            <input type="submit" value="查询" class="btn btn-success">
            <input type="text" value="${account}" name="account" id="a" placeholder="账号查询">
            开始时间：<input type="date" value="${startTime}" name="startTime" id="d">
            结束时间：<input type="date" value="${endTime}" name="endTime" id="c">
            <input type="submit" class="btn btn-primary" value="清空" id="b">
        </form>
        <a href="/view/sys/user/add.jsp" class="btn btn-success">添加</a><br><br>

        <table class="table table-bordered"  style="color: white" >
            <thead>
            <tbody>
            <tr style="border: #3c3c3c">
                <th>序号</th>
                <th>部门名称</th>
                <th>账号</th>
                <th>姓名</th>
                <th>邮箱</th>
                <th>年龄</th>
                <th>性别</th>
                <th>出生日期</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <c:forEach items="${list}" var="user" varStatus="status">
                <tr>
                    <td>${status.index+1}</td>
                    <td>${user.deptName}</td>
                    <td>${user.account}</td>
                    <td>${user.name}</td>
                    <td>${user.email}</td>
                    <td>${user.age}</td>
                    <td>
                            <%--<c:if test="${user.sex==1}">男</c:if>--%>
                            <%--<c:if test="${user.sex==0}">女</c:if>--%>
                        <c:choose>
                            <c:when test="${user.sex==1}">男</c:when>
                            <c:when test="${user.sex==0}">女</c:when>
                            <c:otherwise>其他</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                            <%--把日期类型字符串转换成日期对象--%>
                        <fmt:parseDate var="birthDate" value="${user.birthDate}"
                                       pattern="yyyy-MM-dd"></fmt:parseDate>
                            <%--把日期对象转换成规定的字符串格式--%>
                        <fmt:formatDate value="${birthDate}" pattern="yyyy年MM月dd日"></fmt:formatDate>
                    </td>
                    <td>
                            <%--把日期类型字符串转换成日期对象--%>
                        <fmt:parseDate var="createTime" value="${user.createTime}"
                                       pattern="yyyy-MM-dd HH:mm:ss"></fmt:parseDate>
                            <%--把日期对象转换成规定的字符串格式--%>
                        <fmt:formatDate value="${createTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                    </td>
                    <td>
                        <a href="/sys/user/listById?id=${user.id}" class="btn btn-success">修改</a>
                        <a href="/sys/user/deleteById?id=${user.id}" class="btn btn-danger">删除</a>
                    </td>
                </tr>

            </c:forEach>

            </tbody>
        </table>
        <br>
        <div class="text-center">
            <c:if test="${page.pageCurrent!=1 }">
                <a  href="/sys/user/list?account=${account}&startTime=${startTime}&endTime=${endTime}&page=1" class="btn btn-info btn-xs">首页</a>
                <a href="/sys/user/list?account=${account}&startTime=${startTime}&endTime=${endTime}&page=${page.pageCurrent-1}" class="btn btn-primary">上一页</a>
            </c:if>
            <c:if test="${page.pageCurrent!=page.pageCount}">
                <a class="btn btn-primary" href="/sys/user/list?account=${account}&startTime=${startTime}&endTime=${endTime}&page=${page.pageCurrent+1}">下一页</a>
                <a class="btn btn-info btn-xs" href="/sys/user/list?account=${account}&startTime=${startTime}&endTime=${endTime}&page=${page.pageCount}">末页</a>
            </c:if>
        </div>
        <br>
        <h6 class="text-center">当前页：${page.pageCurrent},总页数：${page.pageCount}，总记录数：${page.count}</h5>

    </div>
</div>
</body>
<!-- JavaScript files-->
<script src="../../../static/plug-in/vendor/jquery/jquery.min.js"></script>
<script src="../../../static/plug-in/vendor/popper.js/umd/popper.min.js"> </script>
<script src="../../../static/plug-in/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="../../../static/plug-in/vendor/jquery.cookie/jquery.cookie.js"> </script>
<script src="../../../static/plug-in/vendor/chart.js/Chart.min.js"></script>
<script src="../../../static/plug-in/vendor/jquery-validation/jquery.validate.min.js"></script>
<script src="../../../static/plug-in/js/charts-home.js"></script>
<script src="../../../static/plug-in/js/front.js"></script>
<script src="../../../static/plug-in/js/custom.js"></script>
<script>
    $(function () {
        //清空条件
        $("#b").click(function () {
            $("#a").val("");
            $("#d").val("");
            $("#c").val("");
        })
    });
</script>
</html>
