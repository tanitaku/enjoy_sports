package controllers.toppage;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;

import javax.persistence.EntityManager;
import javax.persistence.TemporalType;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

        // 今日の日付
        Date dt = new Date(System.currentTimeMillis());

        // 一か月前の日付取得
        Date dt2 = new Date(System.currentTimeMillis());
        Calendar cd = Calendar.getInstance();
        cd.setTime(dt2);
        cd.add(Calendar.MONTH, -1);
        dt2 = cd.getTime();

        int page;
        try{
            page = Integer.parseInt(request.getParameter("page"));
        } catch(Exception e) {
            page = 1;
        }

        try {
            long dates = (long)em.createNamedQuery("getMonth", Long.class)
                                .setParameter("user", login_user)
                                .setParameter("today", dt, TemporalType.DATE)
                                .setParameter("thirty", dt2, TemporalType.DATE)
                                .getSingleResult();
            request.setAttribute("d", dates);
        }catch(Exception e) {
            request.setAttribute("d", 0);
        }


        em.close();

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
