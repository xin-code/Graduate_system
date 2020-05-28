<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entity.*" %>
<%@ page import="static tool.Query.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="config.GCON" %>
<%@ page import="java.util.Map" %>
<%@ page import="tool.Query" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Map<String, String[]> map = request.getParameterMap() ;
    int op = Integer.parseInt(map.get("op")[0]) ; //通过op选项来控制页面显示的内容
%>

<html>
<head>
    <meta charset="UTF-8">
    <title>汽车租赁管理系统</title>
    <script>

        function returnMainPage() {
            window.location.href="/carManagement/carAdd.jsp?op=2";
        }

        function submitNewCarInfo() {

            var carNumber = document.getElementById("carNumber").value;
            var carType = document.getElementById("carType").value;
            var remarks = document.getElementById("remarks").value;
            if( /^[0-9]{6}$/.test(carNumber)){
                var url = "&carNumber=" + carNumber + "&carType=" + carType + "&remarks=" + remarks;
                window.location.href = "/carManagement/carAdd.jsp?op=3" + url;
            }
            return false ;
        }

        function ensureButtonClicked() {

            // var carnumber = document.getElementById('carNumber')
            // var cartype= document.getElementById('carType')

            var urlNew = window.location.href.split("&")[1] + "&" + window.location.href.split("&")[2]
                + "&" + window.location.href.split("&")[3];

            window.location.href = "/carManagement/carAdd.jsp?op=4&" + urlNew;


        }

    </script>

</head>
<%@include file="/hotelAdmin.jsp"%>
<body>

<div class="pusher">

    <div class="ui container">
        <h2 class="ui header">添加车辆</h2>
        <div class="ui column grid">
            <div class="four wide column">
                <div class="ui vertical steps">

                    <div class="<%=(op == 2) ? "active step ":"completed step"%>" >
                        <i class="add circle icon"></i>
                        <div class="content">
                            <div class="title">汽车信息</div>
                        </div>
                    </div>

                    <div class="<%=(op == 3) ? "active step ":(op== 2)?"step":"completed step"%>">
                        <i class="check circle icon"></i>
                        <div class="content">
                            <div class="title">信息确认</div>
                        </div>
                    </div>

                </div>

            </div>

            <div class="eleven wide  column" >

                <%//添加客房信息
                    if (op == 2) {
                %>
                <form class="ui form" onsubmit="return submitNewCarInfo(this)">
                    <h2 class="ui dividing header">填写新增车辆信息</h2>
                    <div class="two fields">
                        <div class="field">
                            <label>车牌号</label>
                            <input type="text" id="carNumber" name="carid" placeholder="输入房间号">
                        </div>
                        <div class="field">
                            <label>车辆类型</label>
                            <% ArrayList<CarTypeAndPrice> cars = getAllCars();%>
                            <select class="ui fluid dropdown" id="carType">
                                <%for(CarTypeAndPrice car :cars){%>
                                <option value=<%=car.getCarType()%>><%=car.getCarType()%></option>
                                <%}%>
                            </select>
                        </div>
                    </div>
                    <div class="field">
                        <label>备注</label>
                        <input type="text" id="remarks" placeholder="备注信息">
                    </div>
                    <div class="ui submit button">提交</div>
                </form>

                <%} else if (op == 3) {
                %>

                <h2 class="ui dividing header">待添加车辆信息确认</h2>
                <form class="ui form">
                    <table class="ui table">
                        <thead>
                        <tr><th class="six wide">车牌号</th>
                            <th class="six wide">车辆类型</th>
                            <th class="six wide">备注</th>
                        </tr></thead>
                        <tbody>
                        <tr>
                            <td><%=request.getParameter("carNumber")%></td>
                            <td><%=request.getParameter("carType")%></td>
                            <td><%=request.getParameter("remarks")%></td>
                        </tr>
                        </tbody>
                    </table>

                    <div class="ui button" onclick="ensureButtonClicked()">确认</div>
                </form>

                <%} else if (op == 4) {
                    Car newCar = new Car();
                    newCar.setCarStatus("空");
                    newCar.setCarNumber(request.getParameter("carNumber"));
                    newCar.setCarType(request.getParameter("carType"));
                    newCar.setRemarks(request.getParameter("remarks"));
                    Query.insertCar(newCar);
                %>
                <h4 class="ui dividing header">添加成功</h4>
                <div class="ui right button" onclick="returnMainPage()">返回</div>
                <%}%>
            </div>
        </div>
    </div>

    <%--<h1>欢迎宾馆管理员登录！</h1>--%>

</div>

</body>
</html>
<script>
    $(document).ready(function () {
        $('.ui.form').form({
                // if( /^[0-9]{6}$/.test(car) && /^[1-9][0-9]?$/.test(time) && /^[0-9]{18}$/.test(idcard)
                //         && /^1[3|4|5|8][0-9]\d{4,8}$/.test(phonenumber) ){
                carid: {
                    identifier: 'carid',
                    rules: [
                        {
                            type: 'regExp[/^[0-9]{6}$/]',
                            prompt: '房间号不符合规范'
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