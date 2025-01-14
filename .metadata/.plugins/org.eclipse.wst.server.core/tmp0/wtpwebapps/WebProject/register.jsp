<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %> <!-- BCrypt 라이브러리 추가 -->

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fc;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        label {
            font-size: 14px;
            color: #333;
            margin-bottom: 8px;
            display: block;
        }

        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 8px 0 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #45a049;
        }

        .footer {
            text-align: center;
            margin-top: 20px;
        }

        .footer a {
            color: #4CAF50;
            text-decoration: none;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>회원가입</h1>
        <form action="register.jsp" method="post">
            <label for="name">이름</label>
            <input type="text" id="name" name="name" required><br>

            <label for="email">이메일</label>
            <input type="email" id="email" name="email" required><br>

            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" required><br>

            <button type="submit">회원가입</button>
        </form>

        <div class="footer">
            <p>이미 계정이 있으신가요? <a href="login.jsp">로그인</a></p>
        </div>

        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                request.setCharacterEncoding("UTF-8");

                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                // 비밀번호 암호화
                String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

                String connString = "jdbc:mariadb://127.0.0.1:3306/userdb?useUnicode=true&characterEncoding=UTF-8";
                String dbUser = "root";
                String dbPassword = "1234";

                try {
                    Class.forName("org.mariadb.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(connString, dbUser, dbPassword);

                    String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, name);
                    pstmt.setString(2, email);
                    pstmt.setString(3, hashedPassword); // 암호화된 비밀번호 저장
                    pstmt.executeUpdate();

                    out.println("<p style='color: green; text-align: center;'>회원가입 성공!</p>");
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                    out.println("<p style='color: red; text-align: center;'>회원가입 실패: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>

</body>
</html>
