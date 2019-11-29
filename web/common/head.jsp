<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="static/plug-in/vendor/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="static/plug-in/vendor/font-awesome/css/font-awesome.min.css">
    <!-- Custom Font Icons CSS-->
    <link rel="stylesheet" href="static/plug-in/css/font.css">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="static/plug-in/css/style.default.css" id="theme-stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="static/plug-in/css/custom.css">
    <title>主页</title>
</head>
<body>
<header class="header">
    <nav class="navbar navbar-expand-lg">
        <div class="search-panel">
            <div class="search-inner d-flex align-items-center justify-content-center">
                <div class="close-btn">Close <i class="fa fa-close"></i></div>
                <form id="searchForm" action="#">
                    <div class="form-group">
                        <input type="search" name="search" placeholder="What are you searching for...">
                        <button type="submit" class="submit">Search</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="container-fluid d-flex align-items-center justify-content-between">
            <div class="navbar-header">
                <!-- Navbar Header--><a href="" class="navbar-brand">
                <div class="brand-text brand-big visible text-uppercase"><strong class="text-primary">小标</strong><strong>交友</strong></div>
                <div class="brand-text brand-sm"><strong class="text-primary">X</strong><strong>B</strong></div></a>
                <!-- Sidebar Toggle Btn-->
                <button class="sidebar-toggle"><i class="fa fa-long-arrow-left"></i></button>
            </div>
            <div class="right-menu list-inline no-margin-bottom">
                <!-- Log out -->
                <div class="list-inline-item logout">
                    <a id="logout" href="../index.jsp" class="nav-link"><span class="d-none d-sm-inline">退出 </span></a>
                </div>
            </div>
        </div>
    </nav>
</header>
</body>

<script src="static/plug-in/vendor/jquery/jquery.min.js"></script>
<script src="static/plug-in/vendor/popper.js/umd/popper.min.js"> </script>
<script src="static/plug-in/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="static/plug-in/vendor/jquery.cookie/jquery.cookie.js"> </script>
<script src="static/plug-in/vendor/chart.js/Chart.min.js"></script>
<script src="static/plug-in/vendor/jquery-validation/jquery.validate.min.js"></script>
<script src="static/plug-in/js/charts-home.js"></script>
<script src="static/plug-in/js/front.js"></script>
<script src="static/plug-in/js/custom.js"></script>
</html>
