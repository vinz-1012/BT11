package vn.iotstar.dethi05.dao;

import vn.iotstar.dethi05.entity.Product_24110388;
import java.util.List;

public interface IProductDao_24110388 {
    List<Product_24110388> findAll();
    Product_24110388 findById(int id);
    List<Product_24110388> findBySellerId(int sellerId);
    void insert(Product_24110388 product);
    void update(Product_24110388 product);
    void delete(int id) throws Exception;
    int count();
    List<Product_24110388> findPaginated(int page, int pageSize);
}
