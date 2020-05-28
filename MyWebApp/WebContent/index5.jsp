<%@ page language="java" import="dbtaobao.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>男女购买量实时数据分析展示</title>
<link href="./css/style.css" type='text/css' rel="stylesheet"/>
<script src="./js/echarts.min.js"></script>

<script>
        var myChart;
        window.onload = function () {
             myChart = echarts.init(document.getElementById('main'));
             SetOptions();
             ws();
        }
        function ws() {
            var socket;
            if (!window.WebSocket) {
                window.WebSocket = window.MozWebSocket;
            }
            if (window.WebSocket) {
                socket = new WebSocket("ws://localhost:8080/MyWebApp/wbSocket");
                socket.onmessage = function (event) {
                    var data = event.data.split(',');
                    var girl = document.getElementById("girl");
                    girl.innerHTML=data[0]+"           ";
                    var boy = document.getElementById("boy");
                    boy.innerHTML=data[1];

                    var option1 = myChart.getOption();

                    option1.xAxis[0].data.shift();
                    option1.xAxis[0].data.push((new Date()).toLocaleTimeString().replace(/^\D*/,''));
                    
                    option1.series[0].data.shift();
                    console.log("111"+option1.series[0].data);
                    option1.series[0].data.push(data[0]);
                    console.log("222"+option1.series[0].data);
                    
                    
                    
                    option1.series[1].data.shift();   
                    option1.series[1].data.push(data[1]);

                    myChart.setOption(option1);
                    
                };
                socket.onopen = function (event) {
                    console.info("连接开启");

                };
                socket.onclose = function (event) {
                    console.info("连接被关闭");

                };
            } else {
                alert("你的浏览器不支持 WebSocket！");
            };
        }
        function SetOptions(data1,data2)
        {
        	option = {
        	        tooltip : {
        	            trigger: 'axis'
        	        },
        	        grid: {
        	            left: 30,
        	            right:20,
        	            top:30,
        	            bottom:30
        	        },
        	        legend: {
        	           /* y: 'bottom',*/
        	           x:"right",
        	            data:['Girl','Boy'],
        	            textStyle:{    //图例文字的样式
        	                color:'#194296',
        	                fontSize:12
        	            }
        	        },
        	        calculable : true,
        	        xAxis : [
        	            {
        	                type : 'category',
        	                axisLabel: {
        	                    color: "#194296"  //刻度线标签颜色
        	                },
        	                boundaryGap : false,
        	                data : (function () {
        	                    // generate an array of random data
        	                    var data = [],
        	                        time = (new Date()).getTime(),
        	                        i;

        	                    for (i = -9; i <= 0; i += 1) {
        	                        data.push(
        	                        		(new Date()).toLocaleTimeString().replace(/^\D*/,'')
        	                        );
        	                    }
        	                    return data;
        	                }())
        	            }
        	        ],
        	        yAxis : [
        	            {
        	                type : 'value',
        	                splitLine:false,
        	                axisLabel: {
        	                    color: "#194296"  //刻度线标签颜色
        	                },

        	            }
        	        ],
        	        series : [
        	            {
        	                name:'Girl',
        	                type:'line',
        	                color:'#d5d073',
        	                smooth:true,//设置折线图平滑
        	                data:[1,2,3,4,5,6,7,8,9,10],
        	            },
        	            {
        	                name:'Boy',
        	                type:'line',
        	                smooth:true,//设置折线图平滑
        	                data:[10,9,8,7,10,5,4,3,2,1],
        	            }
        	        ]
        	    };
            myChart.setOption(option);
        }
    </script>
    
</head>
<body>
<div>
    <b>Girl: </b><b id="girl"></b>
    <b>Boy: </b><b id="boy"></b>
</div>
<div id="main" style="width: 800px;height:400px;"></div>
</body>
</html>