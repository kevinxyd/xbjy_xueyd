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
    <link rel="stylesheet" href="../../../static/plug-in/css/custom.css"></head>
<style>
    .error {
        color: red;
    }

</style>

<body>
<%@ include file="/view/common/head.jsp" %>
<div class="d-flex align-items-stretch">
    <%@ include file="/view/common/menu.jsp" %>
    <div class="page-content" style="padding:20px 100px 20px;color: white">
        <form action="/sys/user/update" method="get" id="form-add">
            <input type="hidden" name="id" value="${userUpdate.id}">
            <div class="form-group">
                <label>部门</label>
                <select id="dept" name="deptId" class="form-control">
                    <%--<c:forEach var="dept" items="${listDept}">
                        <option value="${userUpdate.deptId}"  <c:if test="${userUpdate.deptId == dept.id}">selected</c:if>>${dept.name}</option>
                    </c:forEach>--%>
                </select>
            </div>
            <div class="form-group">
                <label>账号</label>
                <input type="text" class="form-control" id="account" name="account" value="${userUpdate.account}">
            </div>
            <div class="form-group">
                <label>姓名</label>
                <input type="text" class="form-control" id="name" name="name"  value="${userUpdate.name}">
            </div>
            <div class="form-group">
                <label>年龄${userUpdate.age}</label>
                <input type="text" class="form-control" id="age" name="age" value="${userUpdate.age}">
            </div>
            <div class="form-group">
                <label>性别</label>
                <input type="radio" id="male" name="sex" <c:if test="${userUpdate.sex == 1}"> checked</c:if> value="1"><label for="male">男</label>
                <input type="radio" id="female" name="sex" <c:if test="${userUpdate.sex == 0}"> checked</c:if>  value="0"><label for="female">女</label>
            </div>
            <div class="form-group">
                <label>邮箱</label>
                <input type="text" class="form-control" id="email" name="email" required value="${userUpdate.email}">
            </div>
            <div class="form-group">
                <label>出生日期</label>
                <input type="date" class="form-control" id="birthDate" name="birthDate" value="${userUpdate.birthDate}">
            </div>
            <!--居中-->
            <div class="text-center">
                <button type="submit" class="btn btn-primary">保存</button>
                <a href="/sys/user/list" class="btn btn-danger">返回</a>
            </div>
        </form>

    </div>
</div>
</body>

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
        var deptId = ${userUpdate.deptId}
        $.ajax({
            url: "/sys/dept/listAll",
            data: "",
            type: "get",
            dataType: "json",
            success: function (data) {
                var html = '';
                for (var i = 0; i < data.length; i++) {
                    if (deptId == data[i].id){
                        html = html + '<option selected value="' + data[i].id + '">' + data[i].name + '</option>';
                    } else {
                        html = html + '<option  value="' + data[i].id + '">' + data[i].name + '</option>';
                    }
                }
                $("#dept").append(html);
            }
        });

       /* $.validator.addMethod("checkAccount", function (value, element, params) {
            var reg = /^[0-9a-zA-Z]{5,10}$/;
            if (reg.test(value)) {
                return true;
            } else {
                return false;
            }
        });
        $("#form-add").validate({
            rules: {
                account: {
                    checkAccount: ""
                }
            },
            messages: {
                account: {
                    checkAccount: "请输入5-10位的账号！"
                }
            }
        });*/

    });
</script>
</html>
