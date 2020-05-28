<%@ page language="java" import="dbtaobao.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ArrayList list = connDb.index_4();
%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>淘宝双11大数据分析</title>
<link href="./css/style.css" type='text/css' rel="stylesheet"/>
<script src="./js/echarts.min.js"></script>
<script type="text/javascript" src="./js/china.js" ></script>

</head>
<body>
	<div class='header'>
        <p>淘宝双11大数据分析</p>
    </div>
    <div class="content">
        <div class="nav">
            <ul>
                <li><a href="./index.jsp">所有买家各消费行为对比</a></li>
                <li><a href="./index1.jsp">男女买家交易对比</a></li>
                <li><a href="./index2.jsp">男女买家各个年龄段交易对比</a></li>
                <li><a href="./index3.jsp">商品类别交易额对比</a></li>
                <li class="current"><a href="#">各省份的总成交量对比</a></li>
            </ul>
        </div>
        <div class="container">
            <div class="title">各省份的总成交量对比</div>
            <div class="show">
                <div class='chart-type'>地图</div>
                <div id="main">
                </div>
            </div>
        </div>
    </div>
<script>
//基于准备好的dom，初始化echarts实例
var myChart = echarts.init(document.getElementById('main'));
var idata = <%=list%>;
// 指定图表的配置项和数据
var optionMap = {  
        backgroundColor: '#FFFFFF',  
        title: {  
            text: '全国各省总成交量',  
            subtext: '',  
            x:'center'  
        },  
        tooltip : {  
            trigger: 'item'  
        },  
        
        //左侧小导航图标
        visualMap: {  
            show : true,  
            x: 'left',  
            y: 'center',  
            splitList: [   
                {start: 50, end:60},{start: 40, end: 50},  
                {start: 30, end: 40},{start: 20, end: 30},  
                {start:10, end: 20},{start: 0, end: 10},  
            ],  
            color: ['#5475f5', '#9feaa5', '#85daef','#74e2ca', '#e6ac53', '#9fb5ea']  
        },  
        
        //配置属性
        series: [{  
            name: '成交量',  
            type: 'map',  
            mapType: 'china',   
            roam: true,  
            label: {  
                normal: {  
                    show: true  //省份名称  
                },  
                emphasis: {  
                    show: false  
                }  
            },
            data:idata,
    	}]  
    };

//使用制定的配置项和数据显示图表
myChart.setOption(optionMap);


</script>
</body>
</html>