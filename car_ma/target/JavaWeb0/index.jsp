<%@ page import="com.mysql.cj.api.Session" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>汽车租赁管理系统登录</title>
  <link rel="stylesheet" type="text/css" href="/semantic/dist/semantic.min.css">
  <script src="/semantic/dist/jquery.min.js"></script>
  <script src="/semantic/dist/semantic.js"></script>
</head>

<style type="text/css">
  body {
    background-color: #DADADA;
    background-size: 100% 100%;
  }
  body > .grid {
    height: 100%;
  }
  .image {
    margin-top: -100px;
  }
  .column {
    max-width: 450px;
  }
</style>
<script>
    $(document).ready(function () {
        $('.ui.form').form({
                id: {
                    identifier: 'id',
                    rules: [
                        {
                            type: 'regExp[/^[a-z0-9A-Z]{1,10}$/]',
                            prompt: '用户名不符合规范！'
                        }
                    ]
                },
                password: {
                    identifier: 'password',
                    rules: [
                        {
                            type: 'regExp[/^[a-z0-9A-Z]{1,10}$/]',
                            prompt: '密码不符合规范'
                        }
                    ]
                }
                ,onSuccess: function () {
                    document.getElementById("form1").submit();
                }
            }, {
                inline: true,
                on: 'submit'

            }

        )

        ;
    });
</script>

<body>
<div class="ui middle aligned center aligned grid">
  <div class="column">
    <h1 class="ui blue header">汽车租赁管理系统登录</h1>
    <form class="ui large form" id="form1" method="post" action="/LoginServlet">



        <div class="field" align="center">
          <div class="inline fields">
            <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>

            <div class="field">
              <div class="ui radio checkbox">
                <input type="radio" name="admin" value="1" checked="checked">
                <label style="color:blue;"><i class="users icon"></i>租赁管理员</label>
              </div>
            </div>

            <div class="field" align="center">
              <div class="ui radio checkbox">
                <input type="radio" name="admin" value="0" >
                <label style="color:blue;"><i class="user icon"></i>系统管理员</label>
              </div>
            </div>



          </div>
          <div class="field">
            <div class="ui left icon input">
              <i class="user icon"></i>
              <input type="text" id="id" name="id" placeholder="用户名">
            </div>
          </div>
          <div class="field">
            <div class="ui left icon input">
              <i class="lock icon"></i>
              <input type="password" id="password" name="password" placeholder="密码">
            </div>
          </div>
          <div >
            <%--<input   onclick="fun()" value="登录" class="ui primary button">--%>
            <input  type="submit"  value="登录" class="ui fluid large blue submit button">
            <%--<div class="ui fluid large button">登录</div>--%>
          </div>
        </div>

          <% if(  request.getSession().getAttribute("error")!=null ) { %>
        <div class="ui red message">
          <%=request.getSession().getAttribute("error").toString() %>
        </div>
          <%}
                if(request.getSession().getAttribute("error")!=null )
                        request.getSession().removeAttribute("error"); %>

    </form>
  </div>
</div>
</body>

</html>