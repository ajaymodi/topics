<!DOCTYPE html>
 <!--  <%@include file="users1.jsp"%>
-->
<html lang="en">
<head>
	<title></title>
	<meta charset="utf-8">
	<link rel="stylesheet" href="css/reset.css" type="text/css" media="all">
	<link rel="stylesheet" href="css/grid.css" type="text/css" media="all">
	<link rel="stylesheet" href="css/style.css" type="text/css" media="all">
	<link rel="stylesheet" href="css/jquery-ui-1.8.5.custom.css" type="text/css" media="all">
        
	<script type="text/javascript" src="js/jquery-1.4.2.min.js" ></script>
	<script type="text/javascript" src="js/jquery.cycle.all.js"></script>
	<script type="text/javascript" src="js/jquery-ui-1.8.5.custom.min.js"></script>
        <script type="text/javascript" src="users.jsp"></script>
        
	<!--[if lt IE 9]>
		<script type="text/javascript" src="js/html5.js"></script>
	<![endif]-->
</head>

<body>
	<header>
		<nav>
			<div class="container">
				<div class="wrapper">
					<h1><a href="index.html"><strong>News Reader</strong></a></h1>
					<ul>
						<li><a href="index.html" class="current" target="content">about</a></li>
						<li><a href="index-1.html">world</a></li>
						<li><a href="index-2.html">people</a></li>
						<li><a href="index-3.html">friends</a></li>
					</ul>
				</div>
			</div>
		</nav>
		<section class="adv-content">
			<div class="container">
                <!--  
                            <input  id="btn" type="button" value="pick a category" onclick="window.open('users.jsp')" >
-->

<input  id="btn" type="button" value="pick a category" onclick=" editRow();" >

				<ul class="breadcrumbs">
				</ul>
				<form action="users1.jsp" id="search-form">
					<fieldset>
                                                  <input type="hidden" name="userName" value="Jeff">
						<input type="text" value=""><input type="submit" value="">
				  </fieldset>

				</form>
                
			</div>
		</section>
        </header>
</body>
</html>