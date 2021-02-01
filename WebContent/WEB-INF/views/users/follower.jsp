<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../layout/app.jsp">
    <c:param name="content">
        <c:if test="${flush != null}">
            <div id="flush_success">
                <c:out value="${flush}"></c:out>
            </div>
         </c:if>

         <h2>フォロワー　一覧</h2>

         <table id="user_list2">
            <tbody>
                <tr>
                    <th>ユーザー名</th>
                    <th>都道府県</th>
                    <th>プロフィール</th>
                </tr>
                <c:forEach var="feses" items="${fes}">
                    <tr class="row${status.count % 2}">
                        <td>
                           <c:out value="${feses.followered.user_name}" />
                        </td>
                        <td>
                           <c:out value="${feses.followered.addres}" />
                        </td>
                       <td>
                           <a href="<c:url value='/profile/show?id=${feses.followered.id}' />">詳細</a>
                       </td>
                    </tr>
                </c:forEach>
            </tbody>
          </table>
          </c:param>
       </c:import>
       <a href="<c:url value='/users/index' />">トップに戻る</a>