$(document).ready(function () {
    var ftab = $('.findTab');
    var ltab = $('.lotTab');

    calculate();

    $('#findObjBut').on('click', function () {
        ltab.hide();
        $('.findTab').find('.ftr').remove();
        ftab.show();

        $.ajax({
            url: "creditsByClient",
            method: "POST",
            data: {
                inn: $('#inn').val(),
                idBars: $('#idBars').val()
            },
            success(obj){

                for (var i = 0; i < obj.length; i++) {
                    var approveNBU = obj[i].nbuPladge ? "Так" : "Ні";
                    var tr = $('<tr class="ftr" align="center">' +
                        '<td class="idObj">' + obj[i].id + '</td>' +
                        '<td>' + obj[i].inn + '</td>' +
                        '<td>' + obj[i].fio + '</td>' +
                        '<td>' + obj[i].product + '</td>' +
                        '<td>' + obj[i].region + '</td>' +
                        '<td>' + obj[i].zb + '</td>' +
                        '<td>' + obj[i].rv + '</td>' +
                        '<td>' + approveNBU + '</td>' +
                        '</tr>');

                    var addButton = $('<button id="addButton">Додати в лот</button>');
                    addButton.on('click', function () {
                        var thisTr = $(this).parent();
                        ltab.append(thisTr);
                        $(this).remove();

                        var delButton = $('<button id="delButton">Видалити</button>');
                        thisTr.append(delButton);
                        delButton.on('click', function () {
                            $(this).parent().remove();
                            calculate();
                        });
                        calculate();
                    });
                    var messageTd = $('<td bgcolor="#00ffff">Вже додано до лоту</td>');

                    ftab.append(tr);
                    tr.append(addButton);

                    var idF = tr.children().first().text();
                    var lids = ltab.find('.idObj');
                    for (var j = 0; j < lids.length; j++) {
                        if (lids[j].innerHTML == idF) {
                            addButton.remove();
                            tr.append(messageTd);
                        }
                    }
                }
            }
        });
    });
    $('#showLCrdts').on('click', function () {
        ftab.hide();
        ltab.show();
    });

    function calculate() {
        var tdId = ltab.find('.idObj');

        var idl = "";
        for (var i = 0; i < tdId.length; i++) {
            idl = idl + ',' + tdId[i].innerHTML;
        }
        $.ajax({
            url: "sumByIDBars",
            method: "POST",
            data: {idMass: idl},
            success(summ){
                if (summ)
                    $('#priceId').text(summ);
                $('#kolId').text(tdId.length);
            }
        });
    }

    $('#createLot').on('click', function createLot() {
        var tdId = ltab.find('.idObj');
        var idl = "";
        for (var i = 0; i < tdId.length; i++) {
            idl = idl + ',' + tdId[i].innerHTML;
        }
        $.ajax({
            url: "createCreditLot",
            method: "POST",
            data: {
                idMass: idl,
                comment: $('#commIn').val()
            },
            success(ok){
                if (ok == '1') {
                    alert("Лот створено!");
                    location.href = "lotRedactor";
                }
                else
                    alert("Лот не створено!");
            }
        });
    });
});