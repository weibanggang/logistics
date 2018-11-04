<%--
  Created by IntelliJ IDEA.
  User: 小邦哥
  Date: 2018/10/29
  Time: 21:11
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
            路线名称:
            <div class="layui-inline" style="width:190px">
                <input class="layui-input" id="routeName" autocomplete="off">
            </div>
            <div class="layui-inline">
                <button class="layui-btn layui-btns layui-btn-normal" id="routeNamesele" data-type="getCheckData" >模糊查询</button>
            </div>
        </div>
        <div class="layui-inline">
            编  号:
            <div class="layui-inline" style="width:190px">
                <input class="layui-input" name="name" id="routeNo" autocomplete="off">
            </div>
            <div class="layui-inline">
                <button class="layui-btn layui-btns layui-btn-normal" id="routeNosele" data-type="getCheckData" >查  询</button>
            </div>
        </div>
    </div>
</div>
<div class="rigbody">
    <table id="demo" lay-filter="demo"  ></table>
</div>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script src="./js/jquery.js"></script>
<script src="./plugins/layui/layui.js"></script>
<script>
    var table = null;
    layui.use('table', function () {
        table = layui.table;
        //监听工具条
        table.on('tool(demo)', function (obj) {
            var data = obj.data;
             if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    del(data.routeNo);
                    layer.close(index);
                });
            } else if (obj.event === 'edit') {
                 update(data.routeName,data.staffNo,data.routeNo);
            }
        });
        xrsj("json");
    });
</script>

<script>
    function  update(routeName,staffNo,routeNo) {
        $("input[name=routeName]").val(routeName);
        $("input[name=staffNo]").val(staffNo);
        layer.open({
            type: 1
            , title: "修改路线信息"
            , content: $("#bj")
            , area: ['500px', '320px']
            , btn: ['修改', '取消'] //只是为了演示
            , yes: function () {
                $.ajax({
                    type: "post"
                    , url: "/route/update"
                    , dataType: 'json'
                    ,contentType : 'application/json;charset=utf-8'
                    ,data:JSON.stringify({
                        routeName:$("input[name=routeName]").val()
                        ,staff:$("input[name=staffNo]").val()
                        ,routeNo:routeNo
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
    }
    $("#routeNamesele").click(function () {
        xrsj("ByName/"+$("#routeName").val());
    })
    $("#routeNosele").click(function () {
        xrsj("ById/"+$("#routeNo").val());
    })

    function xrsj(url) {
        //进行渲染
        table.render({
            elem: '#demo'
            , height: 451
            , page: true
            , url: '/route/'+url //数据接口
            , cellMinWidth: 182
            , cols: [[ //表头
                {type:'numbers',title: '序号'}
                , {field: 'routeNo', title: '编号', align: 'center'}
                , {field: 'routeName', title: '路线名称', align: 'center'}
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

    //删除公司
    function del(routeNo) {
        $.ajax({
            type: "post"
            , url: "/route/del/" + routeNo
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
        $("input[name=routeName]").val("");
        $("input[name=staffNo]").val("");
        $("#bj").attr("hidden", "hidden").css("display", "none");
    }


</script>
</body>
<form id="bj" class="layui-form" hidden="hidden">
    <form class="layui-form"   >
        <div class="layui-form-item">
            <label class="layui-form-label">路线名称：</label>
            <div class="layui-input-block" >
                <input type="text" name="routeName" value="${param.routeName}" maxlength="11" required lay-verify="required" placeholder="请输入路线" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">员工编号：</label>
            <div class="layui-input-inline">
                <input type="text" name="staffNo" value="${param.staff}" maxlength="20" required lay-verify="required" placeholder="请输入员工编号" autocomplete="off" class="layui-input">
            </div>
        </div>
    </form>
</form>
</html>
