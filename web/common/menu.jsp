<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>$Title$</title>
    <link rel="stylesheet" href="static/plug-in/vendor/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="static/plug-in/vendor/font-awesome/css/font-awesome.min.css">
    <!-- Custom Font Icons CSS-->
    <link rel="stylesheet" href="static/plug-in/css/font.css">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="static/plug-in/css/style.default.css" id="theme-stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="static/plug-in/css/custom.css">
</head>
<body>
<nav id="sidebar">
    <!-- Sidebar Header-->
    <div class="sidebar-header d-flex align-items-center">
        <div id="avatar" class="avatar"><img src="../static/plug-in/img/avatar-6.jpg" alt="..." class="img-fluid rounded-circle"></div>
        <div class="title">
            <h1 class="h5">小标</h1>
            <p>研发部</p>
        </div>
    </div>
    <ul class="list-unstyled" id="div-menu">
        <li class="active"><a href="home.jsp"> <i class="icon-home"></i>主页 </a></li>
        <%--后台菜单--%>

    </ul>

</nav>
</body>
<script src="../static/js/jquery-3.3.1.js"></script>
<script>
    $(function () {
        $.ajax({
            url: "/sys/menu",
            type: "get",
            data: "",
            dataType: "json",
            success: function (data) {
                var parent = data.parent;
                var son = data.son;
                var html = "";
                for (var i = 0; i < parent.length; i++) {
                    html = html + '<li><a href="#depDropdown"  data-toggle="collapse"><i class="icon-windows"></i>' + parent[i].name +'</a>';
                    for (var j = 0; j < son.length; j++) {
                        if (parent[i].id == son[j].pId) {
                            html = html + '<ul id="depDropdown" class="collapse list-unstyled "><li><a href="' + son[j].menuUrl + '">'+ son[j].name + '</a></li></ul>';
                        }
                    }
                    html = html + '</li>';
                }
                $("#div-menu").append(html);
            }
        });
    });
</script>
</html>
