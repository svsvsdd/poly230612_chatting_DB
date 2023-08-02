
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>헬로</title>
</head>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%
    // null로 초기화 한다.
    Connection conn = null;
    try{
        // 사용하려는 데이터베이스명을 포함한 URL 기술
        String url = "jdbc:mysql://localhost:3306/madang";
        String id = "root";       // 사용자계정
        String pw = "1314";   // 사용자계정의 패스워드
        // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
        Class.forName("com.mysql.jdbc.Driver");
        // DriverManager 객체로부터 Connection 객체를 얻어온다.
        conn=DriverManager.getConnection(url,id,pw);
        // 커넥션이 제대로 연결되면 수행된다.
        out.println("제대로 연결되었습니다.");


        
        String inputStr = request.getParameter("inputtext");

        PreparedStatement pstmt = null;
        pstmt = conn.prepareStatement("INSERT INTO chatting2 VALUES (0, ?, now());");
        pstmt.setString(1, inputStr);
        pstmt.executeUpdate();
        out.println("insertrrr");


    // 예외가 발생하면 예외 상황을 처리한다.
    }catch(Exception e){
       ByteArrayOutputStream bs = new ByteArrayOutputStream();
       PrintStream printStream = new PrintStream(bs);
       e.printStackTrace(printStream);
       String traceStr = bs.toString();
       out.println("에러 " + traceStr);
    }
%>
<body>
   
</body>

</html>