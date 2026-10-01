package vn.iotstar.dethi05.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.dethi05.config.JpaConfig_24110388;
import vn.iotstar.dethi05.dao.IProductDao_24110388;
import vn.iotstar.dethi05.entity.Product_24110388;

import java.util.List;

public class ProductDao_24110388 implements IProductDao_24110388 {

    @Override
    public List<Product_24110388> findAll() {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            TypedQuery<Product_24110388> query = em.createQuery(
                    "SELECT p FROM Product_24110388 p LEFT JOIN FETCH p.category c LEFT JOIN FETCH p.seller s ORDER BY p.productId DESC",
                    Product_24110388.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Product_24110388 findById(int id) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            TypedQuery<Product_24110388> query = em.createQuery(
                    "SELECT p FROM Product_24110388 p LEFT JOIN FETCH p.category c LEFT JOIN FETCH p.seller s WHERE p.productId = :id",
                    Product_24110388.class);
            query.setParameter("id", id);
            List<Product_24110388> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product_24110388> findBySellerId(int sellerId) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            TypedQuery<Product_24110388> query = em.createQuery(
                    "SELECT p FROM Product_24110388 p LEFT JOIN FETCH p.category c LEFT JOIN FETCH p.seller s WHERE s.sellerId = :sellerId ORDER BY p.productId DESC",
                    Product_24110388.class);
            query.setParameter("sellerId", sellerId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(Product_24110388 product) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(product);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Product_24110388 product) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(product);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int id) throws Exception {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Product_24110388 product = em.find(Product_24110388.class, id);
            if (product != null) {
                em.remove(product);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public int count() {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(p) FROM Product_24110388 p", Long.class);
            return query.getSingleResult().intValue();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product_24110388> findPaginated(int page, int pageSize) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            TypedQuery<Product_24110388> query = em.createQuery(
                    "SELECT p FROM Product_24110388 p LEFT JOIN FETCH p.category c LEFT JOIN FETCH p.seller s ORDER BY p.productId DESC",
                    Product_24110388.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
