package vn.iotstar.dethi05.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.dethi05.config.JpaConfig_24110388;
import vn.iotstar.dethi05.dao.ICategoryDao_24110388;
import vn.iotstar.dethi05.entity.Category_24110388;

import java.util.List;

public class CategoryDao_24110388 implements ICategoryDao_24110388 {

    @Override
    public List<Category_24110388> findAll() {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            TypedQuery<Category_24110388> query = em.createQuery(
                    "SELECT c FROM Category_24110388 c ORDER BY c.categoryId DESC", Category_24110388.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Category_24110388 findById(int id) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            return em.find(Category_24110388.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(Category_24110388 category) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(category);
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
    public void update(Category_24110388 category) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(category);
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
            Category_24110388 category = em.find(Category_24110388.class, id);
            if (category != null) {
                em.remove(category);
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
                    "SELECT COUNT(c) FROM Category_24110388 c", Long.class);
            return query.getSingleResult().intValue();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Category_24110388> findPaginated(int page, int pageSize) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            TypedQuery<Category_24110388> query = em.createQuery(
                    "SELECT c FROM Category_24110388 c ORDER BY c.categoryId DESC", Category_24110388.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
