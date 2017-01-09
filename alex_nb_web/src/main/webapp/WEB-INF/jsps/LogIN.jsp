<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>log_in</title>
    <script>
        var authRequest = new XMLHttpRequest();
        authRequest.onreadystatechange = function () {
            if (authRequest.readyState == 4
                && authRequest.status == 200) {
                if (authRequest.responseText == '0') {
                    document.getElementById('loginMessage').innerHTML = 'Логін або пароль введені невірно';
                }
                else {
                    window.location = 'index';
                }
            }
        };
        function auth() {
            sendAuthRequest(document.getElementById('login').value, document.getElementById('password').value);
        }
        function sendAuthRequest(login, password) {
            authRequest.open('POST', 'login?login=' + login + '&password=' + password, true);
            authRequest.send();
        }
    </script>
    <style>
        body {
            /*background: url(images/emblema.jpg) no-repeat fixed top right;*/
            background: url(images/office.jpg);
            background-size: 100%;
        }
        #logTable{
            width: 20%;
            font-weight: bolder;
            font-size: x-large;
        }
        button{
            font: inherit;
            color: darkblue;

            width: 100%;
        }
        input{
            font-size: x-large;
            font-weight: bolder;
            width:100%;
        }
    </style>
</head>

<body id="bd">

<div id="wrapper" class="login-form">
    <div class="header">
        <h1>Введіть логін користувача і пароль </h1>
        <h3 style="color: darkred" id="loginMessage"></h3>
    </div>
    <div>
        <table id="logTable">
            <tr>
                <td>
                    <input id="login" type="text" class="login" placeholder="Логін" <%--value="alexandr"--%>/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="password" type="password" class="password" placeholder="Пароль" <%--value="a44n73"--%>/>
                </td>
            </tr>
            <tr>
                <td>
                    <button id="authbut" onclick="auth()">
                        УВІЙТИ
                    </button>
                </td>
            </tr>
        </table>
    </div>
</div>

</body>
</html>