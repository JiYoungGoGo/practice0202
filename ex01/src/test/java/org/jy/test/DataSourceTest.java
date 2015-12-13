package org.jy.test;


import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/spring/**/*.xml")
public class DataSourceTest {

	@Autowired
	private DataSource ds;
	
	
	
	@Test
	public void test() throws Exception{
		
		System.out.println("----------이게 ds: "+ds.toString());
		
		Connection con = ds.getConnection();
		
		System.out.println("-----------이게 con: "+con);
		
		con.close();
	}
	
}
