function inputCheck() {
	if(document.memFrm.id.value==""){
		alert("아이디를 입력하세요.");
		document.memFrm.id.focus();
		return;
	}
	if(document.memFrm.pwd.value==""){
		alert("비밀번호를 입력하세요.");
		document.memFrm.pwd.focus();
		return;
	}
	if(document.memFrm.repwd.value==""){
		alert("비밀번호 확인을 입력하세요.");
		document.memFrm.repwd.focus();
		return;
	}
	if(document.memFrm.repwd.value != document.memFrm.pwd.value){
		alert("비밀번호가 일치하지 않습니다.");
		document.memFrm.repwd.focus();
		return;
	}	
	if(document.memFrm.name.value==""){
		alert("이름을 입력하세요.");
		document.memFrm.name.focus();
		return;
	}
	if(document.memFrm.birth.value==""){
		alert("생년월일을 입력하세요.");
		document.memFrm.birth.focus();
		return;
	}
	if(document.memFrm.email.value==""){
		alert("이메일을 입력하세요.");
		document.memFrm.email.focus();
		return;
	}
	if(document.memFrm.addr.value==""){
		alert("주소를 입력하세요.");
		document.memFrm.addr.focus();
		return;
	}
	
	if(document.memFrm.job.value=="0"){
		alert("직업을 선택하세요.");
		document.memFrm.job.focus();
		return;
	}
	document.memFrm.submit();
}

function win_close(){
	self.close();
}