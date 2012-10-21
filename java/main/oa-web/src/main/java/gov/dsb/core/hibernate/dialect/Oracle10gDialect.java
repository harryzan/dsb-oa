package gov.dsb.core.hibernate.dialect;

import org.hibernate.Hibernate;

import java.sql.Types;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-10-16
 * Time: 上午10:01
 * To change this template use File | Settings | File Templates.
 */
public class Oracle10gDialect extends  org.hibernate.dialect.Oracle10gDialect {

    public Oracle10gDialect() {
        super();

        registerHibernateType(Types.CHAR, Hibernate.STRING.getName());
    }
}
