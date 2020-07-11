<%@ page import="entity.*" %>
<%@ page import="static tool.Query.getAllCars" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="static tool.Query.searchFullCars" %>
<%@ page import="static tool.Query.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Map<String, String[]> map =request.getParameterMap() ;
    int op = Integer.parseInt(map.get("op")[0]) ; //通过op选项来控制页面显示的内容
    Order order =null ;
    if(op==2){
        System.out.println("房间编号:"+map.get("carid")[0]);
        order =getOrder(map.get("carid")[0]) ;
        System.out.println("订单编号:"+order.getOrderNumber());
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>汽车租赁管理系统</title>
    <link rel="stylesheet" type="text/css" href="/semantic/dist/semantic.min.css">
    <script src="/semantic/dist/jquery.min.js"></script>
    <script src="/semantic/dist/semantic.js"></script>
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/reset.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/site.css">

    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/container.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/divider.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/grid.css">

    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/header.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/segment.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/table.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/icon.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/menu.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/message.css">

    <style type="text/css">
        h2 {
            margin: 1em 0em;
        }
        .ui.container {
            padding-top: 5em;
            padding-bottom: 5em;
        }
    </style>
    <script >
        function returnMainPage() {
            window.location.href="/carCheckOut.jsp?op=1";
        }
        function fun() {
            var carid =  document.getElementById("carid").value ;
            var pat1 = /^[0-9]{6}$/ ;

            if( pat1.test(carid) ){
                window.location.href="/carCheckOut.jsp?op=2&carid="+carid
            }
            return false ;
        }
    </script>
</head>



<%@include file="/hotelAdmin.jsp"%>
<body>

<div class="pusher">


    <div class="ui container">
        <h2 class="ui header">退车</h2>
        <div class="ui column grid">
            <div class="four wide column">
                <div class="ui vertical steps">

                    <div class="<%=(op<=1)?"active step ":"completed step"%>" >
                        <i class="building icon"></i>
                        <div class="content">
                            <div class="title">选择车号</div>

                        </div>
                    </div>

                    <div class="<%=(op==2)?"active step ":(op==1)?"step":"completed step"%>">
                        <i class="info icon"></i>
                        <div class="content">
                            <div class="title">订单信息</div>
                            <%--<div class="description">Enter billing information</div>--%>
                        </div>
                    </div>

                </div>
            </div>
            <div class="eleven wide  column" >

                <%  if(op==1){ %>
                <form class="ui form" onsubmit="return fun(this)">
                    <h4 class="ui dividing header">汽车选择</h4>
                    <div class="four wide column">
                        <label>车牌号</label>

                        <div class="five wide field">

                            <select class="ui fluid search dropdown" id="carid">

                                <%
                                    ArrayList<String> list = searchFullCars();
                                    if(list.size()==0){
                                %>
                                <option value="无车可退">无车可退</option>
                                <%
                                    }
                                    for(String str : list){
                                %>
                                <option value=<%=str%>> <%=str%> </option>
                                <% } %>
                            </select>
                            <%--<input type="text" name="carid" placeholder="房间号">--%>
                        </div>
                    </div>
                    <br/>
                    <div class="ui right submit floated button" tabindex="0" >提交订单</div>
                </form>
                <% }
                else if(op==2){%>

                <%--  房间号 居住时间  --%>

                <h4 class="ui dividing header">订单信息</h4>
                <table class="ui table">
                    <thead>
                    <tr><th class="six wide">Name</th>
                        <th class="ten wide">Info</th>
                    </tr></thead>
                    <tbody>

                    <tr>

                        <td>订单编号</td>
                        <td><%=order.getOrderNumber()%></td>

                    </tr>
                    <tr>

                        <td>住户身份证</td>
                        <td><%=order.getCustomerIDCard()%></td>

                    </tr>
                    <tr>

                        <td>车号</td>
                        <td><%=order.getCarNumber()%></td>

                    </tr>
                    <tr>

                        <td>订单生成时间</td>
                        <td><%=order.getOrderTime()%></td>

                    </tr>
                    <tr>

                        <td>用车时间</td>
                        <td><%=order.getCheckInTime()%></td>

                    </tr>
                    <tr>

                        <td>退车时间</td>
                        <td><%=order.getCheckOutTime()%></td>

                    </tr>
                    <tr>

                        <td>服务人员编号</td>
                        <td><%=order.getWaiterID()%></td>

                    </tr>
                    <tr>

                        <td>订单总金额(含续费)</td>
                        <td><%=order.getTotalMoney()%></td>

                    </tr>
                    <tr>

                        <td>备注</td>
                        <td><%=order.getRemarks()%></td>

                    </tr>
                    </tbody>
                </table>


                <h4 class="ui dividing header">完成退车</h4>

                <div class="ui right button" >
                    <%--<% if(op==2)System.out.println("打印订单编号:"+order.getOrderNumber() );%>--%>
                    <%--<a href="ServiceManage?op=5&orderNumber=<%=order.getOrderNumber()%>">确认退车</a>--%>
                    <a href="/carCheckOut.jsp?op=3&orderNumber=<%=order.getOrderNumber()%>">确认退车</a>
                </div>
                <%}else if (op == 3) {
                    String orderNumber= map.get("orderNumber")[0] ;
                    System.out.println("订单:"+orderNumber);
                    checkOutCar(orderNumber) ;
                %>
                <h4 class="ui dividing header">退车成功</h4>
                <div class="ui right button" onclick="returnMainPage()">返回</div>
                <%}%>
            </div>


</body>
</html>
<script>
    $(document).ready(function () {
        $('.ui.form').form({
                // if( /^[0-9]{6}$/.test(car) && /^[1-9][0-9]?$/.test(time) && /^[0-9]{18}$/.test(idcard)
                //         && /^1[3|4|5|8][0-9]\d{4,8}$/.test(phonenumberFF) ){
                carid: {
                    identifier: 'carid',
                    rules: [
                        {
                            type: 'regExp[/^[0-9]{6}$/]',
                            prompt: '汽车号不符合规范'
                        }
                    ]
                }

            }, {

                inline : true,
                on     : 'submit'

            }
        )

        ;
    });
</script>
