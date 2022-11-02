package ekart.entity;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Category {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int catId;
	private String cTitle;
	private String cDesc;
	@OneToMany(mappedBy = "category",fetch = FetchType.LAZY)
	private List<Product> product = new ArrayList<Product>();
	
	public Category() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Category(String cTitle, String cDesc, List<Product> product) {
		super();
		
		this.cTitle = cTitle;
		this.cDesc = cDesc;
		this.product = product;
	}
	public int getCatId() {
		return catId;
	}
	public void setCatId(int catId) {
		this.catId = catId;
	}
	public String getcTitle() {
		return cTitle;
	}
	public void setcTitle(String cTitle) {
		this.cTitle = cTitle;
	}
	public String getcDesc() {
		return cDesc;
	}
	public void setcDesc(String cDesc) {
		this.cDesc = cDesc;
	}
	public List<Product> getProduct() {
		return product;
	}
	public void setProduct(List<Product> product) {
		this.product = product;
	}
	@Override
	public String toString() {
		return "Category [catId=" + catId + ", cTitle=" + cTitle + ", cDesc=" + cDesc
				+ ", product=" + product + "]";
	}
	
}
