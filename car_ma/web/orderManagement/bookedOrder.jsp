<%@ page import="config.GCON" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="display.OrderView" %>
<%@ page import="tool.Query" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>所有订单</title>
    <script>
        function nextPage(maxP) {

            var url = window.location.href;

            var urlHead = window.location.href.split("&")[0];

            var oldPageIndex = parseInt(url.split("&")[1].split("=")[1]);

            if (oldPageIndex < 0) {
                oldPageIndex = 0;
            }

            if (oldPageIndex >= maxP) {
                oldPageIndex = maxP - 1;
            }

            var newPageIndex = oldPageIndex + 1;

            window.location.href = urlHead + "&pageIndex=" + newPageIndex;

        }

        function prePage(maxP) {
            var url = window.location.href;

            var urlHead = window.location.href.split("&")[0];

            var oldPageIndex = parseInt(url.split("&")[1].split("=")[1]);

            if (oldPageIndex < 0) {
                oldPageIndex = 1;
            }

            if (oldPageIndex >= maxP) {
                oldPageIndex = maxP;
            }

            var newPageIndex = oldPageIndex - 1;

            window.location.href = urlHead + "&pageIndex=" + newPageIndex;
        }

        function jump(maxP) {

            var urlHead = window.location.href.split("&")[0];

            var newPageIndex = parseInt(document.getElementById("pageIndex").value);

            if (!isInteger(newPageIndex)) {
                alert('页码格式有误，请重新输入');
                return;
            }

            if (newPageIndex < 0) {
                newPageIndex = 0;
            }

            if (newPageIndex >= maxP) {
                newPageIndex = maxP;
            }


            window.location.href = urlHead + "&pageIndex=" + newPageIndex;
        }

        function isInteger(obj) {
            return typeof obj === 'number' && obj%1 === 0
        }
        //0402添加
        function edit(orderid) {
            var f=confirm("是否确定改为租赁状态？");
            if(f){
                window.location.href="/orderManagement/bookedOrder.jsp?op=3&pageIndex=0?&ordernumber="+orderid;
            }else{
                alert("您取消操作");
            }
        }

        function del(orderid) {
            var f=confirm("是否确定删除？");
            if(f){
                window.location.href="/orderManagement/bookedOrder.jsp?op=4&pageIndex=0&ordernumber="+orderid;
            }else{
                alert("您取消删除");
            }

        }

    </script>
</head>
<%@include file="/hotelAdmin.jsp"%>
<body>
<%
    Map<String, String[]> map =request.getParameterMap() ;
    if(map.containsKey("op")){
        int op = Integer.parseInt(map.get("op")[0]) ; //通过mop选项来控制页面显示的内容
        if(op==3){
            //租赁
            String ordernumber=request.getParameter("ordernumber");
            Query.updateOrderState(ordernumber);
            System.out.println("将订单改为租赁状态");
        }else if (op==4){
            String ordernumber=request.getParameter("ordernumber");
            Query.deleteBookedOrder(ordernumber);
            System.out.println("将订单改为删除");
        }
    }

%>
<%

//    ArrayList<OrderView> orderViews = Query.getAllOrderViews("已预定");
    ArrayList<OrderView> orderViews = Query.getAllOrderViews("已预定");
    System.out.println("bookedorder");
    System.out.println(orderViews.size());
    //如果订单非空
    if (orderViews.size() != 0) {
//        out.print("size---" + orderViews.size());

        int currentOrderSize = orderViews.size();
        //每页显示10条记录
        int pageNumber = 10;

        int maxPageNumber = (currentOrderSize - 1) / pageNumber;

        boolean pageIndexFlow = false;

        boolean pageIndexNegative = false;

        int currentPageNumber =  Integer.parseInt(request.getParameter("pageIndex").toString());

        if (currentPageNumber <= 0) {
            currentPageNumber = 0;

            pageIndexNegative = true;
        }

        if (currentPageNumber > maxPageNumber) {
            currentPageNumber = maxPageNumber;
            pageIndexFlow = true;
        }

        int startIndex = currentPageNumber * pageNumber;

        int endIndex = (startIndex + pageNumber - 1) > currentOrderSize - 1 ? currentOrderSize - 1 : (startIndex + pageNumber - 1);

        if (endIndex >= currentOrderSize - 1) {
            pageIndexFlow = true;
        }
%>
<table class="ui sortable celled table">
    <thead>
    <tr class="center aligned"><th class="sorted descending">订单号</th>
        <th>订单状态</th>
        <th>客户姓名</th>
        <th>创建时间</th>
        <th>车牌号</th>
        <th>汽车类型</th>
        <th>租赁时间</th>
        <th>归还时间</th>
        <th>租车时长</th>
        <th>手机号码</th>
        <th>价格</th>
        <th>  </th>
        <th>  </th>
    </tr></thead>

    <tbody>

    <%
        for (int i = startIndex; i <= endIndex; i++) {
            if (true) {
    %>
    <tr class="center aligned">
        <td>
            <%
                out.print(orderViews.get(i).getOrderNumder());
            %>
        </td>
        <td>
            <%
                out.print(orderViews.get(i).getOrderStatus());
            %>
        </td>
        <td>
            <%
                out.print(orderViews.get(i).getCustomer());
            %>
        </td>
        <td>
            <%
                out.print(orderViews.get(i).getOrderTime().toString());
            %>
        </td>
        <td>
            <%
                out.print(orderViews.get(i).getRoomNumber());
            %>
        </td>
        <td>
            <%
                out.print(orderViews.get(i).getRoomType());
            %>
        </td>
        <td>
            <%
                out.print(orderViews.get(i).getCheckInTime());
            %>
        </td>
        <td>
            <%
                out.print(orderViews.get(i).getCheckOutTime());
            %>
        </td>
        <td>
            <%
                out.print(orderViews.get(i).getDays());
            %>
        </td>
        <td>
            <%
                out.print(orderViews.get(i).getCustomerPhoneNumber());
            %>
        </td>
        <td>
            <%
                out.print(orderViews.get(i).getPrice());
            %>
        </td>
        <td>
            <div class="ui button" tabindex="0"  onclick="edit('<%=(orderViews.get(i).getOrderNumder())%>')">租赁</div>
        </td>
        <td>
            <div class="ui button" tabindex="0"  onclick="del('<%=(orderViews.get(i).getOrderNumder())%>')">删除</div>
        </td>

    </tr>
    <%}
    }
    %>

    </tbody>
    <tfoot>
    <tr>
        <th colspan="11">
            <div class="ui right floated pagination menu">
                <a class="icon item">
                    <h4>当前页&nbsp;:&nbsp;<%=currentPageNumber%>/<%=maxPageNumber%></h4>
                </a>
                <a class="icon item">
                    <div class="ui mini icon input">
                        <input type="text" placeholder="输入页码" id="pageIndex">
                        <i class="search icon"></i>
                    </div>
                    <a class="icon item" onclick="jump(<%=maxPageNumber%>)">
                        <i class="reply icon"></i>
                        <label>&nbsp;跳转</label>
                    </a>
                </a>
                <%if (!pageIndexNegative) {%>
                <a class="icon item" onclick="prePage(<%=maxPageNumber%>)">
                    <i class="left chevron icon"></i>
                    <label>&nbsp;上一页</label>
                </a>
                <%} else {%>
                <a class="icon item">
                    <i class="smile icon"></i>
                    <label>第一页</label>
                </a>
                <%}%>
                <%if (!pageIndexFlow) {%>
                <a class="icon item" onclick="nextPage(<%=maxPageNumber%>)">
                    <label>下一页&nbsp;</label>
                    <i class="right chevron icon"></i>
                </a>
                <%} else {%>
                <a class="icon item">
                    <label>没有了&nbsp;</label>
                    <i class="frown icon"></i>
                </a>
                <%}%>
            </div>
        </th>
    </tr>
    </tfoot>
</table>

<%} else {%>

<div class="ui middle aligned center aligned grid">
    <div class="column">
        <br>
        <br>
        <br>
        <br>
        <br>
        <h1 class="ui red header"><i class="folder open icon"></i>没有预定订单!!!</h1>
    </div>
</div>

<%}%>


</body>
</html>
