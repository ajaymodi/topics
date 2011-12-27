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
