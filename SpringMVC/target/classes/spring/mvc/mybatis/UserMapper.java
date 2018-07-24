package spring.mvc.mybatis;

import org.apache.ibatis.annotations.Param;

import spring.mvc.user.User;

public interface UserMapper {
	public int insert(User user);

	public User login(@Param("userid") String userid, @Param("pwd") String pwd);

	public int modify(User user);

	public void changePwd(User user);

	public void byeMember(User user);

	public int checkId(String userid);

	public int checkNickname(String nickname);
}