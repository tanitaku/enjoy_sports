package controllers.profile;

import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Post;
import models.User;
import utils.DBUtil;

/**
 * Servlet implementation class ProfileShowServlet
 */
@WebServlet("/profile/show")
public class ProfileShowServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileShowServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        EntityManager em = DBUtil.createEntityManager();

        User u = em.find(User.class, Integer.parseInt(request.getParameter("id")));

        User login_user = (User)request.getSession().getAttribute("login_user");

        
        
        List<Post> posts = em.createNamedQuery("getMyAllPosts", Post.class)
                .setParameter("user", u)
               .getResultList();

        em.close();

        if(u.getId() == login_user.getId()) {
            request.setAttribute("user", u);
            request.setAttribute("posts", posts);
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/profile/show1.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("user", u);
            request.setAttribute("posts", posts);

            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/profile/show2.jsp");
            rd.forward(request, response);
    }

}
}
