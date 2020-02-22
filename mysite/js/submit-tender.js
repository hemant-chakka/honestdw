(function($) {
	$("document").ready(function(){


		$(".carousel-control-next-icon,.carousel-control-prev-icon").click(function(event) {
            event.preventDefault();
        });
		
		$("#carouselExampleIndicators .carousel-control-next-icon").click(function(event) {
			$("#carouselExampleIndicators").carousel('next');
        });
		
		$("#carouselExampleIndicators .carousel-control-prev-icon").click(function(event) {
			$("#carouselExampleIndicators").carousel('prev');
        });
		
		$("#carouselExampleIndicators2 .carousel-control-next-icon").click(function(event) {
			$("#carouselExampleIndicators2").carousel('next');
        });
		
		$("#carouselExampleIndicators2 .carousel-control-prev-icon").click(function(event) {
			$("#carouselExampleIndicators2").carousel('prev');
        });
		
		$("#carouselExampleIndicators .zoom-carousal").click(function(event) {
			event.preventDefault();
			$("#carouselExampleIndicators2").carousel($(this).data('serial'));
        });
		
		$("#QuestionDocUpload").uploadFile({
			url:"/tender/uploadQandADoc",
			multiple:false,
			dragDrop:false,
			maxFileCount:1,
			fileName:"myfile",
			formData: {"TenderID":$("#inputTenderID").val(),"SubmissionID":$("#inputSubmissionID").val(),"QaAID":$("#inputQaAID").val(),"DocType":"QuestionDocumentID"}
		});
		
		$("#DummyUpload").uploadFile({
			url:"/tender/dummy",
			multiple:false,
			dragDrop:false,
			maxFileCount:1,
			fileName:"myfile",
			onSelect:function(files)
			{
			    return false;   
			}
			
		});
		
		$("#QuoteUpload").uploadFile({
			url:"/tender/uploadRequiredDoc",
			multiple:true,
			dragDrop:false,
			maxFileCount:qtCount,
			fileName:"myfile",
			formData: {"SubmissionID":$("#inputSubmissionID").val(),"DocType":"QuoteV2"},
			showDelete: true,
			deleteCallback: function (data, pd) {
				for (var i = 0; i < data.length; i++) {
			        $.post("/tender/deleteRequiredDoc", {op: "delete",fileId: data,submitId :$("#inputSubmissionID").val(),doc:"QuoteV2"},
			            function (resp,textStatus, jqXHR) {
			                //Show Message	
			                //alert(resp);
			            });
			    }
			    pd.statusbar.hide(); 

			}
		});
		
		$("#CoverLetterUpload").uploadFile({
			url:"/tender/uploadRequiredDoc",
			multiple:true,
			dragDrop:false,
			maxFileCount:clCount,
			fileName:"myfile",
			formData: {"SubmissionID":$("#inputSubmissionID").val(),"DocType":"CoverLetterV2"},
			showDelete: true,
			deleteCallback: function (data, pd) {
				for (var i = 0; i < data.length; i++) {
			        $.post("/tender/deleteRequiredDoc", {op: "delete",fileId: data,submitId :$("#inputSubmissionID").val(),doc:"CoverLetterV2"},
			            function (resp,textStatus, jqXHR) {
			                //Show Message	
			                //alert(resp);
			            });
			    }
			    pd.statusbar.hide(); 

			},
			onSuccess:function(files,data,xhr,pd)
			{
				clUploaded = 1;
				responseStatus();
			}
		});
		
		
		$("#TenderDocumentUpload").uploadFile({
			url:"/tender/uploadRequiredDoc",
			multiple:true,
			dragDrop:false,
			maxFileCount:tdCount,
			fileName:"myfile",
			formData: {"SubmissionID":$("#inputSubmissionID").val(),"DocType":"TenderDocumentV2"},
			showDelete: true,
			deleteCallback: function (data, pd) {
				for (var i = 0; i < data.length; i++) {
			        $.post("/tender/deleteRequiredDoc", {op: "delete",fileId: data,submitId :$("#inputSubmissionID").val(),doc:"TenderDocumentV2"},
			            function (resp,textStatus, jqXHR) {
			                //Show Message	
			                //alert(resp);
			            });
			    }
			    pd.statusbar.hide(); 

			},
			onSuccess:function(files,data,xhr,pd)
			{
				tdUploaded = 1;
				responseStatus();
			}
		});
		
		$("#HealthSafetyPolicyUpload").uploadFile({
			url:"/tender/uploadRequiredDoc",
			multiple:true,
			dragDrop:false,
			maxFileCount:hspCount,
			fileName:"myfile",
			formData: {"SubmissionID":$("#inputSubmissionID").val(),"DocType":"HealthSafetyPolicyV2"},
			showDelete: true,
			deleteCallback: function (data, pd) {
				for (var i = 0; i < data.length; i++) {
			        $.post("/tender/deleteRequiredDoc", {op: "delete",fileId: data,submitId :$("#inputSubmissionID").val(),doc:"HealthSafetyPolicyV2"},
			            function (resp,textStatus, jqXHR) {
			                //Show Message	
			                //alert(resp);
			            });
			    }
			    pd.statusbar.hide(); 

			},
			onSuccess:function(files,data,xhr,pd)
			{
				hspUploaded = 1;
				responseStatus();
			}
		});
		
		
		$("#DrawingsUpload2").uploadFile({
			url:"/tender/uploadRequiredDoc",
			multiple:true,
			dragDrop:false,
			maxFileCount:dwCount,
			fileName:"myfile",
			formData: {"SubmissionID":$("#inputSubmissionID").val(),"DocType":"DrawingsV2"},
			showDelete: true,
			deleteCallback: function (data, pd) {
				for (var i = 0; i < data.length; i++) {
			        $.post("/tender/deleteRequiredDoc", {op: "delete",fileId: data,submitId :$("#inputSubmissionID").val(),doc:"DrawingsV2"},
			            function (resp,textStatus, jqXHR) {
			                //Show Message	
			                //alert(resp);
			            });
			    }
			    pd.statusbar.hide(); 

			},
			onSuccess:function(files,data,xhr,pd)
			{
				dwUploaded = 1;
				responseStatus();
			}
		});
		
		
		$("#OtherDocumentUpload").uploadFile({
			url:"/tender/uploadRequiredDoc",
			multiple:true,
			dragDrop:false,
			maxFileCount:odCount,
			fileName:"myfile",
			formData: {"SubmissionID":$("#inputSubmissionID").val(),"DocType":"OtherDocumentV2"},
			showDelete: true,
			deleteCallback: function (data, pd) {
				for (var i = 0; i < data.length; i++) {
			        $.post("/tender/deleteRequiredDoc", {op: "delete",fileId: data,submitId :$("#inputSubmissionID").val(),doc:"OtherDocumentV2"},
			            function (resp,textStatus, jqXHR) {
			                //Show Message	
			                //alert(resp);
			            });
			    }
			    pd.statusbar.hide(); 

			},
			onSuccess:function(files,data,xhr,pd)
			{
				odUploaded = 1;
				responseStatus();
			}
		});
		
		
		$("#ScheduleOfPricesUpload2").uploadFile({
			url:"/tender/uploadRequiredDoc",
			multiple:true,
			dragDrop:false,
			maxFileCount:sopCount,
			fileName:"myfile",
			formData: {"SubmissionID":$("#inputSubmissionID").val(),"DocType":"ScheduleOfPricesV2"},
			showDelete: true,
			deleteCallback: function (data, pd) {
				for (var i = 0; i < data.length; i++) {
			        $.post("/tender/deleteRequiredDoc", {op: "delete",fileId: data,submitId :$("#inputSubmissionID").val(),doc:"ScheduleOfPricesV2"},
			            function (resp,textStatus, jqXHR) {
			                //Show Message	
			                //alert(resp);
			            });
			    }
			    pd.statusbar.hide(); 

			},
			afterUploadAll:function(obj)
			{
				sopUploaded = 1;
				responseStatus();
			}
		});
		
$('.doc-read-cb').click( function(){
			
			responseStatus();

		});
		
		function responseStatus(){
			var all = $('.doc-read-cb').length;
			var checked = $('input.doc-read-cb:checked').length;
			
			if(all == checked && clUploaded == 1 && tdUploaded == 1 && hspUploaded == 1 && dwUploaded == 1 && odUploaded == 1 && sopUploaded == 1){
				$( "#DetailedRequiredBtn" ).addClass('btn-success');
				$( "#DetailedRequiredBtn" ).removeClass('btn-danger');
				$('#IAgreeBtn').removeAttr('disabled');
			}else{
				$( "#DetailedRequiredBtn" ).addClass('btn-danger');
				$( "#DetailedRequiredBtn" ).removeClass('btn-success');
				$('#IAgreeBtn').attr('disabled','disabled');
			}
		}
		
		
		var count = $('.doc-read-cb').length;
		
		var check = $('.doc-read-cb input:checked').length;
		
		$( "#inputPriceSubmitted" ).keyup(function() {
			  $('#TenderPriceHolder').html($(this).val());
		});
	});
})(jQuery)