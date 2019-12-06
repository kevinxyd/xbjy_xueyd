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
        <form action="/sys/dept/listAllPage" method="get" class="text-center">

            <input type="submit" value="查询" class="btn btn-success">
            部门名称：<input type="text" value="${name}" name="name" >
        </form>
        <a href="/view/sys/dept/add.jsp" class="btn btn-success">添加</a><br><br>

        <table class="table table-bordered"  style="color: white" >
            <thead>
            <tbody>
            <tr style="border: #3c3c3c">
                <th>序号</th>
                <th>部门名称</th>
                <th>创建时间</th>
                <th>创建人</th>
                <th>操作</th>
            </tr>
            </thead>
            <c:forEach items="${list}" var="dept" varStatus="status">
                <tr>
                    <td>${status.index+1}</td>
                    <td>${dept.name}</td>
                    <td>
                        <%--把日期类型字符串转换成日期对象--%>
                        <fmt:parseDate var="createTime" value="${dept.createTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:parseDate>
                        <%--把日期对象转换成规定的字符串格式--%>
                        <fmt:formatDate value="${createTime}" pattern="yyyy年MM月dd日 HH时mm分ss秒"></fmt:formatDate>
                    </td>
                    <td>${dept.userName}</td>
                    <td class="id">
                        <a href="/sys/dept/listById?id=${dept.id}" class="btn btn-success">修改</a>
                        <a href="/sys/dept/deleteById?id=${dept.id}" class="btn btn-danger">删除</a>
                    </td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
        <br>
        <div class="text-center">
                <c:if test="${page.pageCurrent!=1 }">
                    <a  href="/sys/dept/listAllPage?name=${name}&page=1" class="btn btn-info btn-xs">首页</a>
                    <a href="/sys/dept/listAllPage?name=${name}&page=${page.pageCurrent-1}" class="btn btn-primary btn-xs">上一页</a>
                </c:if>
                <c:if test="${page.pageCurrent!=page.pageCount}">
                    <a class="btn btn-primary btn-xs" href="/sys/dept/listAllPage?name=${name}&page=${page.pageCurrent+1}">下一页</a>
                    <a class="btn btn-info btn-xs" href="/sys/dept/listAllPage?name=${name}&page=${page.pageCount}">末页</a>
                </c:if>

        </div>
        <br>
        <h6 class="text-center">当前页：${page.pageCurrent},总页数：${page.pageCount}，总记录数：${page.count}</h6>
    </div>
</div>
</body>
<!-- JavaScript files-->
<script src="../../../static/plug-in/vendor/jquery/jquery.min.js"></script>
<script src="../../../static/plug-in/vendor/popper.js/umd/popper.min.js"> </script>
<script src="../../../static/plug-in/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="../../../static/plug-in/vendor/jquery.cookie/jquery.cookie.js"> </script>
<script src="../../../static/plug-in/vendor/jquery-validation/jquery.validate.min.js"></script>
<script src="../../../static/plug-in/js/front.js"></script>
<script src="../../../static/plug-in/js/custom.js"></script>
<script>
    $(function () {
    });
</script>
</html>
