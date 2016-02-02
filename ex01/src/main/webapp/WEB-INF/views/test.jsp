<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#modDiv{
	width:300px;
	height: 100px;
	background-color: aqua;
	position: absolute;
	top: 50%;
	left:50%;
	margin-top: -50px;
	margin-left: -150px;
	padding: 10px;
	z-index: 1000; 
}

</style>
</head>
<body>
	<h2>Ajax 연습</h2>
	
	

	<div>
		<div>
		REPLYTEXT <input type="text" name="replyText" id="newReplyText">
		</div>
		<div>
		REPLYER <input type="text" name="replyer" id="newReplyWriter">
		</div>
		<button id="replyAddBtn">ADD REPLY</button>
	
	</div>
	
	
	
	<ul id="replies">
	
	</ul>
	
	<ul class="pagination">
	
	</ul>

	<div id="modDiv" style="display: none;">
		<div class="modal-title">
		
		</div>
	
		<div>
			<input type="text" id="replyText">
		</div>
		<div>
			<button type="button" id="replyModBtn">Modify</button>
			<button type="button" id="replyDelBtn">DELETE</button>
			<button type="button" id="closeBtn">Close</button>
		</div>
		
	</div>


	<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
	<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

	<script>
	 var bno= 4682;
	 
	
	
	var replyPage=1;
	
	
	 
 function printPaging(pageMaker){
		 
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
		 
		 $('.pagination').html(str);
	 }
	
	 function getPageList(page){
		
		 console.log("페이지 처리 하는 거다")
		 $.getJSON("/replies/all/"+bno+"/"+page,function(data){
			 
			 console.log(data.list.length);
			 
			 var str = "";
			 
			 $(data.list).each(function(){
			
				 str +="<li data-rno='"+this.rno+"'class='replyLi'>"
				 +this.rno+" : "+this.replyText+"<button>MOD</button></li>";
				 
			 });
			 
			 $("#replies").html(str);
			 
			 printPaging(data.pageMaker);
			 console.log("잘 넘겨줌")
		 });
		 
	 };
	 
	 getPageList(1);
	 
	
	 $(".pagination").on("click","li a",function(event){
			
			event.preventDefault();
			replyPage = $(this).attr("href");
			getPageList(replyPage);
			
		});
	 
	
	 function getAllList(){
	 
	 $.getJSON("/replies/all/"+bno, function(data){
			 
		console.log(data.length);
		 
		var str ="";
		
		$(data).each(function(){
			
		str += "<li data-rno='"+this.rno+"' class= 'replyLi' >"
			+this.rno+" : "+this.replyText+"<button>mod</button></li>";
				
		});
		
		$("#replies").html(str);
	 });
	 
	 };
	 
	// getAllList();
	 
	 
	 
	 
	 
	 $("#replies").on("click",".replyLi button",function(){
		 
		 var reply = $(this).parent();
		 console.log("this.parent: "+reply);
		 
		 var rno = reply.attr("data-rno");
		 
		 console.log(rno);
		 
		 var replyText = reply.text();
		
		 //alert(rno+" : "+replyText);

		 $(".modal-title").html(rno);
		 $("#replyText").val(replyText);
		 $("#modDiv").show("slow");
		 
	 });
	 
	 
	 $("#closeBtn").on("click",function(){
		 
		 $("#modDiv").hide("slow");
		 
	 });
	 
	 
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
					$("#modDiv").hide("slow");
					getAllList();
				} 
			 }
		 });
		 
	 });
	 
	 $("#replyModBtn").on("click",function(){
		 
		 var rno = $(".modal-title").html();
		 var replyText = $("#replyText").val();
		 
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
					$("#modDiv").hide("slow");
					//getAllList();
					//여기 마음에 걸린다-----------------------------------
							
					getPageList(replyPage);
					
				} 
			 }
		 });
		 
	 });
	 
 	$("#replyAddBtn").on("click",function(){
 		
 		var replyer = $("#newReplyWriter").val();
 		var replyText = $("#newReplyText").val();
 		
 		console.log("REPLYER: "+replyer);
 		console.log("REPLYTEXT: "+replyText);
 		
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
 					getAllList();
 				}
 			}
 			
 		});
 		
 	});
 
	</script>

</body>
</html>