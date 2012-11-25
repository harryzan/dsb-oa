package gov.dsb.core.dao;

import gov.dsb.core.dao.base.EntityService;
import gov.dsb.core.domain.Gh;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * Created with IntelliJ IDEA.
 * User: harryzan
 * Date: 9/16/12
 * Time: 10:42 AM
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class GhDao extends EntityService<Gh, Long> {

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        initDao(sessionFactory, Gh.class);
    }
}