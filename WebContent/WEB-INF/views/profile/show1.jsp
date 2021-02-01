<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <c:choose>
            <c:when test="${user != null}">
                <h2>${user.user_name} のプロフィールページ</h2>

                <table>
                    <tbody>
                        <tr>
                            <th>ユーザーID</th>
                            <td><c:out value="${user.id}" /></td>
                        </tr>
                        <tr>
                            <th>メールアドレス</th>
                            <td><c:out value="${user.email}" /></td>
                        </tr>
                        <tr>
                            <th>権限</th>
                            <td>
                                <c:choose>
                                    <c:when test="${user.admin_flag == 1}">管理者</c:when>
                                    <c:otherwise>一般</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>登録日時</th>
                            <td>
                                <fmt:formatDate value="${user.created_at}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </td>
                        </tr>
                        <tr>
                            <th>更新日時</th>
                            <td>
                                <fmt:formatDate value="${user.updated_at}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </td>
                        </tr>
                        <tr>
                            <th>ユーザーネーム</th>
                            <td><c:out value="${user.user_name}" /></td>
                        </tr>
                        <tr>
                            <th>好きなスポーツ</th>
                            <td><c:out value="${user.sport}" /></td>
                        </tr>
                        <tr>
                            <th>お住まいの都道府県</th>
                            <td><c:out value="${user.addres}" /></td>
                        </tr>
                        <tr>
                            <th>プロフィール</th>
                            <td>
                                <c:out value="${user.profile}" />
                            </td>
                        </tr>
                    </tbody>
                </table>

                <p><a href="<c:url value='/profile/edit?id=${user.id}' />">このユーザー情報を編集する</a></p>
            </c:when>
            <c:otherwise>
                <h2>お探しのデータは見つかりませんでした。</h2>
            </c:otherwise>
        </c:choose>

        <h2>過去のつぶやき</h2>
        <table id="post_list">
            <tbody>
                <tr>
                    <th class="post_name">氏名</th>
                    <th class="post_date">日付</th>
                    <th class="post_title">タイトル</th>
                    <th class="post_action">操作</th>
                </tr>
                <c:forEach var="post" items="${posts}" varStatus="status">
                    <tr class="row${status.count % 2}">
                        <td class="post_name"><c:out value="${post.user.user_name}" /></td>
                        <td class="post_date"><fmt:formatDate value='${post.post_date}' pattern='yyyy-MM-dd' /></td>
                        <td class="post_title">${post.title}</td>
                        <td class="post_action"><a href="<c:url value='/posts/show?id=${post.id}' />">詳細を見る</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <p><a href="<c:url value='/users/index' />">一覧に戻る</a></p>
    </c:param>
</c:import>