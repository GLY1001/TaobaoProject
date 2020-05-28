package dbtaobao;

import java.nio.charset.Charset;
import java.util.Properties;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;

import com.csvreader.CsvReader;

public class Produce extends Thread {
	
	
	KafkaProducer<byte[], byte[]> producer = null;
    @Override
    public void run() {
		// 配置信息
		Properties props = new Properties();

		props.put("bootstrap.servers", "localhost:9092");

		// KV的序列化类
		props.put("key.serializer", "org.apache.kafka.common.serialization.ByteArraySerializer");
		props.put("value.serializer", "org.apache.kafka.common.serialization.ByteArraySerializer");

		producer = new KafkaProducer<byte[], byte[]>(props);
		// 定义一个CSV路径
		String csvFilePath = "/home/hadoop/eclipse-workspace/KafkaConsume/data/user_log.csv";
		// 创建CSV读对象 例如:CsvReader(文件路径，分隔符，编码格式);
		CsvReader reader;
		try {
			reader = new CsvReader(csvFilePath, ',', Charset.forName("UTF-8"));
			// 跳过表头 如果需要表头的话，这句可以忽略
			reader.readHeaders();
			// 逐行读入除表头的数据
			while (reader.readRecord()) {
				String line[] = reader.getRawRecord().split(",");

				// 取得第row行第0列的数据
				String cell = line[9];
				if (!cell.equals("2")) {
					Thread.sleep(100);
					producer.send(new ProducerRecord<byte[], byte[]>("sex", cell.getBytes()));
				}
			}
			reader.close();
			producer.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
    public void close() {
        try {
            producer.close();
        	System.out.println("发送者produce停用");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
