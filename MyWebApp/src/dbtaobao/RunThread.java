package dbtaobao;

/**
 * Created by youtNa on 2017/5/22.
 */
public class RunThread {
	public ConsumerKafka kafka;
	public Produce produce;
    public void RunThread(){
    	produce = new Produce();
    	produce.start();
        kafka = new ConsumerKafka();
        System.out.println("线程调用处");
        kafka.start();
    }
    public void stop() {
    	produce.close();
    	produce.interrupt();
    	kafka.close();
    	kafka.interrupt();
    	System.out.println("线程停用");
    }
}