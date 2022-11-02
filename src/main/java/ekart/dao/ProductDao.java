package ekart.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import ekart.entity.Product;

public class ProductDao {
	private SessionFactory sessionFactory;
	
	public ProductDao(SessionFactory sessionFactory) {
		super();
		this.sessionFactory = sessionFactory;
	}
	public boolean saveProduct(Product product) {
		boolean f = false;
		
		try {
			Session s = this.sessionFactory.openSession();
			Transaction tx = s.beginTransaction();
			s.save(product);
			tx.commit();
			s.close();
			f = true;
			
			
		}catch(Exception e) {
			e.printStackTrace();
			f = false;
			
		}
		
		return f;
	}
	

}
