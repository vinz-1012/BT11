package vn.iotstar.dethi05;

import jakarta.persistence.EntityManager;
import org.junit.jupiter.api.Test;
import vn.iotstar.dethi05.config.JpaConfig_24110388;
import vn.iotstar.dethi05.dao.ISellerDao_24110388;
import vn.iotstar.dethi05.dao.impl.SellerDao_24110388;
import vn.iotstar.dethi05.entity.Seller_24110388;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertNotNull;

public class JpaTest_24110388 {

    @Test
    public void testConnectionAndSellerQuery() {
        EntityManager em = JpaConfig_24110388.getEntityManager();
        assertNotNull(em, "EntityManager must not be null");
        System.out.println(">> EntityManager connected successfully: " + em.isOpen());
        em.close();

        ISellerDao_24110388 sellerDao = new SellerDao_24110388();
        List<Seller_24110388> sellers = sellerDao.findAllWithProducts();
        System.out.println(">> Found sellers count: " + sellers.size());
        for (Seller_24110388 s : sellers) {
            System.out.println("  Seller: " + s.getSellerId() + " - " + s.getSellername() + " | Products: " + (s.getProducts() != null ? s.getProducts().size() : 0));
        }
    }
}
