<%
String message = (String) session.getAttribute("msg");
String message1 = (String) session.getAttribute("m1");
if (message != null) {
%>
<div class="alert alert-warning" role="alert"><%=message%></div>
<%
	session.removeAttribute("msg");
}
%>
	
<%
if (message1 != null) {
%>
<div class="alert alert-success" role="alert"><%=message1%></div>
<%
	session.removeAttribute("m1");
}
%>
