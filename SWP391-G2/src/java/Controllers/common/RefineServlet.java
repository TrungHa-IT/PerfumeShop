/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.common;

import Dal.BrandsDAO;
import Dal.CategoriesDAO;
import Dal.FeedbackDAO;
import Dal.ProductsDAO;
import Models.Categories;
import Models.Brands;
import Models.ProductsHome;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author ROG
 */
public class RefineServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RefineServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RefineServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoriesDAO categoriesDAO = new CategoriesDAO();
        ProductsDAO productsDAO = new ProductsDAO();
        BrandsDAO brandsDAO = new BrandsDAO();
        FeedbackDAO feedbackDAO = new FeedbackDAO();

        // Load categories and brands initially
        List<Categories> categories = categoriesDAO.loadCategory();
        List<Brands> brands = brandsDAO.getBrands();

        // Retrieve parameters from request
        String nameSearch = request.getParameter("nameSearch");
        String priceRange = request.getParameter("priceRange");
        String sortOrder = request.getParameter("sortOrder");

        String[] cidRefineeRaw = request.getParameterValues("cid_refinee");
        String[] bidRefineeRaw = request.getParameterValues("bid_refinee");

        // Initialize variables for category and brand refinement
        int[] cidRefinee = null;
        int[] bidRefinee = null;

        if (cidRefineeRaw != null) {
            cidRefinee = new int[cidRefineeRaw.length];
            for (int i = 0; i < cidRefineeRaw.length; i++) {
                cidRefinee[i] = Integer.parseInt(cidRefineeRaw[i]);
            }
        }

        if (bidRefineeRaw != null) {
            bidRefinee = new int[bidRefineeRaw.length];
            for (int i = 0; i < bidRefineeRaw.length; i++) {
                bidRefinee[i] = Integer.parseInt(bidRefineeRaw[i]);
            }
        }

        // Parse and process price range refinement parameters
        int minPrice = 0;
        int maxPrice = Integer.MAX_VALUE;

        if (priceRange != null && !priceRange.isEmpty()) {
            switch (priceRange) {
                case "under25":
                    maxPrice = 25;
                    break;
                case "25to50":
                    minPrice = 25;
                    maxPrice = 50;
                    break;
                case "50to100":
                    minPrice = 50;
                    maxPrice = 100;
                    break;
                case "100to150":
                    minPrice = 100;
                    maxPrice = 150;
                    break;
                case "over150":
                    minPrice = 150;
                    break;
            }
        }

        // Apply filters and get the filtered products
        List<ProductsHome> allProducts = productsDAO.getProductsByPricerangeAndCateAndBrand(minPrice, maxPrice, cidRefinee, bidRefinee);

        // Initialize variables for checkbox states
        Boolean[] chid = new Boolean[categories.size() + 1];
        Boolean[] bhid = new Boolean[brands.size() + 1];

        // Process the checkboxes for categories and brands
        if (cidRefineeRaw != null) {
            for (int i = 0; i < chid.length; i++) {
                chid[i] = false;
            }
            for (String cidRaw : cidRefineeRaw) {
                int cid = Integer.parseInt(cidRaw);
                for (int j = 0; j < categories.size(); j++) {
                    if (categories.get(j).getCategoryID() == cid) {
                        chid[j + 1] = true;
                        break;
                    }
                }
            }
        }

        if (bidRefineeRaw != null) {
            for (int i = 0; i < bhid.length; i++) {
                bhid[i] = false;
            }
            for (String bidRaw : bidRefineeRaw) {
                int bid = Integer.parseInt(bidRaw);
                for (int j = 0; j < brands.size(); j++) {
                    if (brands.get(j).getBrandID() == bid) {
                        bhid[j + 1] = true;
                        break;
                    }
                }
            }
        }

        // Update the stringForLink for pagination and refine links
        StringBuilder stringForLinkBuilder = new StringBuilder();
        if (cidRefineeRaw != null) {
            for (String cid : cidRefineeRaw) {
                stringForLinkBuilder.append("cid_refinee=").append(cid).append("&");
            }
        }
        if (bidRefineeRaw != null) {
            for (String bid : bidRefineeRaw) {
                stringForLinkBuilder.append("bid_refinee=").append(bid).append("&");
            }
        }
        if (priceRange != null) {
            stringForLinkBuilder.append("priceRange=").append(priceRange).append("&");
        }
        if (sortOrder != null) {
            stringForLinkBuilder.append("sortOrder=").append(sortOrder).append("&");
        }

        String stringForLink = stringForLinkBuilder.toString();
        if (stringForLink.endsWith("&")) {
            stringForLink = stringForLink.substring(0, stringForLink.length() - 1);
        }

        // Paging
        int page = 1, numPerPage = 12;
        int size = allProducts.size();
        int numberpage = ((size % numPerPage == 0) ? (size / numPerPage) : (size / numPerPage) + 1);
        String xpage = request.getParameter("page");
        if (xpage != null) {
            page = Integer.parseInt(xpage);
        }
        int start = (page - 1) * numPerPage;
        int end = Math.min(page * numPerPage, size);

        List<ProductsHome> listByPage = productsDAO.getListByPage(allProducts, start, end);

        if (nameSearch != null && !nameSearch.isEmpty()) {
            listByPage = productsDAO.searchByName(nameSearch);
        } else {
        // Apply sorting order if specified
        if ("lowToHigh".equals(sortOrder)) {
            listByPage = productsDAO.getProductsByPriceLowToHigh(cidRefinee, bidRefinee);
        } else if ("highToLow".equals(sortOrder)) {
            listByPage = productsDAO.getProductsByPriceHighToLow(cidRefinee, bidRefinee);
        }
    }

        // Get product ratings
        Map<Integer, Double> productRatings = new HashMap<>();
        for (ProductsHome product : listByPage) {
            double averageRating = feedbackDAO.getAverageStartByProductID(product.getProductID());
            productRatings.put(product.getProductID(), averageRating);
        }

        // Set attributes and forward to refine.jsp
        request.setAttribute("stringForLink", stringForLink);
        request.setAttribute("searchAtHome", nameSearch);

        request.setAttribute("chid", chid);
        request.setAttribute("cid_refinee", cidRefinee);
        request.setAttribute("cid_refine", 0); // Not used, can be removed if not needed

        request.setAttribute("bhid", bhid);
        request.setAttribute("bid_refinee", bidRefinee);
        request.setAttribute("bid_refine", 0); // Not used, can be removed if not needed
        
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("priceRange", priceRange);
        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);
        request.setAttribute("products", allProducts);
        request.setAttribute("productPage", listByPage);
        request.setAttribute("currentPage", page);
        request.setAttribute("numberpage", numberpage);
        request.setAttribute("allproduct", allProducts);
        request.setAttribute("productRatings", productRatings);

        request.getRequestDispatcher("common/refine.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
