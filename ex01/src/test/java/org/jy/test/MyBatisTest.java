package org.jy.test;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations ={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class MyBatisTest extends DataSourceTest {

	@Autowired
	private SqlSessionFactory session;
	
	@Test
	public void Test(){
		
		System.out.println("----------이게 세션"+session);
		
	}
	
	@Test
	public void secondTest(){
		
		SqlSession ses = session.openSession();
		
		System.out.println("------------이거: "+ses);
		
		ses.close();
		
		
	}
	
	
}
