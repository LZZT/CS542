package dao;

import model.Transactions;
import model.Traveler;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import util.HibernateUtil;

import java.util.List;


public class TransactionDAO {



    public void saveTansaction(Transactions transactions){

        Session session = HibernateUtil.openSession();

        Transaction tx = session.beginTransaction();

        try{
            session.save(transactions);
            tx.commit();

        }catch (Exception ex){
            if(null != tx){
                tx.rollback();
            }
        }finally {
            HibernateUtil.close(session);
        }
    }


    public void deleteTransactionByTransID(String primaryKey){

        Session session = HibernateUtil.openSession();

        Transaction tx = session.beginTransaction();

        try{
            Transaction transaction = session.get(Transaction.class, primaryKey);
            session.delete(transaction);
            tx.commit();

        }catch (Exception ex){
            if(null != tx){
                tx.rollback();
            }

        }finally {
            HibernateUtil.close(session);
        }
    }

    public boolean deleteTransaction(String transactionID) {

        Session session = HibernateUtil.openSession();

        Transaction tx = session.beginTransaction();


        try {

            String hql = String.format("DELETE Transaction WHERE transactionID = '%s'", transactionID);
            Query query = session.createQuery(hql);
            int result = query.executeUpdate();
            tx.commit();

        } catch (Exception ex) {
            if (null != tx) {
                tx.rollback();
            }
        } finally {
            HibernateUtil.close(session);
        }

        return true;
    }

    public  List<Transactions> getTransactionByCustomer(String userName) {
        Session session = HibernateUtil.openSession();
        Transaction tx = session.beginTransaction();
        List<Transactions> transactionList=null;
        try {

            String hql = String.format(" FROM Transaction T WHERE T.username = '%s'", userName);
            Query query = session.createQuery(hql);
            transactionList =  query.list();
            tx.commit();

        } catch (Exception ex) {
            if (null != tx) {
                tx.rollback();
            }
        } finally {
            HibernateUtil.close(session);
        }

        return transactionList;
    }

}
