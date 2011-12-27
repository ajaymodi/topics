<%@ page import="java.util.*" %>

<html>
<head>
<title>HTML Frames Example - Menu 1</title>
<style type="text/css">
body {
	font-family:verdana,arial,sans-serif;
	font-size:10pt;
	margin:10px;
	background-color:#ff9900;
	}
</style>

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
	<!--[if lt IE 9]>
		<script type="text/javascript" src="js/html5.js"></script>
	<![endif]-->
</head>
<body>
<div class="grid3 first">
		<ul class="categories">
				<%
                         ArrayList al = new ArrayList();
                         al.add("Personal"); 
                         al.add("News"); 
                         al.add("Politics"); 
                         al.add("Sports"); 
                         al.add("Media"); 
                         al.add("Education and Research");

                         al.add("content");
                          int id=al.size();
                          Object ia[] = al.toArray();

                for(int i=0;i<ia.length;i++)
                    {
                       %>
                       <li>&nbsp;
                           <a href="<%=ia[i]%>.jsp" target="content"><%= ia[i]%></a></li>
                <%
                        }
                %>
                                              </ul>
					</div>
</body>
</html>