<%@page import="java.util.Map"%>
<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.entites.Category"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.entites.User"%>
<%

    User user = (User) session.getAttribute("current-user");
    if (user == null) {

        session.setAttribute("message", "You are not logged in !! login first");
        response.sendRedirect("login.jsp");
        return;
    } else {

        if (user.getUserType().equals("normal")) {
            session.setAttribute("message", "You are not admin! Do not access this page");
            response.sendRedirect("login.jsp");

            return;
        }

    }

%>

    <% 
              
          CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                   List<Category> list=cdao.getCategories();
                  
   //getting count
   
  Map<String,Long> m=Helper.getCounts(FactoryProvider.getFactory());
   
    
    
    %>
                    
                    



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container admin">
            <div class="container-fluid mt-3">
                <%@include file="components/message.jsp" %>
                
            </div>
            <div class="row mt-3">
                <!--first col-->
                <div class="col-md-4"data-toggle="tooltip" data-placement="bottom" title="Total categories">
                    <!--first box-->
                    <div class="card" data-toggle="tooltip" data-placement="left" title="Number of users in this website">
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="Img/userr.png" alt="user_icon">        
                            </div>
                            <h1><%=m.get("userCount")%></h1>
                            <h1 class="text-uppercase text-muted">Users</h1>
                        </div>
                    </div>

                </div>
                <!--Second col-->
                <div class="col-md-4">
                    <div class="card  text-center">
                        <div class="card-body">

                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="Img/list.png" alt="user_icon">  
                            </div>
                            <h1><%= list.size() %></h1>

                            <h1 class="text-uppercase text-muted">Categories</h1>
                        </div>
                    </div>

                </div>
                <!--Third col-->
                <div class="col-md-4">
                    <div class="card" data-toggle="tooltip" data-placement="right" title="Total number of products">
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="Img/product.png" alt="user_icon">  
                            </div>
                            <h1><%=m.get("productCount")%></h1>
                            <h1 class="text-uppercase text-muted " >Products</h1>
                        </div>
                    </div>

                </div>
            </div>
            <!--second row-->
            <div class="row mt-3">

                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-category-modal">
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="Img/key.png" alt="user_icon">  
                            </div>
                            <p class="mt-2">Click here to add new Category</p>
                            <h1 class="text-uppercase text-muted " >Add Category</h1>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-product-modal">
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="Img/plus.png" alt="user_icon">  
                            </div>

                            <p class="mt-2">Click here to add new product</p>
                            <h1 class="text-uppercase text-muted " >Add Product</h1>
                        </div>

                    </div>
                </div>

            </div>

            <!--add category modal-->          
            

            <!-- Modal -->
            <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">fill category details</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="ProductOperationServlet" method="post">
                               
                                <input type="hidden" name="operation" value="addcategory">
                                
                                <div class="form-group">
                                    <input type="text" class="form-control" name="catTitle" placeholder="Enter category title" required/>
                                </div>
                                <div class="form-group">
                                    <textarea style="height: 300px;" class="form-control" placeholder="Enter category description" name="catDescription" required></textarea>
                                    
                                </div>
                                <div class="container">
                                    <button class="btn btn-outline-success">Add Category</button> 
                                     <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!--End category modal-->
            
                <!--add product modal-->      
<!-- Modal -->
<div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Product Details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          
          <!--form-->
          <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
              
              <input type="hidden" name="operation" value="addproduct"/>
              
              <!--product title-->
              <div class="form-group">
                  <input type="text" class="form-control" placeholder="Enter title of product" name="pName" required/>
                  
              </div>
              
              <!--product description-->
              <div class="form-group">
                  <textarea style="height: 150px;"class="form-control" placeholder="Enter product description" name="pDesc"></textarea>
              </div>
              
              <!--product price-->
                 <div class="form-group">
                  <input type="number" class="form-control" placeholder="Enter price of product" name="pPrice" required/>
                  
              </div>
              
              <!--product discount-->
              
                 <div class="form-group">
                  <input type="number" class="form-control" placeholder="Enter Discount of product" name="pDiscount" required/>
                  
              </div>
              
               <!--product quantity-->
              
                 <div class="form-group">
                  <input type="number" class="form-control" placeholder="Enter Quantity of product" name="pQuantity" required/>
                  
              </div>
               
                <!--product category-->
            
              
                 <div class="form-group">
                     <select name="catId" class="form-control" id="">
                        
                         <% for(Category c:list){
                             %>
                         
                         
                         <option value="<%= c.getCategoryId() %>"><%=c.getCategoryTitle()%></option>
                         
                         
                        <% }%>
                         
                     </select>
                  
              </div>
                
                <!--product file-->
                <div class="form-group">
                    <label for="pPic">Select Picture of product</label>
                    <br>
                    <input type="file" id="pPic" name="pPic" required/>
                    
                    
                </div>
                <!--submit button-->
                <div class="container text-center">
                    
                    <button class="btn btn-outline-success">Add product</button>
                </div>
              
              
              
          </form>
          
          
          
          
          
          
          <!--End Form-->
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
       
      </div>
    </div>
  </div>
</div>
                
                
            <!--end product modal-->
            
            <%@include file="components/common_modals.jsp" %>
            
            <script>
                
                $(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
            </script>

       
    </body>
</html>
