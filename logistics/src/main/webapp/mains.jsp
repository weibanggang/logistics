<%--
  Created by IntelliJ IDEA.
  User: 小邦哥
  Date: 2018/10/29
  Time: 21:39
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

        .rigbody1, .rigbody2 {
            width: 550px;
            height: 463px;
            line-height: 40px;
            margin-top: 5px;
            float: left;
            margin-left: 10px;
        }

        .buts {
            width: 550px;
            height: 40px;
            margin-left: 10px;
        }
    </style>
</head>
<body>

<div class="rigtop">
    <button class="layui-btn layui-btn-sm layui-btn-normal buts" id="addgs"><i class="layui-icon"></i>新增分公司</button>
    <button class="layui-btn layui-btn-sm layui-btn-normal buts" id="addbm"><i class="layui-icon"></i>新增部门</button>

</div>
<div class="rigbody">
    <div class="rigbody1">
        <table id="demo" lay-filter="demo"></table>
    </div>
    <div class="rigbody2">
        <table id="demo2" lay-filter="demo2"></table>
    </div>
</div>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
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
    //////用于渲染数据
    //部门信息表
    layui.use('table', function () {
        table2 = layui.table;
        table2.on('tool(demo2)', function (obj) {
            var data = obj.data;
            if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    del(data.departNo);
                    layer.close(index);
                });
            } else if (obj.event === 'edit') {
                $("#departName").val(data.departName);
                addfgs("update", data.departNo);
            }
        });
        table2.render({
            elem: '#demo2'
            , height: 451
            , page: true
            , toolbar: '#toolbarDemo1'
            , url: '/dispatch/json' //数据接口
            , cols: [[ //表头
                {type: 'numbers', title: '序号'}
                , {field: 'departNo', title: '编号', align: 'center'}
                , {field: 'departName', width: '280', title: '部门名称', align: 'center'}
                , {field: 'right', title: '操作', width: '165', align: 'center', toolbar: '#barDemo'}
            ]]
            , id: "tdispatch"
        });

    });

    //公司信息表
    layui.use('table', function () {
        var table = layui.table;
        //监听工具条
        table.on('tool(demo)', function (obj) {
            var data = obj.data;
            if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    delgs(data.firmNo);
                    layer.close(index);
                });
            } else if (obj.event === 'edit')
            {
                $("#firmName").val(data.firmName);
                addgs("update", data.firmNo);
            }
        });
        //进行渲染
        table.render({
            elem: '#demo'
            , height: 451
            , page: true
            , toolbar: '#toolbarDemo2'
            , url: '/firm/json' //数据接口
            , cols: [[ //表头
                {type: 'numbers', title: '序号'}
                , {field: 'firmNo', title: '编号', align: 'center'}
                , {field: 'firmName', width: '280', title: '公司名称', align: 'center'}
                , {field: 'right', title: '操作', width: '165', align: 'center', toolbar: '#barDemo'}

            ]]
            , id: "tfirm"
        });
    });
</script>

<script>
    //部门脚本
    $("#addbm").click(function () {
        addbm("add")
    })
    //添加和修改部门信息
    function addbm(addupda, did) {
        var title="添加部门信息";
        if(did!=null)
            title="修改部门信息";
        layer.open({
            type: 1
            , title: title
            , content: $("#bm")
            , area: ['340px', '160px']
            , btn: ['添加', '取消'] //只是为了演示
            , yes: function () {
                var url = addupda + "/" + $("#departName").val()
                if (did != null) {
                    url = url + "/" + did;
                }
                $.ajax({
                    type: "post"
                    , url: "/dispatch/" + url
                    , dataType: 'json'
                    , success: function (data) {
                        layer.msg(data.msg, {time: 1000});
                        if (data.code == 3) {
                            setTimeout(function () {
                                esc();
                                table2.reload('tdispatch');
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
    //删除部门
    function del(departNo) {
        $.ajax({
            type: "post"
            , url: "/dispatch/del/" + departNo
            , dataType: 'json'
            , success: function (data) {
                layer.msg(data.msg, {time: 1000});
                if (data.code == 3) {
                    table2.reload('tdispatch');
                }
            }
        });
    }
    //关闭回调事件
    function esc() {
        $("#departName").val("");
        $("#bm").attr("hidden", "hidden").css("display", "none");
        layer.closeAll();
    }
</script>

<script>
    //公司脚本
    $("#addgs").click(function () {
        addgs("add")
    })
    //添加和修改公司信息
    function addgs(addupda, did) {
        var title="添加公司信息";
        if(did!=null)
            title="修改公司信息";
        layer.open({
            type: 1
            , title: "添加公司信息"
            , content: $("#gs")
            , area: ['340px', '160px']
            , btn: ['添加', '取消'] //只是为了演示
            , yes: function () {
                var url = addupda + "/" + $("#firmName").val()
                if (did != null) {
                    url = url + "/" + did;
                }
                $.ajax({
                    type: "post"
                    , url: "/firm/" + url
                    , dataType: 'json'
                    , success: function (data) {
                        layer.msg(data.msg, {time: 1000});
                        if (data.code == 3) {
                            setTimeout(function () {
                                escgs();
                                table2.reload('tfirm');
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
    //删除公司
    function delgs(departNo) {
        $.ajax({
            type: "post"
            , url: "/firm/del/" + departNo
            , dataType: 'json'
            , success: function (data) {
                layer.msg(data.msg, {time: 1000});
                if (data.code == 3) {
                    table2.reload('tfirm');
                }
            }
        });
    }
    //关闭回调事件
    function escgs() {
        $("#firmName").val("");
        $("#gs").attr("hidden", "hidden").css("display", "none");
        layer.closeAll();
    }


</script>
</body>

<form id="bm" class="layui-form" hidden="hidden">
    <div class="layui-form-item">
        <label class="layui-form-label" style="font-size:15px">部门名称:</label>
        <div class="layui-input-inline">
            <input type="text" id="departName" maxlength="20" required lay-verify="required" placeholder="请输入部门名称"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
</form>
<form id="gs" class="layui-form" hidden="hidden">
    <div class="layui-form-item">
        <label class="layui-form-label" style="font-size:15px">公司名称:</label>
        <div class="layui-input-inline">
            <input type="text" id="firmName" maxlength="20" required lay-verify="required" placeholder="请输入分公司名称"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
</form>
</html>
