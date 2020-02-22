<!-- Answers Modal -->
<div class="modal fade answersForm" id="answersForm_{$TenderID}_{$ID}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Communications</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
			<% if $getQuestionsAndAnswers($TenderID,$ContractorID,true) %>
    			<% loop $getQuestionsAndAnswers($TenderID,$ContractorID,true) %>
    				<form method="post" class="QuestionsAndAnswersForm" action="/get-prices/postAnswer">
    					<div class="form-group row">
      						<div class="col-sm-1">
       							Q{$Top.Subtract($TotalItems,$Pos(0))}
   							</div>
   							<div class="col-sm-8">
       							<% if $Question %>
       								$Question<% if $ContractorID %> - <i>by $Contractor.FirstName</i><% end_if %>
       							<% else %>
       								Blank Question
       							<% end_if %>
   							</div>
   							<div class="col-sm-3">
       							<% if $QuestionDocumentID %>
       								<a href="/home/download/$QuestionDocumentID" class="btn btn-primary btn-sm" role="button">Doc</a>
       							<% else %>
       								&nbsp;
       							<% end_if %>
   							</div>
    					</div>
    					<div class="form-group row">
      						<div class="col-sm-1">
       							Answer
   							</div>
  							<% if $Answer %> 
   								<div class="col-sm-6">$Answer</div>
   								<% if $AnswerDocumentID %>
   									<div class="col-sm-2">&nbsp;</div>
   								<% else %>
   									<div class="col-sm-2"><div id="AnswerDocUpload_{$Top.TenderID}_{$Top.ID}_{$Top.Subtract($TotalItems,$Pos(0))}">Upload</div></div>
   								<% end_if %>
  								<div class="col-sm-3">
   									<% if $AnswerDocumentID %>
       									<a href="/home/download/$AnswerDocumentID" class="btn btn-primary btn-sm" role="button">Doc</a>
       								<% else %>
       									&nbsp;
       								<% end_if %>
								</div>
   							<% else %>
   								<div class="col-sm-6">
   									<textarea class="form-control" rows="5" class="form-control" name="Answer" id="inputAnswer" placeholder="Answer" required></textarea>
   								</div>
   								<div class="col-sm-2"><div id="AnswerDocUpload_{$Top.TenderID}_{$Top.ID}_{$Top.Subtract($TotalItems,$Pos(0))}">Upload</div></div>
   								<div class="col-sm-3">
   									<% if $ContractorID %><button type="submit" name="action" value="private" class="btn btn-primary btn-sm">Submit to $Contractor.FirstName</button><% end_if %>
  									<button type="submit" name="action" value="public" class="btn btn-primary btn-sm">Submit to All</button>
								</div>
   							<% end_if %>
    					</div>
    					<input type="hidden" name="ID" value="$ID" />
    				</form>
    			<% end_loop %>
    		<% else %>
    			<p>No questions posted yet</p>
    		<% end_if %>
      </div>  
      <div class="modal-footer"></div>
    </div>
  </div>
</div>

<script type="text/javascript">
<% if $getQuestionsAndAnswers($TenderID,$ContractorID,true) %>
   (function($) {
		$("document").ready(function(){
   			<% loop $getQuestionsAndAnswers($TenderID,$ContractorID,true) %>

    			$("#AnswerDocUpload_{$Top.TenderID}_{$Top.ID}_{$Top.Subtract($TotalItems,$Pos(0))}").uploadFile({
					url:"/get-prices/uploadQandADoc",
					multiple:false,
					dragDrop:false,
					maxFileCount:1,
					fileName:"myfile",
					formData: {"TenderID":$Top.TenderID,"SubmissionID":$Top.ID,"QaAID":$ID,"DocType":"AnswerDocumentID"}
				});	
    				
   			<% end_loop %>
		});
	})(jQuery)
<% end_if %>
</script>