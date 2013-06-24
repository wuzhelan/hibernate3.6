import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.junit.Test;

import com.h.domain.Event;
import com.h.domain.Person;
import com.h.util.HibernateUtil;



public class Test1 {
	@Test
	public void t1(){
		createAndStoreEvent("My Event", new Date());
		
	}
	
	@Test
	public void t2(){
		List<Event> events = listEvents();
		for(Event e :events){
			System.out.println(e.getId());
		}
	}
	
	
	@Test
	public void t3(){
		  Session session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction();
	        Person p = new Person();
	        p.setAge(20);
	        p.setFirstname("a");
	        p.setLastname("b");
	        session.persist(p);
	        session.getTransaction().commit();
	        HibernateUtil.getSessionFactory().close();
	}
	
	@Test
	public void t4(){
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        Person aPerson = (Person) session.load(Person.class, 3L);
        Event anEvent = (Event) session.load(Event.class, 3L);
        aPerson.getEvents().add(anEvent);
        aPerson.setAge(10000);
        //session.persist(aPerson);
//        Hibernate: select person0_.PERSON_ID as PERSON1_1_0_, person0_.age as age1_0_, person0_.firstname as firstname1_0_, person0_.lastname as lastname1_0_ from PERSON person0_ where person0_.PERSON_ID=?
//        		Hibernate: select events0_.PERSON_ID as PERSON1_1_1_, events0_.EVENT_ID as EVENT2_1_, event1_.EVENT_ID as EVENT1_0_0_, event1_.EVENT_DATE as EVENT2_0_0_, event1_.title as title0_0_ from PERSON_EVENT events0_ inner join EVENTS event1_ on events0_.EVENT_ID=event1_.EVENT_ID where events0_.PERSON_ID=?
//        		Hibernate: insert into PERSON_EVENT (PERSON_ID, EVENT_ID) values (?, ?)
//自动脏检查（automatic dirty checking）
        session.getTransaction().commit();
	}
	
	
    private static void createAndStoreEvent(String title, Date theDate) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();

        Event theEvent = new Event();
        theEvent.setTitle(title);
        theEvent.setDate(theDate);
        session.save(theEvent);

        session.getTransaction().commit();
        HibernateUtil.getSessionFactory().close();
    }
    
    @SuppressWarnings("unchecked")
	public static List<Event> listEvents() {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List<Event> result = session.createQuery("from Event").list();
        session.getTransaction().commit();
        return result;
    }
}
