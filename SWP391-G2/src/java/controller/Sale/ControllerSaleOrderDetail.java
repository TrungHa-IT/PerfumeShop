/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Sale;


import Dal.OrderDAO;
import Dal.OrderDetailDAO;
import Dal.OrderStatusDAO;
import Dal.ProductDetailDAO;
import Models.OrderStatus;
import Models.Orders;
import Models.orderDetailSale;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author nguye
 */
public class ControllerSaleOrderDetail extends HttpServlet {

    public boolean changeStatus(int oldStatus, int orderId, int newStatus, List<orderDetailSale> _detail) {
        OrderDAO orderdao = new OrderDAO();
        ProductDetailDAO detaildao = new ProductDetailDAO();
        boolean check = false;
        if (oldStatus == newStatus) {
            return false;
        }
        if (newStatus == 2) {
            for (orderDetailSale detailSale : _detail) {
                check = detaildao.getInforProductDetail(detailSale.getProductFullDetailID()).getProductAvaiable() >= detailSale.getQuantity() ? true : false;
                if (!check) {
                    return check;
                }
            }
            if (check) {
                orderdao.updateStatus(orderId, newStatus);
                for (orderDetailSale detailSale : _detail) {
                    detaildao.updateQuantity(detailSale.getProductFullDetailID(), detaildao.getInforProductDetail(detailSale.getProductFullDetailID()).getProductAvaiable() - detailSale.getQuantity());
                }
            }
        } else if (newStatus == 4 && oldStatus != 1) {
            check = true;
            orderdao.updateStatus(orderId, newStatus);
            for (orderDetailSale detailSale : _detail) {
                detaildao.updateQuantity(detailSale.getProductFullDetailID(), detaildao.getInforProductDetail(detailSale.getProductFullDetailID()).getProductAvaiable() + detailSale.getQuantity());
            }
        } else {
            check = true;
            orderdao.updateStatus(orderId, newStatus);
        }
        return check;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int orderId = -1;
        int sta = -1;
        try {
            orderId = request.getParameter("orderId") != null ? Integer.parseInt(request.getParameter("orderId")) : -1;
            sta = request.getParameter("status") != null ? Integer.parseInt(request.getParameter("status")) : -1;
        } catch (NumberFormatException ex) {
            System.err.println(ex.getMessage());
        }

        OrderDetailDAO odDao = new OrderDetailDAO();
        List<orderDetailSale> _details = odDao.getAllByOrderId(orderId);

        OrderDAO orderdao = new OrderDAO();
        Orders order = orderdao.getOrder(orderId);

        OrderStatusDAO statusDao = new OrderStatusDAO();
        List<OrderStatus> status = statusDao.getAll();
        if (sta != -1) {

            if (changeStatus(order.getOrderSoID(), orderId, sta, _details)) {
                request.setAttribute("success", "success");
            } else {
                if (order.getOrderSoID() == sta) {
                    request.setAttribute("error", "Status order was change");
                } else {
                    request.setAttribute("error", "Some products are not in sufficient quantity, please check the warehouse");
                }
            };
        }
        order = orderdao.getOrder(orderId);
        request.setAttribute("info", order);
        request.setAttribute("orderDetail", _details);
        request.setAttribute("listStatus", status);
//        response.getWriter().print(_details.size());
        request.getRequestDispatcher("sale/sale-order-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
