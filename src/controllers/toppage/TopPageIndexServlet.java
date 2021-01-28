package controllers.toppage;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
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
 * Servlet implementation class TopPageIndexServlet
 */
@WebServlet("/index.html")
public class TopPageIndexServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public TopPageIndexServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        EntityManager em = DBUtil.createEntityManager();

        User login_user = (User)request.getSession().getAttribute("login_user");

        int page;
        try{
            page = Integer.parseInt(request.getParameter("page"));
        } catch(Exception e) {
            page = 1;
        }

        List<Post> posts = em.createNamedQuery("getMyAllPosts", Post.class)
                .setParameter("user", login_user)
                .setFirstResult(15 * (page - 1))
                .setMaxResults(15)
               .getResultList();

        long posts_count = (long)em.createNamedQuery("getMyReportsCount", Long.class)
                     .setParameter("user", login_user)
                     .getSingleResult();

        // 今日の日付
        Date dt = new Date(System.currentTimeMillis());

        // 一か月前の日付取得
        Date dt2 = new Date(System.currentTimeMillis());
        Calendar cd = Calendar.getInstance();
        cd.setTime(dt2);
        cd.add(Calendar.MONTH, -1);
        dt2 = cd.getTime();

        em.close();

        request.setAttribute("posts_count", posts_count);
        request.setAttribute("posts", posts);
        request.setAttribute("page", page);
        request.setAttribute("date", dt);

        if(request.getSession().getAttribute("flush") != null) {
            request.setAttribute("flush", request.getSession().getAttribute("flush"));
            request.getSession().removeAttribute("flush");
        }

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/topPage/index.jsp");
        rd.forward(request, response);
    }

}
