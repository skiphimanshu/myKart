package ekart.dao;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import ekart.entity.User;

public class UserDao {
	private SessionFactory factory;
	
	public UserDao(SessionFactory factory) {
		this.factory = factory;
	}
	public User getUserByEmailAndPassword(String email, String pass) {
		User user = null;
		String qu ="from User where userEmail =:e and userPassword =:p";
		Session session= this.factory.openSession();
		Query query = session.createQuery(qu);
		query.setParameter("e", email);
		query.setParameter("p",pass);
		user = (User)query.uniqueResult();
		session.close();
		return user;
	}

}
