package dbtaobao;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import java.io.IOException;
import java.util.concurrent.CopyOnWriteArraySet;

/**
 * Created by youtNa on 2017/5/22.
 */
@ServerEndpoint("/wbSocket")
public class WebSocket {
    private Session session;
    public static CopyOnWriteArraySet<WebSocket> wbSockets = new CopyOnWriteArraySet<WebSocket>();

    @OnOpen
    public void onOpen(Session session){
        this.session = session;
        wbSockets.add(this);  	
    }

    @OnClose
    public void onClose(){
        wbSockets.remove(this);
        System.out.println("A session insert,sessionId is "+ session.getId());
    }

    @OnMessage
    public void onMessage(String message ,Session session){
        System.out.println(message + "from " + session.getId());
    }

	public Session getSession(){
		return this.session;
	}
    public void sendMessage(String message) throws IOException{
        this.session.getBasicRemote().sendText(message);
        System.out.println("session发送成功");
    }
}
