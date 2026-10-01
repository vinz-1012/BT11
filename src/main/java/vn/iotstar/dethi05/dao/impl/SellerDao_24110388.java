package vn.iotstar.dethi05.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import vn.iotstar.dethi05.config.JpaConfig_24110388;
import vn.iotstar.dethi05.dao.ISellerDao_24110388;
import vn.iotstar.dethi05.entity.Seller_24110388;

import java.util.List;

public class SellerDao_24110388 implements ISellerDao_24110388 {

    @Override
    public List<Seller_24110388> findAll() {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            TypedQuery<Seller_24110388> query = em.createQuery(
                    "SELECT s FROM Seller_24110388 s", Seller_24110388.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Seller_24110388 findById(int id) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            return em.find(Seller_24110388.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Seller_24110388> findAllWithProducts() {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            TypedQuery<Seller_24110388> query = em.createQuery(
                    "SELECT DISTINCT s FROM Seller_24110388 s LEFT JOIN FETCH s.products p LEFT JOIN FETCH p.category c ORDER BY s.sellerId ASC",
                    Seller_24110388.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Seller_24110388 seller) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        jakarta.persistence.EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(seller);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }
}
