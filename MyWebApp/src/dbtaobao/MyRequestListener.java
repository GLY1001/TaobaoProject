package dbtaobao;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class MyRequestListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
    	RunThread RunThread = new RunThread();
    	RunThread.RunThread();
    	System.out.println("ServletContex创建成功");
    }

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
    	ConsumerKafka ConsumerKafka = new ConsumerKafka();
    	ConsumerKafka.close();
        System.out.println("ServletContex销毁");
	}


}