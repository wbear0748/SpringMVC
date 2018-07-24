package spring.mvc.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.mvc.mybatis.UserMapper;

@Service
public class UserServiceImpl implements UserService {
   
    @Autowired
    private UserMapper userMapper;
       
    public int insert(User user) {
        return userMapper.insert(user);
    }
    
    public User login(String userid, String pwd) {
        return userMapper.login(userid, pwd);
    }
    
    public int modify(User user) {
        return userMapper.modify(user);
    }
 
    public void changePwd(User user) {
        userMapper.changePwd(user);
       
    }
 
    public void byeMember(User user) {
        userMapper.byeMember(user);
       
    }
    
    public int checkId(String userid) {
        return userMapper.checkId(userid);
    }
    
    public int checkNickname(String nickname) {
        return userMapper.checkNickname(nickname);
    }
}
