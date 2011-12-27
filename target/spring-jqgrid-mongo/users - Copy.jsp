<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:url value="spring-jqgrid-mongo" var="baseUrl"/>

<head>
	<link rel="stylesheet" type="text/css" media="screen" href="/${baseUrl}/resources/css/jquery/ui-lightness/jquery-ui-1.8.6.custom.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="/${baseUrl}/resources/css/jqgrid/ui.jqgrid.css" />

	<script type="text/javascript" src="/${baseUrl}/resources/js/jquery/jquery-1.4.4.min.js"></script>
	<script type="text/javascript">
	    var jq = jQuery.noConflict();
	</script>
	<script type="text/javascript" src="/${baseUrl}/resources/js/jquery/jquery-ui-1.8.6.custom.min.js"></script> 
	<script type="text/javascript" src="/${baseUrl}/resources/js/jqgrid/grid.locale-en.js" ></script>
	<script type="text/javascript" src="/${baseUrl}/resources/js/jqgrid/jquery.jqGrid.min.js"></script>
	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title></title>
        <meta charset="utf-8"></meta>
        <link rel="stylesheet" href="css/reset.css" type="text/css" media="all"></link>
            <link rel="stylesheet" href="css/grid.css" type="text/css" media="all"></link>
            <link rel="stylesheet" href="css/style.css" type="text/css" media="all"></link>
	<link rel="stylesheet" href="css/jquery-ui-1.8.5.custom.css" type="text/css" media="all">
        </link>
	<script type="text/javascript" src="js/jquery-1.4.2.min.js" ></script>
	<script type="text/javascript" src="js/jquery.cycle.all.js"></script>
	<script type="text/javascript" src="js/jquery-ui-1.8.5.custom.min.js"></script>

	<!--[if lt IE 9]>
		<script type="text/javascript" src="js/html5.js"></script>
	<![endif]-->
	<title>NewsReader </title>
	
</head>

<body >




<script type="text/javascript">
	jq(function() {
		jq("#grid").jqGrid({
		   	url:'/${baseUrl}/krams/crud',
			datatype: 'json',
			mtype: 'GET',
		   	colNames:['Id', 'User Name', 'Categories', 'Like'],
		   	colModel:[
		   		{name:'id',index:'id', width:55,editable:false,editoptions:{readonly:true,size:10},hidden:false},
		   		{name:'userName',index:'categories', width:100,editable:true, editrules:{required:true}, editoptions:{size:10}},
		   		{name:'categories',index:'like', width:100,editable:true, editrules:{required:true}, editoptions:{size:10}},
                {name:'like',index:'userName', width:100,editable:true, editrules:{required:true}, editoptions:{size:10}}
		   	],
		   	postData: { 
			},
			rowNum:20,
		   	rowList:[20,40,60],
		   	height: 200,
		   	autowidth: true,
			rownumbers: true,
		   	pager: '#pager',
		   	sortname: 'id',
		    viewrecords: true,
		    sortorder: "asc",
		    caption:"Users",
		    emptyrecords: "Empty records",
		    loadonce: false,
		    loadComplete: function() {
			},
		    jsonReader : {
		        root: "rows",
		        page: "page",
		        total: "total",
		        records: "records",
		        repeatitems: false,
		        cell: "cell",
		        id: "id"
		    }
		});
		jq("#grid").jqGrid('navGrid','#pager',
				{edit:false,add:false,del:false,search:true},
				{ },
		        { },
		        { }, 
				{ 
			    	sopt:['eq', 'ne', 'lt', 'gt', 'cn', 'bw', 'ew'],
			        closeOnEscape: true, 
			        	multipleSearch: true, 
			         	closeAfterSearch: true }
		);


		
		jq("#grid").navButtonAdd('#pager',
				{ 	caption:"Add", 
					buttonicon:"ui-icon-plus", 
					onClickButton: addRow,
					position: "last", 
					title:"", 
					cursor: "pointer"
				} 
		);
		
		jq("#grid").navButtonAdd('#pager',
				{ 	caption:"Edit", 
					buttonicon:"ui-icon-pencil", 
					onClickButton: editRow,
					position: "last", 
					title:"", 
					cursor: "pointer"
				} 
		);
		
		jq("#grid").navButtonAdd('#pager',
			{ 	caption:"Delete", 
				buttonicon:"ui-icon-trash", 
				onClickButton: deleteRow,
				position: "last", 
				title:"", 
				cursor: "pointer"
			} 
		);

		jq("#btnFilter").click(function(){
			jq("#grid").jqGrid('searchGrid',
					{multipleSearch: false, 
						sopt:['eq']}
			);
		});

		// Toolbar Search
		jq("#grid").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : true, defaultSearch:"cn"});

	});
</script>
  

<script type="text/javascript">

function addRow() {

	// Get the currently selected row
    jq("#grid").jqGrid('editGridRow','new',
    		{ 	url: "/${baseUrl}/krams/crud/add", 
					editData: {
			    },
			    recreateForm: true,
			    beforeShowForm: function(form) {
			    },
				closeAfterAdd: true,
				reloadAfterSubmit:false,
				afterSubmit : function(response, postdata) 
				{ 
			        var result = eval('(' + response.responseText + ')');
					var errors = "";
					
			        if (result.success == false) {
						for (var i = 0; i < result.message.length; i++) {
							errors +=  result.message[i] + "<br/>";
						}
			        }  else {
			        	jq("#dialog").text('Entry has been added successfully');
						jq("#dialog").dialog( 
								{	title: 'Success',
									modal: true,
									buttons: {"Ok": function()  {
										jq(this).dialog("close");} 
									}
								});
	                }
			    	// only used for adding new records
			    	var new_id = null;
			    	
					return [result.success, errors, new_id];
				}
    		});

}

function editRow() {
	// Get the currently selected row
	var row = jq("#grid").jqGrid('getGridParam','selrow');
	
	if( row != null ) 
		jq("#grid").jqGrid('editGridRow',row,
			{	url: "/${baseUrl}/krams/crud/edit", 
				editData: {
		        },
		        recreateForm: true,
		        beforeShowForm: function(form) {
		        },
				closeAfterEdit: true,
				reloadAfterSubmit:false,
				afterSubmit : function(response, postdata) 
				{ 
		            var result = eval('(' + response.responseText + ')');
					var errors = "";
					
		            if (result.success == false) {
						for (var i = 0; i < result.message.length; i++) {
							errors +=  result.message[i] + "<br/>";
						}
		            }  else {
		            	jq("#dialog").text('Entry has been edited successfully');
						jq("#dialog").dialog( 
								{	title: 'Success',
									modal: true,
									buttons: {"Ok": function()  {
										jq(this).dialog("close");} 
									}
								});
	                }
		        	
					return [result.success, errors, null];
				}
			});
	else jq( "#dialogSelectRow" ).dialog();
}

function deleteRow() {
	// Get the currently selected row
    var row = jq("#grid").jqGrid('getGridParam','selrow');

    // A pop-up dialog will appear to confirm the selected action
	if( row != null ) 
		jq("#grid").jqGrid( 'delGridRow', row,
          	{ url: '/${baseUrl}/krams/crud/delete', 
						recreateForm: true,
			            beforeShowForm: function(form) {
			              //change title
			              jq(".delmsg").replaceWith('<span style="white-space: pre;">' +
			            		  'Delete selected record?' + '</span>');
	            		  
						  //hide arrows
			              jq('#pData').hide();  
			              jq('#nData').hide();  
			            },
          				reloadAfterSubmit:false,
          				closeAfterDelete: true,
          				afterSubmit : function(response, postdata) 
						{ 
			                var result = eval('(' + response.responseText + ')');
							var errors = "";
							
			                if (result.success == false) {
								for (var i = 0; i < result.message.length; i++) {
									errors +=  result.message[i] + "<br/>";
								}
			                }  else {
			                	jq("#dialog").text('Entry has been deleted successfully');
								jq("#dialog").dialog( 
										{	title: 'Success',
											modal: true,
											buttons: {"Ok": function()  {
												jq(this).dialog("close");} 
											}
										});
			                }
		                	// only used for adding new records
		                	var new_id = null;
		                	
							return [result.success, errors, new_id];
						}
          	});
	 else jq( "#dialogSelectRow" ).dialog();
}

</script>  
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

                            <input  id="btn" type="button" value="pick a category" onclick="window.open('jsp/users.jsp')" >
                            </input>
				<ul class="breadcrumbs">
				</ul>
				<form action="" id="search-form">
					<fieldset>

                                            <input type="text" value=""></input><input type="submit" value=""></input>
				  </fieldset>
				</form>
			</div>
		</section>
        </header>

    <input type="button" value="edit category" onclick="editRow()" > </input>

    <div  id="jqgrid" >
	<table id="grid" hidden="true" ></table>
	<div id="pager" hidden="true" ></div>
    </div>
<div id="dialog" title="Feature not supported" style="display:none">
	<p>That feature is not supported.</p>
</div>

<div id="dialogSelectRow" title="Warning" style="display:none">
	<p>Please select row</p>
</div>

</body>

</html>

