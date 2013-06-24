import java.util.Date;

import org.hibernate.Session;
import org.junit.Test;

import com.h.domain.Event;
import com.h.util.HibernateUtil;



public class Test1 {
	@Test
	public void t1(){
		System.out.println("1");
		createAndStoreEvent("My Event", new Date());
		HibernateUtil.getSessionFactory().close();
	}
	
	
	
    private static void createAndStoreEvent(String title, Date theDate) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Event theEvent = new Event();
        theEvent.setTitle(title);
        theEvent.setDate(theDate);
        session.save(theEvent);

        session.getTransaction().commit();
    }
}
