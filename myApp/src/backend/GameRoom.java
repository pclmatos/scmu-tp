package backend;

import java.util.List;

import javax.websocket.Endpoint;
import javax.websocket.EndpointConfig;
import javax.websocket.MessageHandler;
import javax.websocket.Session;
import javax.websocket.server.*;

public class GameRoom extends Endpoint{
    
    private List<Account> players;

    @Override
    public void onOpen(Session session, EndpointConfig conf) {
        ServerEndpointConfig.Builder.create(GameRoom.class, "/room");
        session.addMessageHandler(new MessageHandler.Whole<String>() {

            @Override
            public void onMessage(String arg0) {
                // TODO Auto-generated method stub
                throw new UnsupportedOperationException("Unimplemented method 'onMessage'");
            }
            
        });
    }

}
