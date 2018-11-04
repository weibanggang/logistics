<%--
  Created by IntelliJ IDEA.
  User: 小邦哥
  Date: 2018/10/29
  Time: 11:23
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
            姓 名:
            <div class="layui-inline" style="width:190px">
                <input class="layui-input" id="staffName" autocomplete="off">
            </div>
            <div class="layui-inline">
                <button class="layui-btn layui-btns layui-btn-normal" id="staffNamesele" data-type="getCheckData" >模糊查询</button>
            </div>
        </div>
        <div class="layui-inline">
            编 号:
            <div class="layui-inline" style="width:190px">
                <input class="layui-input" name="name" id="staffNo" autocomplete="off">
            </div>
            <div class="layui-inline">
                <button class="layui-btn layui-btns layui-btn-normal" id="staffNosele" data-type="getCheckData" >查询</button>
            </div>
        </div>
    </div>
</div>
<div class="rigbody">
    <table id="demo" lay-filter="demo"  ></table>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="detail">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script src="js/jquery.js"></script>
<script src="./plugins/layui/layui.js"></script>
<script>
    var table = null;
    layui.use(['table'], function () {
        table = layui.table;
        //监听工具条
        table.on('tool(demo)', function (obj) {
            var data = obj.data;
            if (obj.event === 'detail') {
                $("input[name=staffName]").val(data.staffName);
                $("input[name=birthhday]").val(data.birthhday);
                $("input[name=phone]").val(data.phone);
                $("input[name=password]").val(data.password);
                $('#departs').find('option').each(function(){
                    $(this).attr('selected',$(this).val()==data.dedpartNo);
                });
                $('#firms').find('option').each(function(){
                    $(this).attr('selected',$(this).val()==data.firmNo);
                });
                data.gender=="男"?$("#nan").attr("checked",true):$("#nv").attr("checked",true)
                form.render();
                update(data.staffNo);
            } else if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    del(data.staffNo);
                    layer.close(index);
                });
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
            , url: '/depart/'+url //数据接口
            , cellMinWidth: 120
            , cols: [[ //表头
                {type:'numbers',title: '序号'}
                , {field: 'staffNo', title: '编号', align: 'center'}
                , {field: 'staffName', title: '姓名', align: 'center'}
                , {field: 'gender', title: '性别', align: 'center'}
                , {field: 'birthhday', title: '出生日期', align: 'center'}
                , {field: 'phone', title: '手机号码', align: 'center'}
                , {title: '部门', align: 'center', templet: function (row) {
                        return row.dispatch.departName
                    }
                }
                , { title: '公司', align: 'center',templet:function (row) {  return row.firm.firmName }}
                , {field: 'right', title: '操作', width: '178', align: 'center', toolbar: '#barDemo'}
            ]]
            , id: "idsw"
        });
    }

    function  update(staffNo) {
        layer.open({
            type: 1
            , title: "编辑员工信息"
            , content: $("#bj")
            , area: ['800px', '400px']
            , btn: ['修改', '取消'] //只是为了演示
            , yes: function () {
                $.ajax({
                    type: "post"
                    , url: "/depart/update"
                    , dataType: 'json'
                    ,contentType : 'application/json;charset=utf-8'
                    ,data:JSON.stringify({
                        staffNo:staffNo
                        ,staffName:$("input[name=staffName]").val()
                        ,gender:$("#nan").attr("checked")==true?"男":"女"
                        , birthhday:$("input[name=birthhday]").val()
                        , phone:$("input[name=phone]").val()
                        , password:$("input[name=password]").val()
                        , dedpartNo:$("select[name=dedpartNo]").val()
                        , firmNo:$("select[firmNo=firmNo]").val()
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
    $("#staffNosele").click(function () {
        xrsj("ById/"+$("#staffNo").val());
    })
    $("#staffNamesele").click(function () {
        xrsj("ByName/"+$("#staffName").val());
    })
    //删除员工
    function del(license) {
        $.ajax({
            type: "post"
            , url: "/depart/del/" + license
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
        $("input[name=staffName]").val("");
        $("input[name=phone]").val("");
        $("input[name=password]").val("");
        $("#bj").attr("hidden", "hidden").css("display", "none");
    }
</script>
<script>
    //渲染下拉框
    $(function () {
        layui.use(['form', 'layedit', 'laydate'], function(){
             form = layui.form
                ,layer = layui.layer
                ,layedit = layui.layedit
                ,laydate = layui.laydate;

            //日期
            laydate.render({
                elem: '#date'
            });
            $.ajax({
                type:"get",
                url:"/dispatch/select",//请求路径
                dataType: 'json'
                ,success:function(data){//请求成功后的事件
                    $.each(data.data,function(index,obj){
                        var option=$("<option value='"+obj.departNo+"'>"+obj.departName+"</option>");
                        $("#departs").append(option);
                        form.render();
                    })
                }
            })
            $.ajax({
                type:"get",
                url:"/firm/select",//请求路径
                dataType: 'json',
                success:function(data){//请求成功后的事件
                    $.each(data.data,function(index,obj){
                        var option=$("<option value='"+obj.firmNo+"'>"+obj.firmName+"</option>");
                        $("#firms").append(option);
                        form.render();
                    })
                }
            })
        });
    })
</script>
</body>
<form class="layui-form" id="bj" hidden="hidden">
    <div class="layui-form-item">
        <label class="layui-form-label">员工姓名：</label>
        <div class="layui-input-inline" >
            <input type="text" name="staffName" value="${param.staffName}" maxlength="5" required lay-verify="required" placeholder="请输入员工姓名" autocomplete="off" class="layui-input">
        </div>
        <label class="layui-form-label">性   别：</label>
        <div class="layui-input-inline" >
            <input type="radio" name="gender" id="nan" value="男" title="男" checked="">
            <input type="radio" name="gender" id="nv"value="女" title="女">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">出生日期：</label>
        <div class="layui-input-inline">
            <input type="text" name="birthhday" placeholder="yyyy-MM-dd HH:mm:ss" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
        </div>
        <label class="layui-form-label">手机号码：</label>
        <div class="layui-input-inline">
            <input type="text" name="phone" value="${param.phone}" maxlength="11" required lay-verify="required" placeholder="请输入手机号码" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">部  门：</label>
        <div class="layui-input-inline">
            <select id="departs" name="dedpartNo">
            </select>
        </div>
        <label class="layui-form-label">公  司：</label>
        <div class="layui-input-inline">
            <select id="firms" name="firmNo">

            </select>

        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">密  码：</label>
        <div class="layui-input-inline">
            <input type="password" name="password" lay-verify="pass" placeholder="请输入密码" autocomplete="off" class="layui-input">
        </div>
        <div class="layui-form-mid layui-word-aux">请填写6到12位密码</div>
    </div>
</form>
</html>
