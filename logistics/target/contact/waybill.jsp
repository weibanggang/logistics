<%--
  Created by IntelliJ IDEA.
  User: 小邦哥
  Date: 2018/10/29
  Time: 21:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="./plugins/layui/css/layui.css" media="all">
    <style>
        .rigtop {
            width: 1140px;
            height: 40px;
            border: 1px solid #b7d5df;
            line-height: 40px;
            margin: auto;
            margin-top: 5px;
        }

        .rigbody {
            width: 1140px;
            height: 463px;
            border: 1px solid #b7d5df;
            line-height: 40px;
            margin: auto;
            margin-top: 5px;
        }
    </style>
</head>
<body>

<div class="rigtop">
    <div class="layui-form-item layui-form">
        <div class="layui-inline">
            运单号:
            <div class="layui-inline" style="width:190px">
                <input class="layui-input" id="waybillNo" autocomplete="off">
            </div>
            <div class="layui-inline">
                <button class="layui-btn layui-btns layui-btn-normal" id="waybillNosele" data-type="getCheckData">模糊查询
                </button>
            </div>
        </div>
        <div class="layui-inline">
            发件人手机:
            <div class="layui-inline" style="width:190px">
                <input class="layui-input" name="name" id="sPhone" autocomplete="off">
            </div>
            <div class="layui-inline">
                <button class="layui-btn layui-btns layui-btn-normal" id="sPhonesele" data-type="getCheckData">查询
                </button>
            </div>
        </div>
        <div class="layui-inline">
            收件人手机:
            <div class="layui-inline" style="width:190px">
                <input class="layui-input" name="name" id="rPhone" autocomplete="off">
            </div>
            <div class="layui-inline">
                <button class="layui-btn layui-btns layui-btn-normal" id="rPhonesele" data-type="getCheckData">查询
                </button>
            </div>
        </div>
    </div>
</div>
<div class="rigbody">
    <table id="demo" lay-filter="demo"></table>
</div>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
</script>
<script src="js/jquery.js"></script>
<script src="./plugins/layui/layui.js"></script>
<script>
    var table = null;
    layui.use('table', function () {
        table = layui.table;
        //监听工具条
        table.on('tool(demo)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {
                $("input[name=waybillNo]").val(data.waybillNo);
                $("input[name=number]").val(data.number);
                $("input[name=unit]").val(data.unit);
                $("input[name=sName]").val(data.sName);
                $("input[name=rName]").val(data.rName);
                $("input[name=sPro]").val(data.sPro);
                $("input[name=sCity]").val(data.sCity);
                $("input[name=ePro]").val(data.ePro);
                $("input[name=eCity]").val(data.eCity);
                $("input[name=sAddress]").val(data.sAddress);
                $("input[name=sPhone]").val(data.sPhone);
                $("input[name=rPhone]").val(data.rPhone);
                $("input[name=rAddress]").val(data.rAddress);
                update(data.waybillNo);
            }
        });
        //进行渲染
        xrsj("json");
    });
</script>
<script>

    $("#waybillNosele").click(function () {
        xrsj("waybillNo/" + $("#waybillNo").val());
    })
    $("#sPhonesele").click(function () {
        xrsj("sPhonesele/" + $("#sPhone").val());
    })
    $("#rPhonesele").click(function () {
        xrsj("rPhonesele/" + $("#rPhone").val());
    })

    function update(waybillNo) {
        layer.open({
            type: 1
            , title: "编辑员工信息"
            , content: $("#bj")
            , area: ['950px', '450px']
            , btn: ['修改', '取消'] //只是为了演示
            , yes: function () {
                $.ajax({
                    type: "post"
                    , url: "/waybill/update"
                    , dataType: 'json'
                    , contentType: 'application/json;charset=utf-8'
                    , data: JSON.stringify({
                        waybillNo:  $("input[name=waybillNo]").val(),
                number: $("input[name=number]").val(),
                unit: $("input[name=unit]").val(),
                sName: $("input[name=sName]").val(),
                rName: $("input[name=rName]").val(),
                sPro: $("input[name=sPro]").val(),
                sCity: $("input[name=sCity]").val(),
                ePro: $("input[name=ePro]").val(),
                eCity: $("input[name=eCity]").val(),
                sAddress: $("input[name=sAddress]").val(),
                sPhone: $("input[name=sPhone]").val(),
                rPhone: $("input[name=rPhone]").val(),
                rAddress: $("input[name=rAddress]").val()
            })
            ,
                success: function (data) {
                    layer.msg(data.msg, {time: 1000});
                    if (data.code == 3) {
                        setTimeout(function () {
                            esc();
                            table.reload('idsw');
                        }, 500)
                    }
                }
            })
                ;
            }
            , btn2: function () {
                esc();
            }, cancel: function (index, layero) {
                esc()
                return false;
            }
        });
    }

    //关闭回调事件
    function esc() {
        layer.closeAll();
        $("#bj").attr("hidden", "hidden").css("display", "none");
    }

    function xrsj(url) {
        table.render({
            elem: '#demo'
            , height: 451
            , page: true
            , url: '/waybill/' + url //数据接口
            , cellMinWidth: 130
            , cols: [[ //表头
                {type: 'numbers', title: '序号'}
                , {field: 'waybillNo', title: '运单号', align: 'center'}
                , {field: 'number', title: '数量', align: 'center'}
                , {field: 'unit', title: '单位', align: 'center'}
                , {field: 'sName', title: '发件人姓名', align: 'center'}
                , {field: 'sPhone', title: '发件人手机', align: 'center'}
                , {field: 'rName', title: '收件人姓名', align: 'center'}
                , {field: 'rPhone', title: '收件人手机', align: 'center'}
                , {field: 'right', title: '操作', width: '178', align: 'center', toolbar: '#barDemo'}
            ]]
            , id: "idsw"
        });
    }
</script>
<form class="layui-form" id="bj" hidden="hidden">
    <div class="layui-form-item">
        <label class="layui-form-label">运单号</label>
        <div class="layui-input-inline">
            <input type="text" readonly="readonly" name="waybillNo" maxlength="11" required lay-verify="required"
                   placeholder="请输入运单号码" autocomplete="off" class="layui-input">
        </div>
        <label class="layui-form-label">数 量</label>
        <div class="layui-input-inline">
            <input type="number" name="number" maxlength="11" required lay-verify="required" placeholder="请输入数量"
                   autocomplete="off" class="layui-input">
        </div>
        <label class="layui-form-label">单 位</label>
        <div class="layui-input-inline">
            <input type="text" name="unit" maxlength="11" required lay-verify="required" placeholder="请输入单位"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">发件人</label>
        <div class="layui-input-inline">
            <input type="text" name="sName" maxlength="11" required lay-verify="required" placeholder="请输入发件人姓名"
                   autocomplete="off" class="layui-input">
        </div>
        <label class="layui-form-label">起始省份</label>
        <div class="layui-input-inline">
            <input type="text" name="sPro" maxlength="11" required lay-verify="required" placeholder="请输入起始省份"
                   autocomplete="off" class="layui-input">
        </div>
        <label class="layui-form-label">起始城市</label>
        <div class="layui-input-inline">
            <input type="text" name="sCity" maxlength="11" required lay-verify="required" placeholder="请输入起始城市"
                   autocomplete="off" class="layui-input">
        </div>

    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">收件人</label>
        <div class="layui-input-inline">
            <input type="text" name="rName" maxlength="11" required lay-verify="required" placeholder="请输入收件人姓名"
                   autocomplete="off" class="layui-input">
        </div>
        <label class="layui-form-label">目的省份</label>
        <div class="layui-input-inline">
            <input type="text" name="ePro" maxlength="11" required lay-verify="required" placeholder="请输入目的省份"
                   autocomplete="off" class="layui-input">
        </div>
        <label class="layui-form-label">目的城市</label>
        <div class="layui-input-inline">
            <input type="text" name="eCity" maxlength="11" required lay-verify="required" placeholder="请输入目的城市"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">发件地址</label>
        <div class="layui-input-inline">
            <input type="text" name="sAddress" maxlength="11" required lay-verify="required" placeholder="请输入发件地址"
                   autocomplete="off" class="layui-input">
        </div>


        <label class="layui-form-label">发件手机</label>
        <div class="layui-input-inline">
            <input type="text" name="sPhone" maxlength="11" required lay-verify="required" placeholder="请输入发件人手机"
                   autocomplete="off" class="layui-input">
        </div>
        <label class="layui-form-label">收件手机</label>
        <div class="layui-input-inline">
            <input type="text" name="rPhone" maxlength="11" required lay-verify="required" placeholder="请输入收件人手机"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">收件地址</label>
        <div class="layui-input-block">
            <input type="text" name="rAddress" maxlength="11" required lay-verify="required" placeholder="请输入收件地址"
                   autocomplete="off" class="layui-input">
        </div>
    </div>

</form>
</body>
</html>
