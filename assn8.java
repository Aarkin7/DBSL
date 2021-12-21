package code;

import java.util.*;
import java.sql.*; //connectivity 
public class JavaA8
{
	public static void main(String[] args)throws Exception
	{
		int choice;
		int id;
		String name,address;
				
		
		String url="jdbc:mysql://localhost/javaA8"; //jdbc is API, mysql is DB, javaA8 - DB name

		String username="root";  //default username for mysql DB
		String password="1234";  //given by user 
		
		Class.forName("com.mysql.jdbc.Driver");  //This is the driver class for mysql DB
		
		Connection conn=DriverManager.getConnection(url,username,password);  
		//A connection (session) with a specificdatabase. SQL statements are executed and results are returnedwithin the context of a connection. 
        //A Connection object's database is able to provide informationdescribing its tables, its supported SQL grammar, its storedprocedures, the capabilities of this connection, and so on. Thisinformation is obtained with the getMetaData method

		
		
		Statement st=conn.createStatement(); //The object used for executing a static SQL statementand returning the results it produces. 
		
		Scanner sc=new Scanner(System.in);  //For taking input
		//A simple text scanner which can parse primitive types and strings usingregular expressions
		
		while(true)
		{
			System.out.println("\n1.Create table\n2.Insert data\n3.View data\n4.Delete Data\n5.Update\n6.Exit");
			System.out.print("Enter the choice:");
			choice=sc.nextInt();
			switch(choice)
			{
			case 1: 
				
			st.executeUpdate("create table Students(id int primary key,name varchar(30),address varchar(30));");
				break;
			case 2:
			    System.out.println("Enter data to add in database");
				System.out.print("Enter id: ");
				id=sc.nextInt();
				sc.nextLine();
				System.out.println("Enter the name: ");
				name=sc.nextLine();
				System.out.println("Enter address: ");
				address=sc.nextLine();
				
				st.executeUpdate("insert into Students(id,name,address) values("+id+",'"+name+"','"+address+"')");
				//Executes the given SQL statement, which may be an INSERT, UPDATE, or DELETE statement or 
				//anSQL statement that returns nothing, such as an SQL DDL statement
				
				st=conn.createStatement();
				System.out.println("Data added Successfully!!!");
				break;
			case 3:
				System.out.println("id\t\tName\t\tAddress");
				ResultSet rs=st.executeQuery("select * from Students");
				while(rs.next())
				{
					id=rs.getInt("id");
					name=rs.getString("name");
					address=rs.getString("address");
					System.out.println(id+"\t\t"+name+"\t\t"+address);
				}
				break;
			case 4:
               System.out.println("Enter the id which you want to delete");
			   id=sc.nextInt();
			   st.executeUpdate("delete from Students where id="+id);
			   System.out.println("Data deleted successfully!!!");
			   break;
			case 5: 
			  System.out.println("Enter id whose data do you want to update: ");
			  id=sc.nextInt();
			  sc.nextLine();
			  System.out.println("Enter name: ");
			  name=sc.nextLine();
			  System.out.println("Enter address: ");
			  address=sc.nextLine();
			  st.executeUpdate("update Students set name='"+name+"', address='"+address+"' where id="+id+";");
			  System.out.println("Data updated successfully!");
			  break;
			case 6:
				st.close();
				conn.close();
				System.exit(0);
			}
		}
	}
}
