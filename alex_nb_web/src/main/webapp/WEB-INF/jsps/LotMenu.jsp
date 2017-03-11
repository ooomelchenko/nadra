<%@ page import="nadrabank.domain.Bid" %>
<%@ page import="nadrabank.domain.Lot" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
        List<Lot> lotList = (List<Lot>) request.getAttribute("lotList");

        TreeSet <Date> dateSet = new TreeSet<Date>();
        for(Lot lot: lotList){
            if(lot.getBid()!=null&&lot.getBid().getBidDate()!=null)
                dateSet.add(lot.getBid().getBidDate());
        }
        TreeSet <String> exchangeSet = new TreeSet<String>();
        for(Lot lot: lotList){
            if(lot.getBid()!=null&&lot.getBid().getExchange()!=null)
                exchangeSet.add(lot.getBid().getExchange().getCompanyName());
        }
    %>
    <title>Меню лотів</title>
    <link rel="stylesheet" media="screen" type="text/css" href="css/lotMenuStyle.css"/>
    <script src="js/jquery-1.11.1.js"></script>
    <script src="js/lotsMenu.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            function checkBids(){
            $('.bidStatus').each(function(){
                if($(this).text()=="Торги не відбулись")
                    $(this).parent().css('color', 'red');
            });
            $('.neadNewFondDec').each(function() {
                if($(this).text()=="Так")
                    $(this).css('background-color', 'pink');
            });
            }
            checkBids();
            var dateSelector = $('.dateSelector');
            var exSelector = $('.exSelector');
            var bidStatusSelector = $('.bidStatusSelector');

            bidStatusSelector.click(function(){
                $('.bidStatusHide').each(function(){
                    $(this).removeClass();
                    $(this).addClass("bidStatus");
                });

                if ($(this).text()!="всі"){
                    var selectedStatus = $(this).text();
                    $('.bidStatus').each(function(){
                        if($(this).text()!=selectedStatus){
                            $(this).removeClass();
                            $(this).addClass("bidStatusHide");
                        }
                    });
                }
                filterLots();
            });

            dateSelector.click(function(){
                $('.bidDateHide').each(function(){
                    $(this).removeClass();
                    $(this).addClass("bidDate");
                });

                if ($(this).text()!="всі дати"){
                    var selectedDate = $(this).text();
                    $('.bidDate').each(function(){
                        if($(this).text()!=selectedDate){
                            $(this).removeClass();
                            $(this).addClass("bidDateHide");
                        }
                    });
                }
                filterLots();
            });

            exSelector.click(function(){
                $('.companyHide').each(function(){
                    $(this).removeClass();
                    $(this).addClass("company");
                });

                if ($(this).text()!="всі біржі"){
                    var exSelected = $(this).text();
                    $('.company').each(function(){
                        if($(this).text()!=exSelected){
                            $(this).removeClass();
                            $(this).addClass("companyHide");
                        }
                    });
                }
                filterLots()
            });

            function filterLots(){
                $('.trL').show();
                $('.bidDateHide').each(function(){
                    $(this).parent().hide();
                });
                $('.companyHide').each(function(){
                    $(this).parent().hide();
                });
                $('.bidStatusHide').each(function(){
                    $(this).parent().hide();
                });
            }

            var i=0;
            $('.spoiler_links').click(function(){
                if(i===0){
                    $(this).children('div.spoiler_body').slideDown('fast');
                    i=1;
                }
                else{
                    $(this).children('div.spoiler_body').slideUp('fast');
                    i=0;}
            });
        });
    </script>
</head>
<body id="bd" style="background-color: mintcream">
<div id="blockHead">
    <div id="backBlock">
        <img class="beckImg" onclick="location.href='index'" src="images/back.png" title="назад">
    </div>
    <div id="headerBlock">
        <H1 align="center">Меню лотів</H1>
    </div>
    <div id="buttonsBlock">
        <table>
            <tr align="left">
                <td>
                    <button id="createSingleLot" onclick="location.href ='lotCreator'">
                        Новий лот активів
                    </button>
                </td>
                <td>
                    <img src="images/plus_green.png"/>
                </td>
            </tr>
            <tr>
                <td>
                    <button id="createCrLot" onclick="location.href ='lotCreditsCreator'">
                        Новий лот кредитів
                    </button>
                </td>
                <td>
                    <img src="images/plus_blue.png"/>
                </td>
            </tr>
        </table>
    </div>
</div>

<div id="lotsDiv" class="view">
    <table id="lTable" <%--border="1"--%> class="table">
        <tr class="trh" style="background-color: #00ffff">
            <th>ID</th>
            <th title="Натисніть для відображення фільтру">
                <div class="spoiler_links">Дата торгів^
                    <div class="spoiler_body" >
                        <b class="dateSelector" >всі дати</b>
                        <br>
                        <% for(Date date: dateSet){%>
                        <b class="dateSelector" ><%out.print(sdf.format(date));%></b>
                        <br>
                        <%}%>
                    </div>
                </div>
            </th>
            <th title="Натисніть для відображення фільтру">
                <div class="spoiler_links" style="width: 100%; height: 100%">Біржа^
                    <div class="spoiler_body" >
                        <b class="exSelector">всі біржі</b>
                        <br>
                        <% for(String exchangeName: exchangeSet){%>
                        <b class="exSelector"><%out.print(exchangeName);%></b>
                        <br>
                        <%}%>
                    </div>
                </div>
            </th>
            <th>Оціночна вартість, грн.</th>
            <th>Торги</th>
            <th title="Натисніть для відображення фільтру">
                <div class="spoiler_links" style="width: 100%; height: 100%">Статус аукціону^
                    <div class="spoiler_body">
                        <b class ="bidStatusSelector">всі</b>
                        <br>
                        <b class ="bidStatusSelector">Торги не відбулись</b>
                        <br>
                        <b class ="bidStatusSelector">Торги відбулись</b>
                    </div>
                </div>
            </th>
            <th>№ Лоту в публікації</th>
            <th>Початкова ціна лоту, грн.</th>
            <%--<th>Кількість зареєстрованих учасиків</th>--%>
            <th>Ціна реалізації, грн.</th>
            <th>Статус оплати</th>
            <th>Сума сплати</th>
            <%--<th>Залишок оплати, грн.</th>--%>
            <th>Стадія роботи</th>
            <th>Покупець</th>
            <th>Акт підписано</th>
            <%--<th>Співробітник</th>--%>
            <th>Коментар</th>
            <th>Потребує перепогодження ФГВФО</th>
        </tr>
        <%for(Lot lot: lotList){Bid bid = lot.getBid();%>
        <tr class="trL" align="center">
            <td class="lotId" <%if(lot.getLotType()==0) out.print("bgcolor='#add8e6'");%> ><%=lot.getId()%></td>
            <td class="bidDate"><%if(bid!=null&&bid.getBidDate()!=null){out.print(sdf.format(bid.getBidDate()));}%></td>
            <td class="company"><%if(bid!=null&&bid.getExchange()!=null)out.print(bid.getExchange().getCompanyName());%></td>
            <td class="sumOfCrd"></td>
            <td class="bidStage"><%out.print(lot.getBidStage());%></td>
            <td class="bidStatus" ><%if(lot.getStatus()!=null)out.print(lot.getStatus());%></td>
            <td class="lotNum"><%if(lot.getLotNum()!=null)out.print(lot.getLotNum());%></td>
            <td class="startPrice"><%if(lot.getStartPrice()!=null)out.print(lot.getStartPrice());%></td>
            <td class="factPrice"><%if(lot.getFactPrice()!=null)out.print(lot.getFactPrice());%></td>
            <td class="payStatus"></td>
            <td class="paymentsSum"></td>
            <%--<td align="center" class="residualToPay"></td>--%>
            <td class="workstage"><%=lot.getWorkStage()%></td>
            <td class="customer"><%if(lot.getCustomerName()!=null)out.print(lot.getCustomerName());%></td>
            <td class="aktDate"><%if(lot.getActSignedDate()!=null)out.print(sdf.format(lot.getActSignedDate()));%></td>
            <%--<td align="center" class="user"><%=lot.getUser().getLogin()%></td>--%>
            <td class="comment"><%if(lot.getComment()!=null)out.print(lot.getComment());%></td>
            <td class="neadNewFondDec"><%if(lot.isNeedNewFondDec()){out.print("Так");} else out.print("Ні");%></td>
        </tr>
        <%}%>
    </table>
</div>

</body>
</html>