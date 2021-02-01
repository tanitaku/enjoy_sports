package controllers.users;

import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.User;
import utils.DBUtil;

/**
 * Servlet implementation class SearchUserServlet
 */
@WebServlet("/search/user")
public class SearchUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        EntityManager em = DBUtil.createEntityManager();

        User login_user = (User) request.getSession().getAttribute("login_user");

        String a = request.getParameter("addres");

        try {
        List<User> addres = em.createNamedQuery("userSearch", User.class)
                .setParameter("addres", "%" + a + "%")
                .getResultList();
            request.getSession().setAttribute("addres", addres);
        } catch(Exception e) {
            request.getSession().setAttribute("flush", "該当データなし");
        }

        try {
            long search_count = (long)em.createNamedQuery("searchResult", Long.class)
                                            .setParameter("addres", "%" + a + "%")
                                            .getSingleResult();
                request.getSession().setAttribute("search_count", search_count);
            } catch(Exception e) {
            }

        em.close();


        response.sendRedirect(request.getContextPath() + "/data?" + login_user.getId());
    }

}
