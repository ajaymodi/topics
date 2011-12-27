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
	<title>Spring MVC 3: jqGrid and MongoDB Integration Tutorial</title>
	
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
				{ 	caption:"Edit", 
					buttonicon:"ui-icon-pencil", 
					onClickButton: editRow,
					position: "last", 
					title:"", 
					cursor: "pointer"
				} 
		);
		
		

		
		
	});
</script>
  

<script type="text/javascript">

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
</script>
  
<div id="jqgrid">
	<table id="grid"></table>
	<div id="pager"></div>
</div>

<div id="dialog" title="Feature not supported" style="display:none">
	<p>That feature is not supported.</p>
</div>

<div id="dialogSelectRow" title="Warning" style="display:none">
	<p>Please select row</p>
</div>

</body>

</html>

