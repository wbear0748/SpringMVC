<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> 
<body> 
<script type="text/javascript"> 
var message = '${msg}';
var returnUrl = '${url}'

alert(message); 

if(returnUrl == 'back') {
	history.back()
} else {
	document.location.href = returnUrl;
}
</script>
</body>
</html> 