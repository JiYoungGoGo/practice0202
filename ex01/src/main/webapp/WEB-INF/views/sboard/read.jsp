<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../include/header.jsp"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.5/handlebars.js"></script>
<!------------------------------ Main content -------------------------------->
<section class="content">
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">

			<!-- general from elements -->
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">조회페이지!</h3>

					<form role="form" method="post">

						<input type="hidden" name="bno" value="${VO.bno}"/> 
						<input type="hidden" name="page" value="${cri.page }"/>
						<input type="hidden" name="perPageNum" value="${cri.perPageNum }"/>
						<input type="hidden" name="searchType" value="${cri.searchType }">
						<input type="hidden" name="keyword" value="${cri.keyword }">

					</form>



					<div class="box-body">


						<!-- ------------------------------------- -->

						<div id="modifyModal" class="modal modal-primary fade" role="dialog">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">
										&times;
										</button>
									<h4 class="modal-title"></h4>
									</div>
									<div class="modal-body" data-rno>
									 <p><input type="text" id="replyText" class="form-control"></p>
									</div>
									<div class="modal-footer">
									<button type="button" class="btn btn-info" id="replyModBtn" data-dismiss="modal">Modify</button>
									<button type="button" class="btn btn-danger" id="replyDelBtn"data-dismiss="modal">Delete</button>
									<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									</div>
								
								</div>
							
							</div>
						</div>


						<!-- ------------------------------------- -->
						<div class="form-group">
							<label for="exampleInputEmail1">Title</label> <input type="text"
								name="title" class="form-control" readonly="readonly"
								value="${VO.title }">
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">Content</label>
							<textarea class="form-control" name="text" rows="3"
								readonly="readonly"> ${VO.text} </textarea>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Writer</label> <input type="text"
								name="writer" class="form-control" value="${VO.writer}"
								readonly="readonly">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Criteria</label> <input
								type="text" name="writer" class="form-control"
								value="${cri.page}" readonly="readonly">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Criteria</label> <input
								type="text" name="writer" class="form-control"
								value="${cri.perPageNum}" readonly="readonly">
						</div>
					</div>
					<!-- /box-body -->

					<div class="box-footer">
						<button type="submit" class="btn btn-warnion">수정</button>
						<button type="submit" class="btn btn-danger" id="viewDelete">삭제</button>
						<button type="submit" class="btn btn-primary" id="btn-list">목록</button>

					</div>


					
						<div class="box box-success">
							<div class="box-header">
							 <h3 class="box-title">ADD NEW REPLY</h3>
							</div>

							<div class="box-body">
								<lavel for="exampleInputEmail1">writer</lavel>
								<input class="form-control" type="text" placeholder="USER ID"  id="newReplyWriter">
								<lavel for="exampleInputEmail1">Reply Text</lavel>
								<input class="form-control" type="text" placeholder="REPLY TEXT" id="newReplyText">
								
							</div>
						
						<div class="box-footer">
							<button type="button" class="btn btn-primary" id="replyAddBrn">ADD REPLY</button>
						</div>
						
						</div>

						<ul class="timeline">
							<li class="time-label" id="repliesDiv"><span class="bg-green">Replies List</span></li>
						</ul>
						<div class="text-center">
							<ul id="pagination" class="pagination pagination-sm no-margin"> </ul>
						</div>
						
						



				</div>

			</div>

		</div>
		<!-- /.col(left) -->

	</div>
	<!-- /.row -->

</section>
<!-- /.content -->




<%@include file="../include/footer.jsp"%>

<script id="template" type="text/x-handlebars-template">
{{#each.}}

<li class="replyLi" data-rno={{rno}}>
<i class="fa fa-comments bg-blue"></i>
	<div class="timeline-item">
		<span class="time">
			<i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
		</span>
		<h3 class="timeline-header"> <strong>{{rno}}</strong> -{{replyer}}</h3>
		<div class="timeline-body">
		{{replyText}}
		</div>
			<div class="timeline-footer">
				<a class="btn btn-primary btn-xs" data-toggle="modal" data-target="#modifyModal">
				Modify 
				</a>
			</div>
	</div>
</li>

{{/each}}
</script>



<script>


	$(document).ready(function() {
		var bno =${VO.bno};
		console.log(bno);
		
		var replyPage=1;
		//======
			
			
			$(".timeline").on("click",".replyLi",function(event){
				console.log("수정중..");
				var reply = $(this);
				
				$("#replyText").val(reply.find('.timeline-body').text());
				
				$(".modal-title").html(reply.attr("data-rno"));
				console.log("수정중.."+reply.attr("data-rno"));
				
			});
		
		
		
		//--------------
		
		 $("#replyDelBtn").on("click",function(){
		 
		 var rno = $(".modal-title").html();
		 var replyText = $("#replyText").val();
		 
		 $.ajax({
			 type:'delete',
			 url:"/replies/"+rno,
			 headers:{
				 "Content-Type":"application/json",
				 "X-HTTP-Method-Override":"DELETE"
			 },
			 dataType:'text',
			 success:function(result){
				 console.log("result: "+result);
				if(result =="SUCCESS"){
					alert("삭제함.");
					
					getPage("/replies/all/"+bno+"/"+replyPage);
					
					
				} 
			 }
		 });
		 
	 });
		
		//==========
		
		
		$("#replyModBtn").on("click",function(){
		 
		 var rno = $(".modal-title").html();
		 console.log("rno:"+rno);
		 
		 var replyText = $("#replyText").val();
		 
		 console.log("replyText:"+replyText);
		 
		 $.ajax({
			 type:'put',
			 url:"/replies/"+rno,
			 headers:{
				 "Content-Type":"application/json",
				 "X-HTTP-Method-Override":"PUT"
			 },
			 data:JSON.stringify({replyText:replyText}),
			 dataType:'text',
			 success:function(result){
				 console.log("result: "+result);
				if(result =="SUCCESS"){
					alert("수정함.");
				
					getPage("/replies/all/"+bno+"/"+replyPage);
					
				} 
			 }
		 });
		 
	 });		
		
		
		
		//=======
			
			
			
			
			$("#replyAddBrn").on("click",function(){
				
				var replyerObj = $("#newReplyWriter");
				console.log("이제 만들거야 댓글"+replyerObj);
				var replyTextObj = $("#newReplyText");
				var replyer = replyerObj.val();
				var replyText = replyTextObj.val();
				console.log(replyer);
				console.log(replyText);
				
				$.ajax({
		 			type:'post',
		 			url:'/replies',
		 			headers:{
		 				"content-type" : "application/json",
		 				"X-HTTP-method-Override":"POST"
		 			},
		 			dataType :'text',
		 			data : JSON.stringify({
		 				bno:bno,
		 				replyer:replyer,
		 				replyText:replyText
		 			}),
		 			success:function(result){
		 				if(result =='SUCCESS'){
		 					alert("등록되었다");
		 					replyPage=1;
		 					getPage("/replies/all/"+bno+"/"+replyPage);
		 					replyerObj.val("");
		 					replyTextObj.val("");
		 				}
		 			}
		 			
		 		});
				
			});
			
			
		
		//=======
		
		Handlebars.registerHelper("prettifyDate",function(timeValue){
			
			console.log("핸들바 만들기");
			var dateObj = new Date(timeValue);
			var year = dateObj.getFullYear();
			var month = dateObj.getMonth()+1;
			var date = dateObj.getDate();
			return year+"/"+month+"/"+date;
			
		});


		var printData = function(replyArr,target,templateObject){
			
			console.log("핸들바쪽 작업");
			
			var template = Handlebars.compile(templateObject.html());
			
			var html = template(replyArr);
			$(".replyLi").remove();
			target.after(html);
			
		}
			
		//==========
		
		
		
		
		function getPage(pageInfo){
			console.log("getPage되고 있는가");
			$.getJSON(pageInfo,function(data){
				printData(data.list,$("#repliesDiv"),$('#template'));
				printPaging(data.pageMaker,$(".pagination"));
			});
		}
		
		
		var printPaging = function (pageMaker,target){
			 
			 console.log("여긴 printPaging이다");
			 
			 var str ="";
			 
			 if(pageMaker.prev){
				 str +="<li><a href='"+(pageMaker.startPage-1)+"'> << </a></li> ";
				 }
			 for (var i = pageMaker.startPage,len=pageMaker.endPage; i <= len; i++) {
				var strClass = pageMaker.cri.page==i?'class=active':'';
				str+="<li "+strClass+"><a href='"+i+"'>"+i+"</a></li>"; 
			}
			 if(pageMaker.next){
				 str+="<li><a href='"+(pageMaker.endPage+1)+"'> >> </a></li>";
				 
			 }
			 
			 target.html(str);
		 }

			
		
		//============
		
		$("#repliesDiv").on("click",function(){
			
			if($(".timeline li").size()>1){
				return;
			}
			
			getPage("/replies/all/"+bno+"/1");
			
		});
			
		
		$(".pagination").on("click","li a",function(event){
			
			event.preventDefault();
			replyPage = $(this).attr("href");
			getPage("/replies/all/"+bno+"/"+replyPage);
			
			
		});
		
			
			
		//===========
		var formObj = $("form[role='form']");

		console.log("FORMOBJ: " + formObj);

		$(".btn-warnion").on("click", function() {
			formObj.attr("action", "/sboard/modify");
			formObj.attr("method", "get");
			formObj.submit();

		});

		$("#viewDelete").on("click", function() {
			formObj.attr("action", "/sboard/remove");
			formObj.submit();

		});

		$("#btn-list").on("click", function() {
			//self.location = "/board/list";
			formObj.attr("method", "get");
			formObj.attr("action", "/sboard/list");
			formObj.submit();

		});

	});
	
	var str ='${msg}';
	
	if(str == "MODIFY"){
		alert("수정되었습니다. ");
	}
	
</script>
</body>
</html>