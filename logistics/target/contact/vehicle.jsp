<%--
  Created by IntelliJ IDEA.
  User: 小邦哥
  Date: 2018/10/29
  Time: 19:40
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
            车牌号码:
            <div class="layui-inline" style="width:190px">
                <input class="layui-input" id="license" autocomplete="off">
            </div>
            <div class="layui-inline">
                <button class="layui-btn layui-btns layui-btn-normal" id="staffNosele" data-type="getCheckData" >模糊查询</button>
            </div>
        </div>
        <div class="layui-inline">
            品  牌:
            <div class="layui-inline" style="width:190px">
                <input class="layui-input" name="name" id="vType" autocomplete="off">
            </div>
            <div class="layui-inline">
                <button class="layui-btn layui-btns layui-btn-normal" id="staffNamesele" data-type="getCheckData" >模糊查询</button>
            </div>
        </div>
    </div>
</div>
<div class="rigbody">
    <table id="demo" lay-filter="demo"></table>
</div>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script src="./js/jquery.js"></script>
<script src="./plugins/layui/layui.js"></script>
<script>
    layui.use('table', function () {
        table = layui.table;
        //监听工具条
        table.on('tool(demo)', function (obj) {
            var data = obj.data;
            if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    del(data.license);
                    layer.close(index);
                });
            } else if (obj.event === 'edit') {
                update(data.license,data.vType,data.staffNo,data.vload);
            }
        });
        //进行渲染
        xrsj("json");
    });
</script>
<script>
    function xrsj(url) {
        table.render({
            elem: '#demo'
            , height: 451
            , page: true
            , url: '/vehicle/'+url //数据接口
            , cellMinWidth: 150
            , cols: [[ //表头
                {type: 'numbers', title: '序号'}
                , {field: 'license', title: '车牌号', align: 'center'}
                , {field: 'vType', title: '品牌', align: 'center'}
                , {field: 'vload', title: '载重', align: 'center'}
                , {field: 'staffNo', title: '员工编号', align: 'center'}
                , {
                    title: '员工姓名', align: 'center', templet: function (row) {
                        return row.depart.staffName
                    }
                }
                , {
                    title: '员工电话', align: 'center', templet: function (row) {
                        return row.depart.phone
                    }
                }
                , {field: 'right', title: '操作', width: '178', align: 'center', toolbar: '#barDemo'}
            ]]
            , id: "idsw"
        });
    }

    function  update(license,vType,staffNo,vload) {
        $("input[name=license]").val(license);
        $("input[name=vType]").val(vType);
        $("input[name=staffNo]").val(staffNo);
        $("input[name=vload]").val(vload);

        layer.open({
            type: 1
            , title: "修改车辆信息"
            , content: $("#bj")
            , area: ['500px', '320px']
            , btn: ['修改', '取消'] //只是为了演示
            , yes: function () {
                $.ajax({
                    type: "post"
                    , url: "/vehicle/update"
                    , dataType: 'json'
                    ,contentType : 'application/json;charset=utf-8'
                    ,data:JSON.stringify({
                        license:$("input[name=license]").val()
                        ,vType:$("input[name=vType]").val()
                         ,staffNo:$("input[name=staffNo]").val()
                        , vload:$("input[name=vload]").val()
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
                });x
            }
            , btn2: function () {
                esc();
            }, cancel: function (index, layero) {
                esc()
                return false;
            }
        });
    }
    $("#staffNosele").click(function () {
        xrsj("ById/"+$("#license").val());
    })
    $("#staffNamesele").click(function () {
        xrsj("ByName/"+$("#vType").val());
    })
    //删除公司
    function del(license) {
        $.ajax({
            type: "post"
            , url: "/vehicle/del/" + license
            , dataType: 'json'
            , success: function (data) {
                layer.msg(data.msg, {time: 1000});
                if (data.code == 3) {
                    table.reload('idsw');
                }
            }
        });
    }
    //关闭回调事件
    function esc() {
        layer.closeAll();
        $("input[name=license]").val("");
        $("input[name=vType]").val("");
        $("input[name=staffNo]").val("");
        $("input[name=vload]").val("");
        $("#bj").attr("hidden", "hidden").css("display", "none");
    }
</script>
</body>
<form id="bj" class="layui-form" hidden="hidden">
    <form class="layui-form"   >
        <div class="layui-form-item">
            <label class="layui-form-label">车牌号码：</label>
            <div class="layui-input-inline" >
                <input type="text" name="license" value="${param.license}" maxlength="11" required lay-verify="required" placeholder="请输入车牌号码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">品牌：</label>
            <div class="layui-input-inline">
                <input type="text" name="vType" value="${param.vType}" maxlength="20" required lay-verify="required" placeholder="请输入品牌" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">员工编号：</label>
            <div class="layui-input-inline">
                <input type="text" name="staffNo"  value="${param.staffNo}"  maxlength="5" autocomplete="off" class="layui-input" placeholder="请输入员工编号">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">载重：</label>
            <div class="layui-input-inline">
                <input type="text" name="vload" value="${param.vload}"  maxlength="10" required lay-verify="required" placeholder="请输入载重" autocomplete="off" class="layui-input">
            </div>
        </div>
    </form>
</form>
</html>
