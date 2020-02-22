<!-- Questions Modal -->
<div class="modal fade" id="questionsForm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Communications</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        	<form method="post" id="QuestionsAndAnswersForm" action="/tender/addQuestion">
    			<% if $getQuestionsAndAnswers($Tender.ID,$CurrentMember.ID) %>
    					<div class="form-group row">
      						<div class="col-sm-1">
       							Q{$Subtract($getQuestionsAndAnswers($Tender.ID,$CurrentMember.ID).count,-1)}
   							</div>
   							<div class="col-sm-4">
       							<textarea class="form-control" rows="5" class="form-control" name="Question" id="inputQuestion" placeholder="Question" <% if not $CurrentMember %>disabled<% end_if %> required>$FormData.Question</textarea>
   							</div>
   							<div class="col-sm-4">
   								<% if $CurrentMember.ID %>
   									<div id="QuestionDocUpload">Upload</div>
   								<% else %>
   									<div id="DummyUpload">Upload</div>
   								<% end_if %>
   							</div>
   							
   							<div class="col-sm-3">
       							<button type="submit" <% if not $CurrentMember %>disabled<% end_if %> class="btn btn-primary btn-sm">Submit</button>
   							</div>
    					</div>
    				<% loop $getQuestionsAndAnswers($Tender.ID,$CurrentMember.ID) %>
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
   							<div class="col-sm-8">
       							$Answer
   							</div>
   							<div class="col-sm-3">
   								<% if $AnswerDocumentID %>
       								<a href="/home/download/$AnswerDocumentID" class="btn btn-primary btn-sm" role="button">Doc</a>
       							<% else %>
       								&nbsp;
       							<% end_if %>
   							</div>
    					</div>
    				<% end_loop %>
    			<% else %>
    				<div class="form-group row">
      						<div class="col-sm-1">
       							Q1
   							</div>
   							<div class="col-sm-4">
       							<textarea class="form-control" rows="5" class="form-control" name="Question" <% if not $CurrentMember %>disabled<% end_if %> id="inputQuestion" placeholder="Question" required>$FormData.Question</textarea>
   							</div>
   							<div class="col-sm-4">
       							<% if $CurrentMember.ID %>
   									<div id="QuestionDocUpload">Upload</div>
   								<% else %>
   									<div id="DummyUpload">Upload</div>
   								<% end_if %>
   							</div>
   							
   							<div class="col-sm-3">
       							<button type="submit" <% if not $CurrentMember %>disabled<% end_if %> class="btn btn-primary btn-sm">Submit</button>
   							</div>
    					</div>	
    			<% end_if %>
    			<input type="hidden" name="TenderID" value="{$Tender.ID}" />
    			<input type="hidden" name="SubmissionID" value="{$ID}" />
    			<input type="hidden" id="inputQaAID" name="QaAID" value="$QaA.ID" />
    	    </form>
      </div>  
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>