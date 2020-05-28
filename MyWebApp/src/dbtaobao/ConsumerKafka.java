package dbtaobao;

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;

import net.sf.json.JSONObject;

import java.io.IOException;
import java.util.Arrays;
import java.util.Properties;

import static dbtaobao.WebSocket.wbSockets;
/** 
 * Created by youtNa on 2017/5/22.
 */
public class ConsumerKafka extends Thread {

    public KafkaConsumer<String,String> consumer;
    public String topic = "result";

    public ConsumerKafka(){

    }

    @Override
    public void run(){

		Properties props = new Properties();
		props.put("bootstrap.servers", "localhost:9092");//kafka的地址
		props.put("group.id", "test-consumer-group");//组名 不同组名可以重复消费。例如你先使用了组名A消费了kafka的1000条数据，但是你还想再次进行消费这1000条数据，并且不想重新去产生，那么这里你只需要更改组名就可以重复消费了
		props.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
		props.put("value.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");//值序列化，默认org.apache.kafka.common.serialization.StringDeserializer
		props.put("enable.auto.commit", "false");//是否自动提交，默认为true
		System.out.println("线程打开");
		    
		consumer = new KafkaConsumer<String,String>(props);
		consumer.subscribe(Arrays.asList(this.topic));


		while(true){
			// 批量提交数量
			ConsumerRecords<String, String> records = consumer.poll(100);//订阅之后，我们再从kafka中拉取数据		
			for (ConsumerRecord<String, String> record : records){//一般来说进行消费会使用监听，这里我们就用for(;;)来进行监听

				for (WebSocket webSocket :wbSockets){  
					try {
						String value=record.value();
						if(value.equals("{}")) {
							value="{}";
						}else {
							value = record.value().replace("{", "").replace("}", "").replace("[","{").replace("]", "}");
						}
						System.out.println("value  "+value);
						JSONObject jsonobject = JSONObject.fromObject(value);
						System.out.println("object:  "+jsonobject.toString());
						String data="";

						for(int i=0;i<jsonobject.size();i++) {
							if(jsonobject.has("0")) {
									data = jsonobject.getString("0")+",";
							}else {
									data="0,";
							}
							if(jsonobject.has("1")) {
								data = data+jsonobject.getString("1");
							}else {
								data=data+"0";
							}
						}
						System.out.println(data);
//						System.out.println(jsonobject);
						webSocket.sendMessage(data);
//						System.out.println(value);
//						webSocket.sendMessage(value);

						//手动提交offset记录
						consumer.commitSync();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
		                continue;
					}
				}
			}
		}
	}

    public void close() {
        try {
            consumer.close();
        	System.out.println("接收者consume停用");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
