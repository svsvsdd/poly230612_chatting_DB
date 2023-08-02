<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import="org.json.simple.*"%>
<%@ page import="java.util.ArrayList"%>
<%
    // null로 초기화 한다.
    Connection conn = null;
    try{
        // get값 받기
        String lastid = request.getParameter("lastid");
        if(lastid == null) {
            lastid = "0";
        }
        // 사용하려는 데이터베이스명을 포함한 URL 기술
        String url = "jdbc:mysql://localhost:3306/madang";
        String id = "root";       // 사용자계정
        String pw = "1314";   // 사용자계정의 패스워드
        // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
        Class.forName("com.mysql.jdbc.Driver");
        // DriverManager 객체로부터 Connection 객체를 얻어온다.
        conn=DriverManager.getConnection(url,id,pw);
        // read 수행
        Statement stmt = null;
        ResultSet rs = null;
        stmt = conn.createStatement();
        String sql = "SELECT * FROM chatting2 WHERE id > " + lastid;
        rs = stmt.executeQuery(sql);
        String resultId = null;
        String resultText = null;
        String resultDate = null;

        String resultUserid = null;


        JSONArray list = new JSONArray(); // Json배열 생성
        while(rs.next() == true) {
            JSONObject jobj = new JSONObject();
            resultId = rs.getString("id");
            resultText = rs.getString("text");
            resultDate = rs.getString("date");

            resultUserid = rs.getString("userid");

            jobj.put("id", resultId);
            jobj.put("text", resultText);
            jobj.put("date", resultDate);

            jobj.put("userid", resultUserid);

            list.add(jobj); // Json배열에 Json객체추가
        }
        out.print(list.toJSONString());
    // 예외가 발생하면 예외 상황을 처리한다.
    }catch(Exception e){
       ByteArrayOutputStream bs = new ByteArrayOutputStream();
       PrintStream printStream = new PrintStream(bs);
       e.printStackTrace(printStream);
       String traceStr = bs.toString();
       out.println("에러 " + traceStr);
    }
%>