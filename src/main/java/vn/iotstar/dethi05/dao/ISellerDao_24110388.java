package vn.iotstar.dethi05.dao;

import vn.iotstar.dethi05.entity.Seller_24110388;
import java.util.List;

public interface ISellerDao_24110388 {
    List<Seller_24110388> findAll();
    Seller_24110388 findById(int id);
    List<Seller_24110388> findAllWithProducts();
    void update(Seller_24110388 seller);
}
