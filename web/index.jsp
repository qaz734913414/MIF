<%--
  Created by IntelliJ IDEA.
  User: sirius
  Date: 16-7-26
  Time: 下午5:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-cn">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>泸州市医保基金预测可视化平台</title>
  <link href="css/bootstrap.min.css" rel='stylesheet' type='text/css'/>
  <link href="css/bootstrap.css" rel='stylesheet' type='text/css'/>
  <link href="css/common.css" rel="stylesheet"/>
  <link href="css/spider.css" rel="stylesheet"/>

  <script type="text/javascript" src="js/jquery-3.1.0.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <script type="text/javascript" src="js/common.js"></script>
  <script type="text/javascript" src="js/sub-menu.js"></script>


  <!--自动刷新页面，3分钟一刷新-->
  <!--<meta http-equiv="refresh" content="100">-->

</head>
<body>
<div class="header_bg">
  <div class="logo">
    <span class="font-style">泸州市医保基金预测平台</span>
  </div>
  <div class="menu">
    <nav>
      <ul class="top_list list-unstyled">
        <li><a href="">收支预测</a></li>

      </ul>
    </nav>
  </div>
</div>

<div  id="content">

  </br></br></br>

  <!--切换标签页面-->


  <div id="manager">
    <div id="source_table_content" style="">
      <div class="wrap" >
        <form id="queryPredict">
          <span style="font-size:50px" >选择模型：</span>
          <select id="select_model" class="form-control select_style" ></select>
          <span style="font-size:50px">选择变量：</span>
          <select id="select_variable" class="form-control select_style" style="width:200px;margin-left: 100px"></select>
          <input id="query" class="btn" type="button" value="查询" style="font-size: 30px; margin-left: 100px;margin-top:20px "/>
        </form>
      </div>



      <script src="js/echarts.common.min.js"></script>
      <script type="text/javascript">
        $(document).ready(function(){
          $.ajax({
            url:'/MIF/init',
            type:'get',
            dataType:'json',
            success:function(data){
              var model_select=$("#select_model");
              $.each(data.modelList,function(i,item){
                model_select.append("<option style='font-size: 20px' value='"+item.key+"'>"+item.value+"</option>");
              });
              var model_select=$("#select_variable");
              $.each(data.variableList,function(i,item){
                model_select.append("<option value='"+item.key+"'>"+item.value+"</option>");
              });
            }
          });
          $("#query").click(function(){
            var model_selected=$("#select_model").val();
            var variable_selected=$("#select_variable").val();
            var params="&model="+model_selected+"&variable="+variable_selected;
            $.ajax({
              url:'/MIF/query',
              type:'get',
              data:params,
              dataType:'json',
              success:function(data){
                $(data).each(function(i,value){
                  plot(value);
                });
              }
            });
          });
        });
      </script>
    </div>
  </div>

  <!--右部显示详细信息-->
  <div id="well">
    <div id="detail-information">
    </div>
  </div>
</div>
<div class="footer1_bg">
  <div class="copy">
    <p class="link">Copyright &copy; 华东师范大学.<a target="_blank" href="http://www.ecnu.edu.cn/"></a></p>
  </div>
</div>

<script type="text/javascript" src="js/spider.js"></script>
<script type="text/javascript" src="js/plot_forecast.js"></script>



</body>
</html>
