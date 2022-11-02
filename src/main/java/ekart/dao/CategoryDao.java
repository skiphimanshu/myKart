package ekart.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import ekart.entity.Category;

public class CategoryDao {
	private SessionFactory sessionFactory;

	public CategoryDao(SessionFactory sessionFactory) {
		super();
		this.sessionFactory = sessionFactory;
	}
	public int saveCategory(Category category)  {
		 
		Session session =this.sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		int catid = (Integer) session.save(category);
		tx.commit();
		session.close();
		return catid;
	}
	public List<Category> getAllCategory(){
		Session s = this.sessionFactory.openSession();
		Query qu = s.createQuery("from Category");
		List<Category> list = qu.list();
		return list;
		
	}
	public Category getCategoryById(int catId) {
		Category category = null;
		try {
			Session s = this.sessionFactory.openSession();
			category = s.get(Category.class, catId);
			s.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return category;
	}
	

}
