<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="../layout/app.jsp">
    <c:param name="content">
        <h2>ユーザー　新規登録ページ</h2>

        <form method="POST" action="<c:url value='/new/create' />" >
            <label for="user_name">ユーザー名</label><br />
            <input type="text" name="user_name" value="${user.user_name}" />
            <br /><br />

            <label for="email">メールアドレス</label><br />
            <input type="text" name="email" value="${user.email}" />
            <br /><br />

            <label for="sport">好きなスポーツ</label><br />
            <input type="text" name="sport" value="${user.sport}" />
            <br /><br />

            <label for="addres">住んでいる県</label><br />
            <input type="text" name="addres" value="${user.addres}" />
            <br /><br />

            <label for="profile">プロフィール欄</label><br />
            <textarea name="profile" rows="10" cols="50">${item.profile}</textarea>
            <br /><br />

            <label for="password">パスワード</label><br />
            <input type="password" name="password" />
            <br /><br />

            <input type="hidden" name="_token" value="${_token}" />
            <button type="submit">登録</button>
        </form>

        <p><a href="<c:url value='/login' />">ログイン画面に戻る</a></p>
    </c:param>
</c:import>