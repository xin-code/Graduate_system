<%@ page import="entity.*" %>
<%@ page import="static tool.Query.getAllCars" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="static tool.Query.searchFullCars" %>
<%@ page import="static tool.Query.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="javax.print.DocFlavor" %>
<%@ page import="display.OrderView" %>
<%@ page import="tool.Query" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String rs1[] = {"空","非空","任意"}  ;
    Map<String, String[]> map =request.getParameterMap() ;


    String size1=""  ;
    if( map.get("size1")!=null ){
        size1 = map.get("size1")[0] ;
    }

    String search ="" ;
    if(map.get("search")!=null){
        search =map.get("search")[0]  ;
    }
    ArrayList<Car> allCarsInfo = getAllCarsInfo(size1,search);
    HashMap<String, CarTypeAndPrice> carTypeMap = getCarTypeMap();

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
    <script>
        function fun() {
            var obj = document.getElementsByName("size1");//选择所有name="id"的对象，返回数组
            var v='';//如果这样定义var v;变量v中会默认被赋个null值
            for(var i=0;i<obj.length;i++){
                if(obj[i].checked) {//取到对象数组后，我们来循环检测它是不是被选中
                    v+=('size1='+obj[i].value);
                }  //如果选中，将value添加到变量v中
            }
            window.location.href='/carManagement/carDisplay.jsp?'+v
        }

        function fun1( cartype,carid) {
            window.location.href='/carOrder.jsp?op=2&cartype='+cartype+'&carid='+carid

        }
        function fun2() {
            var carid = document.getElementById('carid').value
            window.location.href='/carManagement/carDisplay.jsp?search='+carid
        }
    </script>


</head>
<%@include file="/hotelAdmin.jsp"%>
<body>
<div class="pusher">
    <div class="ui container">
        <h2 class="ui header">车辆概览</h2>
        <div class="ui column grid">
            <div class="four wide column">
                <div class="ui vertical  menu">
                    <div class="item">
                        <a class="active title">
                            <i class="dropdown icon"></i>
                            状态
                        </a>
                        <div class="active content">
                            <div class="ui form">
                                <div class="grouped fields">
                                    <%for (String s : rs1){%>
                                    <div class="field">
                                        <div class="ui radio checkbox">
                                            <input type="radio" name="size1" value=<%=s%>  <%=s.equals(size1)?"checked":""%> onclick="fun()">
                                            <label><%=s%></label>
                                        </div>
                                    </div>
                                    <%}%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="eleven wide  column" >
                <div class="ui search ">
                    <div class="ui icon input">
                        <input class="prompt" type="text" id="carid" <% if(!search.equals("")){ %>
                               value=<%=search%>
                                   <% }%> placeholder="Search Cars...">

                    </div>
                    <div class="ui button" onclick="fun2()"> <i class="search icon"></i>车牌号检索</div>
                </div>

                <br>
                <div class="ui three cards" >

                    <% for (Car carinfo :allCarsInfo){ %>
                    <div class="card" >
                        <div class=" fluid image" >
                            <a class="ui big blue right corner label" >
                                <%=carinfo.getCarStatus()%>
                            </a>
                            <img src=<%=carTypeMap.get(carinfo.getCarType()).getUrl()%> width="400" height="300"
                                 onclick="<%=carinfo.getCarStatus().equals("非空")?"":"fun1('"+carinfo.getCarType()+"','"+carinfo.getCarNumber()+"')" %> ">
                        </div>
                        <div class="extra">
                            carid:<%=carinfo.getCarNumber()%><br>
                            车型:<%=carinfo.getCarType()%><br>
                            <% if(carinfo.getCarStatus().equals("非空")){
                                OrderView view = Query.getFullOrderViews(carinfo.getCarNumber());
                            %>
                            入住用户:<%=view.getCustomer()%><br>
                            到期时间:<%=view.getCheckOutTime()%><br>
                            <%} %>
                        </div>
                    </div>
                    <%}%>
                </div>
            </div>
        </div>
    </div>


</div>
</body>
</html>