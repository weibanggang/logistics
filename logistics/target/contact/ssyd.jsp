<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/4
  Time: 7:48
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
                <button class="layui-btn layui-btns layui-btn-normal" id="waybillNosele" data-type="getCheckData" >查询</button>
            </div>

        </div>
        <div class="layui-inline">
            <div class="layui-inline">
                <button class="layui-btn layui-btns layui-btn-normal" id="add" data-type="getCheckData" >更新位置</button>
            </div>

        </div>
    </div>
</div>
<div class="rigbody">
        <table id="demo" lay-filter="demo"></table>
</div>
<script type="text/html" id="toolbarDemo1">
    <div class="layui-btn-container">
        <label style="font-size: 15px;margin-left: 205px;" lay-event="getCheckData">部门信息表</label>
    </div>
</script>
<script type="text/html" id="toolbarDemo2">
    <div class="layui-btn-container">
        <label style="font-size: 15px;margin-left: 215px;" lay-event="getCheckData"><span>分公司信息表</span></label>
    </div>
</script>
<script src="./js/jquery.js"></script>
<script src="./plugins/layui/layui.js"></script>

<script>
    layui.use(['table'], function () {
        table = layui.table;
        xrsj("json");
    })
</script>

<script>
    $("#waybillNosele").click(function () {
        xrsj("selectWaybillNo/"+$("#waybillNo").val());
    })
    $("#add").click(function () {
        layer.open({
            type: 1
            , title: "更新实时信息"
            , content: $("#bj")
            , area: ['350px', '230px']
            , btn: ['更新', '取消'] //只是为了演示
            , yes: function () {
                $.ajax({
                    type: "post"
                    , url: "/positions/add"
                    , dataType: 'json'
                    ,contentType : 'application/json;charset=utf-8'
                    ,data:JSON.stringify({
                        waybillNo:$("input[name=waybillNo]").val(),
                        pPosition:$("input[name=pPosition]").val(),
                    })
                    , success: function (data) {
                        layer.msg(data.msg, {time: 1000});
                        if (data.code == 3) {
                            setTimeout(function () {
                                esc();
                                table.reload('idsw');
                            },500)
                        }
                    }
                });
            }
            , btn2: function () {
                esc();
            }, cancel: function (index, layero) {
                esc()
                return false;
            }
        });
    })

    function xrsj(url) {
        table.render({
            elem: '#demo'
            , height: 451
            , page: true
            , url: '/positions/'+url //数据接口
            , cols: [[ //表头
                {type:'numbers',title: '序号'}
                , {field: 'waybillNo', title: '运单号', align: 'center'}
                , {field: 'pTime', title: '时间', align: 'center',sort: true}
                , {field: 'pPosition', title: '位置', align: 'center'}
            ]]
            , id: "idsw"
        });
    }
    function esc() {
        layer.closeAll();
        $("#bj").attr("hidden", "hidden").css("display", "none");
    }
</script>
</body>
<form class="layui-form" id="bj" hidden="hidden">
    <div class="layui-form-item">
        <label class="layui-form-label">运单号：</label>
        <div class="layui-input-inline" >
            <input type="text" name="waybillNo"  maxlength="15" required lay-verify="required" placeholder="请输入运单号" autocomplete="off" class="layui-input">
        </div>
        <label class="layui-form-label">位置：</label>
        <div class="layui-input-inline" >
            <input type="text" name="pPosition"   required lay-verify="required" placeholder="请输入位置" autocomplete="off" class="layui-input">
        </div>
    </div>
</form>
</html>
