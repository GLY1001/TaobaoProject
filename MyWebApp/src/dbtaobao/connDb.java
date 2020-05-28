package dbtaobao;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
 
public class connDb {
    private static Connection con = null;
    private static Statement stmt = null;
    private static ResultSet rs = null;
 
    //连接数据库方法
    public static void startConn(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            //连接数据库中间件
            try{
                con = DriverManager.getConnection("jdbc:MySQL://localhost:3306/dbtaobao","root","123456");
            }catch(SQLException e){
                e.printStackTrace();
            }
        }catch(ClassNotFoundException e){
            e.printStackTrace();
        }
    }
 
    //关闭连接数据库方法
    public static void endConn() throws SQLException{
        if(con != null){
            con.close();
            con = null;
        }
        if(rs != null){
            rs.close();
            rs = null;
        }
        if(stmt != null){
            stmt.close();
            stmt = null;
        }
    }
    //数据库双11 所有买家消费行为比例
    public static ArrayList index() throws SQLException{
        ArrayList<String[]> list = new ArrayList();
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("select action,count(*) num from user_log group by action desc");
        while(rs.next()){
            String[] temp={rs.getString("action"),rs.getString("num")};
            list.add(temp);
        }
            endConn();
        return list;
    }
    //男女买家交易对比
        public static ArrayList index_1() throws SQLException{
            ArrayList<String[]> list = new ArrayList();
            startConn();
            stmt = con.createStatement();
            rs = stmt.executeQuery("select gender,count(*) num from user_log group by gender desc");
            while(rs.next()){
                String[] temp={rs.getString("gender"),rs.getString("num")};
                list.add(temp);
            }
            endConn();
            return list;
        }
        //男女买家各个年龄段交易对比
        public static ArrayList index_2() throws SQLException{
            ArrayList<String[]> list = new ArrayList();
            startConn();
            stmt = con.createStatement();
            rs = stmt.executeQuery("select gender,age_range,count(*) num from user_log group by gender,age_range desc");
            while(rs.next()){
                String[] temp={rs.getString("gender"),rs.getString("age_range"),rs.getString("num")};
                list.add(temp);
            }
            endConn();
//            System.out.println(list.toString());            
//            Iterator it = list.iterator();
//            while(it.hasNext()){
//                System.out.println(it.next());
//            }
//            Iterator it = list.iterator();
//            while(it.hasNext()){
//                System.out.println(Arrays.toString((Object[]) it.next()));
//            }
            return list;
        }
        //获取销量前五的商品类别
        public static ArrayList index_3() throws SQLException{
            ArrayList<String[]> list = new ArrayList();
            startConn();
            stmt = con.createStatement();
            rs = stmt.executeQuery("select cat_id,count(*) num from user_log group by cat_id order by count(*) desc limit 5");
            while(rs.next()){
                String[] temp={rs.getString("cat_id"),rs.getString("num")};
                list.add(temp);
            }
            endConn();
            return list;
        }
    //各个省份的的总成交量对比
    public static ArrayList index_4() throws SQLException{
        
        startConn();
        stmt = con.createStatement();
        rs = stmt.executeQuery("select province,count(*) num from user_log where action=2 group by province order by count(*) desc");
        String[] country= {"贵州","北京","天津","上海","重庆","河北","河南","云南","辽宁","黑龙江","湖南","安徽","山东","新疆","江苏","浙江","江西","湖北","广西","甘肃","山西","内蒙古","陕西","吉林","福建","广东","青海","西藏","四川","宁夏","海南","台湾","香港","澳门"};
        HashMap<String, String> hmap= new HashMap<String, String>();
        ArrayList list = new ArrayList();
        ArrayList list1 = new ArrayList();
        while(rs.next()){
        	String province = rs.getString("province");
        	String num = rs.getString("num"); 
        	if(province.endsWith("市")) {
        		province=province.substring(0, province.length()-1);
        	}
        	if(Arrays.asList(country).contains(province)==true) {
                list.add("{name:'"+province+"',value:'"+num+"\'}");
                list1.add("{name:'"+province+"',value:'"+num+"\'}");
        	}
        }
        Iterator it = list.iterator();
        while(it.hasNext()){
            System.out.println("list:  "+it.next());
        };
        System.out.println(list1.toString());
        endConn();
        return list;
    }
}
