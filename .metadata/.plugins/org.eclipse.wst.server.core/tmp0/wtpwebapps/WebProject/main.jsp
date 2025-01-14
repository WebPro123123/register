<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.Cookie" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f4f6;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            text-align: center;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            margin: 0 0 20px;
            color: #4CAF50;
        }

        p {
            margin: 10px 0;
            font-size: 16px;
        }

        a {
            text-decoration: none;
            color: #4CAF50;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="container">
        <%
            Cookie[] cookies = request.getCookies();
            String userName = null;

            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("userName")) {
                        userName = java.net.URLDecoder.decode(cookie.getValue(), "UTF-8");
                        break;
                    }
                }
            }

            if (userName != null) {
                out.println("<h1>" + userName + "님, 어서오세요!</h1>");
                out.println("<p>즐거운 시간을 보내세요.</p>");
                out.println("<a href='logout.jsp'>로그아웃</a>");
            } else {
                response.sendRedirect("login.jsp");
            }
        %>
    </div>

</body>
</html>
