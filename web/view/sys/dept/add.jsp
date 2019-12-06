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
    .error {
        color: red;
    }

</style>

<body>
<%@ include file="/view/common/head.jsp" %>
<div class="d-flex align-items-stretch">
    <%@ include file="/view/common/menu.jsp" %>
    <div class="page-content" style="padding: 50px;color: white">
        <form action="/sys/dept/add" method="get" id="form-add" style="color: white">
            <div class="form-group">
                <label>部门名称</label>
                <input type="text" class="form-control" id="name" name="name"  placeholder="请输入部门名称">
            </div>
            <!--居中-->
            <div class="text-center">
                <button type="submit" class="btn btn-primary">提交</button>
                <a href="/sys/dept/listAllPage" class="btn btn-danger">返回</a>
            </div>
        </form>

    </div>
</div>
</body>

<script src="../../../static/plug-in/vendor/jquery/jquery.min.js"></script>
<script src="../../../static/plug-in/vendor/popper.js/umd/popper.min.js"></script>
<script src="../../../static/plug-in/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="../../../static/plug-in/vendor/jquery.cookie/jquery.cookie.js"></script>
<script src="../../../static/plug-in/vendor/chart.js/Chart.min.js"></script>
<script src="../../../static/plug-in/vendor/jquery-validation/jquery.validate.min.js"></script>
<script src="../../../static/plug-in/js/charts-home.js"></script>
<script src="../../../static/plug-in/js/front.js"></script>
<script src="../../../static/plug-in/js/custom.js"></script>
<script>
    $(function () {
        $("#form-add").validate({
            rules: {
                name: {
                    required: true
                }
            },
            messages: {
                name: {
                    required: "请输入部门名称"
                }
            }
        });

    })
    ;
</script>
</html>
