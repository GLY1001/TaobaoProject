<%@ page language="java" import="dbtaobao.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ArrayList<String[]> list = connDb.index_2();
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>淘宝双11大数据分析</title>
<link href="./css/style.css" type='text/css' rel="stylesheet"/>
<script src="./js/echarts.min.js"></script>
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
                <li class="current"><a href="#">男女买家各个年龄段交易对比</a></li>
                <li><a href="./index3.jsp">商品类别交易额对比</a></li>
                <li><a href="./index4.jsp">各省份的总成交量对比</a></li>
            </ul>
        </div>
        <div class="container">
            <div class="title">男女买家各个年龄段交易对比</div>
            <div class="show">
                <div class='chart-type'>散点图</div>
                <div id="main"></div>
            </div>
        </div>
    </div>
<script>
//基于准备好的dom，初始化echarts实例
var myChart = echarts.init(document.getElementById('main'));
// 指定图表的配置项和数据
var data = [];
data[0] = [];
data[1] = [];

<%
	for(String[] a:list){
		if(a[0].equals("0")){
			%>
			data[0].push([<%=a[1]%>,<%=a[2]%>,<%=a[0]%>]);
			console.log("1111data[0]:  "+data[0].toString());
			<%
		}else if(a[0].equals("1")){
			%>
			data[1].push([<%=a[1]%>,<%=a[2]%>,<%=a[0]%>]);
			console.log("2222data[1]:  "+data[0].toString());
			<%
		}
	}
%>
console.log("data:  "+data.toString());
console.log("data[0]:  "+data[0].toString());
console.log("data[1]:  "+data[1].toString());

option = {
        tooltip: {//图例的tooltip 配置，默认不显示,可以在文件较多的时候开启tooltip对文字进行剪切
            show: true,
	        padding: 10,
	        backgroundColor: '#222',
	        borderColor: '#777',
	        borderWidth: 1,
	        formatter: function (param) {
	        	if(param.data[2]==0){
	        		var sex="女"
	        	}else{
	        		var sex="男"
	        	}	        	
	        	if(param.data[0]==0){
	        		var age_range="未知"
	        	}else if(param.data[0]==1){
	        		var age_range="<18"
	        	}else if(param.data[0]==2){
	        		var age_range="[18,24]"
	        	}else if(param.data[0]==3){
	        		var age_range="[25,29]"
	        	}else if(param.data[0]==4){
	        		var age_range="[30,34]"
	        	}else if(param.data[0]==5){
	        		var age_range="[35,39]"
	        	}else if(param.data[0]==6){
	        		var age_range="[40,49]"
	        	}else if(param.data[0]==7){
	        		var age_range=">=50"
	        	}
	        	
	        	
	            return '<div style="border-bottom: 1px solid rgba(255,255,255,.3); font-size: 18px;padding-bottom: 7px;margin-bottom: 7px">买家交易记录'
	            
	                + '</div>'
	                + '性别：' + sex + '<br>'
	                + '年龄段：' + age_range + '<br>'
	                + '交易数：' + param.data[1] + '<br>'
	        }
        },
	    backgroundColor: new echarts.graphic.RadialGradient(0.3, 0.3, 0.8, [{
	        offset: 0,
	        color: '#f7f8fa'
	    }, {
	        offset: 1,
	        color: '#cdd0d5'
	    }]),
	    title: {
	        text: '男女买家各个年龄段交易对比'
	    },
	    legend: {
	        right: 10,
	        data: ['women', 'men']
	    },
	    xAxis: {
	        splitLine: {
	            lineStyle: {
	                type: 'dashed'
	            }
	        }
	    },
	    yAxis: {
	        splitLine: {
	            lineStyle: {
	                type: 'dashed'
	            }
	        },
	        scale: true
	    },
	    series: [{
	        name: 'women',
	        data: data[0],
	        type: 'scatter',


	        itemStyle: {
	            normal: {
	                shadowBlur: 10,
	                shadowColor: 'rgba(120, 36, 50, 0.5)',
	                shadowOffsetY: 5,
	                color: new echarts.graphic.RadialGradient(0.4, 0.3, 1, [{
	                    offset: 0,
	                    color: 'rgb(251, 118, 123)'
	                }, {
	                    offset: 1,
	                    color: 'rgb(204, 46, 72)'
	                }])
	            }
	        }
	    }, {
	        name: 'men',
	        data: data[1],
	        type: 'scatter',


	        itemStyle: {
	            normal: {
	                shadowBlur: 10,
	                shadowColor: 'rgba(25, 100, 150, 0.5)',
	                shadowOffsetY: 5,
	                color: new echarts.graphic.RadialGradient(0.4, 0.3, 1, [{
	                    offset: 0,
	                    color: 'rgb(129, 227, 238)'
	                }, {
	                    offset: 1,
	                    color: 'rgb(25, 183, 207)'
	                }])
	            }
	        },
	    }]
	};

// 使用刚指定的配置项和数据显示图表。
myChart.setOption(option);
</script>
</body>
</html>