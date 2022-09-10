<%@page import="pms.projectDAO"%>
<%@page import="pms.userVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
<link href="css/styles.css" rel="stylesheet"/>
<title>Insert title here</title>
</head>
<style>
.member-item {
	float:left;
	list-style:none;
	margin-top:10px;
	margin-bottom:10px;
	margin-left:5px;
	margin-right:5px;
	padding:5px;
	display:block;
	background:#626874; 
	color:#fff;
	border-radius: 10px;
}
</style>
<script>
	$(function() {
		var dateFormat = "mm/dd/yy", from = $("#from").datepicker({
			defaultDate : "+1w",
			changeMonth : true,
			numberOfMonths : 1
		}).on("change", function() {
			to.datepicker("option", "minDate", getDate(this));
		}), to = $("#to").datepicker({
			defaultDate : "+1w",
			changeMonth : true,
			numberOfMonths : 1
		}).on("change", function() {
			from.datepicker("option", "maxDate", getDate(this));
		});

		function getDate(element) {
			var date;
			try {
				date = $.datepicker.parseDate(dateFormat, element.value);
			} catch (error) {
				date = null;
			}

			return date;
		}
	});

	var myModal = document.getElementById('myModal')
	var myInput = document.getElementById('myInput')

	myModal.addEventListener('shown.bs.modal', function() {
		myInput.focus()
	})
	
</script>
<!-- 데이트피커 삽입 끝 -->
<%
	String _id = (String) session.getAttribute("id");
%>


<body class="container-fluid">
<jsp:useBean class="pms.userDAO" id="userDAO"></jsp:useBean>
	<div class="row">
		<!-- 사이드바 -->
		<div class="col-sm-2 sidebar">

			<!-- 타이틀  -->
			<a href="#"
				class="navbar-brand d-block mx-auto py-3 mb-4 bottom-border"> <img
				src="img\logowhite.png" width="100%" height="150px"></a>

			<!-- 프로필  -->
			<div class="bottom-border text-center">
				 <img src="uploadImg\<%=_id%>_profileImg.png?" onerror="this.src='img/profile.png'" width="60px" height=60px; class="rounded-circle mr-3">  
				<p><a href="profile_inquiry.jsp" class="profile-text"><%=_id%></a>
				<p><a href="logout.jsp" class="btn logout" style ="font-size: 15px; border: none;">logout</a></p>
			</div>

			<!-- 아이템 목록 -->
			<ul class="navbar-nav flex-cloumn mt-4">
				<li class="nav-item"><a href="project_list.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">프로젝트 목록</a>
				<li class="nav-item"><a href="past_project_list.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">지난
						프로젝트</a>
				<li class="nav-item"><a href="new_project.jsp"
					class="nav-link  p-3 mb-2 sidebar-link current">새 프로젝트</a>
				<li class="nav-item"><a href="project_search.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">프로젝트 참여</a>
			</ul>

		</div>

		<!-- 사이드바 끝  -->

		<div class="col-sm-2"></div>

		<div class="col-sm-10 ml-auto py-auto">
			<!-- 화면 -->
		<div style="padding:30px">
			<h3 class="text-center">프로젝트 생성</h3>
			<hr>
			<div class="center-block">
				<form action="createProject.jsp" method="post" class="form-horizontal" id="member-form">
					<div class="form-group row">
						<div style="display: flex; justify-content: center;">
							<label class="text-center">프로젝트 이름</label>
						</div>
						<div style="display: flex; justify-content: center;">
							<div class="form-inline" style="width:800px;"><input type="text" name="pname" class="form-control" placeholder="새 프로젝트명..."></div>
						</div>
					</div>
					<br>
					<div class="form-group row">
						<div style="display: flex; justify-content: center;">
							<label class="text-center">프로젝트 분류</label>
						</div>
						<div style="display: flex; justify-content: center;">
							<div class="form-inline" style="width:800px;">
								<select class="form-control title" name ="classification">
								<option value="미분류">미분류</option>
								<option value="텀 프로젝트">텀 프로젝트</option>
								<option value="노마드 프로젝트">노마드 프로젝트</option>
								<option value="스타트업 프로젝트">스타트업 프로젝트</option>
							</select>
							</div>
						</div>
					</div>
					<br>
					<div class="form-group row">
						<div style="display: flex; justify-content: center;">
							<label class="text-center">개요</label>
						</div>
						<div style="display: flex; justify-content: center;">
							<div class="form-inline" style="width:800px;"><textarea class="form-control" name="summary" rows="5" placeholder="내용 작성..."></textarea></div>
						</div>
					</div>
					<br>
					<div class="form-group row">
						<div style="display: flex; justify-content: center;">
							<label class="text-center">멤버</label>
						</div>
						<div style="display: flex; justify-content: center;">
							<div class="form-inline" style="width:800px;">
							<input type="text" list="userList" id="member" class="form-control" placeholder="ID로 검색, 스페이스바를 눌러 추가">
								<datalist id="userList">
<%
List userList = userDAO.getAllUser();
String memberlist = "";
for(int i = 0; i < userList.size(); i ++) {
	userVO vo = (userVO) userList.get(i);
	if(i == 0) {
		memberlist = vo.getId();
	} else {
		memberlist += " / " + vo.getId();
	}
%>
									<option value="<%= vo.getId()%>"><%= vo.getId()%></option>

<%
}
%>
								</datalist>
								<div class="form-group">
									<input type="hidden" id="memberdb" value="<%=memberlist%>">
					                <input type="hidden" value="" name="member" id="rdMember" />
					            </div>
					        	<div style="display: flex; justify-content: center;">
					             <ul id="member-list"></ul>
					            </div>
					             <script>
    $(document).ready(function () {
        var member = {};
        var counter = 0;

        // 입력한 값을 태그로 생성한다.
        function addMember (value) {
            member[counter] = value;
            counter++; // del-btn 의 고유 id 가 된다.
        }

        // member 안에 있는 값을 array type 으로 만들어서 넘긴다.
        function marginMember () {
            return Object.values(member).filter(function (word) {
                return word !== "";
            });
        }
    
        // 서버에 제공
        $("#member-form").on("submit", function (e) {
            var value = marginMember(); // return array
            $("#rdMember").val(value); 

            $(this).submit();
        });

        $("#member").on("keypress", function (e) {
            var self = $(this);
			
            //엔터나 스페이스바 눌렀을때 실행
            if (e.key === "Enter" || e.keyCode == 32) {

                var memberValue = self.val(); // 값 가져오기

                // 해시태그 값 없으면 실행X
                if (memberValue !== "") {

                    // 같은 태그가 있는지 검사한다. 있다면 해당값이 array 로 return 된다.
                    var result = Object.values(member).filter(function (word) {
                        return word === memberValue;
                    })
                    
                    var db = document.getElementById('memberdb').value;
                    // DB에 존재하는 사용자인지 확인
                     if(db.includes(memberValue)) {
                    	// 해시태그가 중복되었는지 확인
                         if (result.length == 0) {
                             $("#member-list").append("<li class='member-item'>"+memberValue+"<span class='del-btn' idx='"+counter+"'> x </span></li>");
                             addMember(memberValue);
                             self.val("");
                         } else {
                         	alert("이미 입력한 사용자입니다.");
                         	self.val("");
                         }
                     } else {
                    	 alert("등록되지 않은 사용자입니다.");
                    	 self.val("");
                     }
                    
                }
                e.preventDefault(); // SpaceBar 시 빈공간이 생기지 않도록 방지
            }
        });

        // 삭제 버튼 
        // 인덱스 검사 후 삭제
        $(document).on("click", ".del-btn", function (e) {
            var index = $(this).attr("idx");
            member[index] = "";
            $(this).parent().remove();
        });
})
</script>
						</div>
					</div>
					</div>
					<br>
					<div class="form-group row">
						<div style="display: flex; justify-content: center;">
								<label class="text-center">비밀번호</label>
							</div>
							<div style="display: flex; justify-content: center;">
								<div class="form-inline" style="width:300px;"><input type="text" name = "password" class="form-control" placeholder="비밀번호"></div>
							</div>
					</div>
					<br>
					<div class="form-group row">
						<div style="display: flex; justify-content: center;">
							<label class="text-center">기간 설정</label>
						</div>
						<div style="display: flex; justify-content: center;">
							<div class="form-inline row" style="width:415px;">
								<table>
									<tr>
									<td><div style="width:200px;"><input type="text" id="from" name="from" class="form-control" placeholder="MM/DD/YYYY"></div></td>
									<td><div style="width:15px;"><label> ~ </label></div></td>
									<td><div style="width:200px;"><input type="text" id="to" name="to" class="form-control" placeholder="MM/DD/YYYY"></div></td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					<br>
					<br>
					<div class="form-group form">
						<div class="form-group">
							<p class="text-center">
								<button type="submit" class="btn btn-primary btn-lg submit">생성</button>
								<button type="reset" class="btn btn-primary btn-lg">취소</button>
							</p>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">프로젝트 생성 완료</h5>
					</div>
					<div class="modal-body d-flex flex-column">
						<span>프로젝트 코드 : </span>
						<div class="d-flex">
							<input type="text" id="project_code_link" value="test" readonly
								style="flex: 1 1 auto;">
							<button class="copy" style="padding: 10px;">복사</button>
						</div>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary">프로젝트 바로가기</button>
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">확인</button>

					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- body 끝 -->

	<!-- Optional JavaScript; choose one of the two! -->

	<!-- Option 1: Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>

	<!-- Option 2: Separate Popper and Bootstrap JS -->
	<!--
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
    -->
</body>
</html>