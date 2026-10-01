package vn.iotstar.dethi05.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.dethi05.config.JpaConfig_24110388;
import vn.iotstar.dethi05.dao.IUserDao_24110388;
import vn.iotstar.dethi05.entity.Users_24110388;

import java.util.List;

public class UserDao_24110388 implements IUserDao_24110388 {

    @Override
    public Users_24110388 findByUsername(String username) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            TypedQuery<Users_24110388> query = em.createQuery(
                    "SELECT u FROM Users_24110388 u WHERE u.username = :username", Users_24110388.class);
            query.setParameter("username", username);
            List<Users_24110388> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    @Override
    public Users_24110388 findByEmail(String email) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            TypedQuery<Users_24110388> query = em.createQuery(
                    "SELECT u FROM Users_24110388 u WHERE u.email = :email", Users_24110388.class);
            query.setParameter("email", email);
            List<Users_24110388> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    @Override
    public Users_24110388 findById(int id) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            return em.find(Users_24110388.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public boolean checkExistUsername(String username) {
        return findByUsername(username) != null;
    }

    @Override
    public boolean checkExistEmail(String email) {
        return findByEmail(email) != null;
    }

    @Override
    public void insert(Users_24110388 user) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(user);
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
    public void update(Users_24110388 user) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(user);
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
    public Users_24110388 login(String username, String password) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            TypedQuery<Users_24110388> query = em.createQuery(
                    "SELECT u FROM Users_24110388 u WHERE u.username = :username AND u.password = :password",
                    Users_24110388.class);
            query.setParameter("username", username);
            query.setParameter("password", password);
            List<Users_24110388> list = query.getResultList();
            if (!list.isEmpty()) {
                Users_24110388 u = list.get(0);

                if (u.getStatus() != null && u.getStatus() == 1) {
                    return u;
                }
            }
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean verifyOtp(String email, String otpCode) {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            TypedQuery<Users_24110388> query = em.createQuery(
                    "SELECT u FROM Users_24110388 u WHERE u.email = :email AND u.code = :code",
                    Users_24110388.class);
            query.setParameter("email", email);
            query.setParameter("code", otpCode);
            List<Users_24110388> list = query.getResultList();
            if (!list.isEmpty()) {
                Users_24110388 user = list.get(0);
                trans.begin();
                user.setStatus(1);
                em.merge(user);
                trans.commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Users_24110388> findAll() {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        try {
            TypedQuery<Users_24110388> query = em.createQuery("SELECT u FROM Users_24110388 u", Users_24110388.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
