package vn.iotstar.dethi05.service.impl;

import vn.iotstar.dethi05.dao.IProductDao_24110388;
import vn.iotstar.dethi05.dao.impl.ProductDao_24110388;
import vn.iotstar.dethi05.entity.Product_24110388;
import vn.iotstar.dethi05.service.IProductService_24110388;

import java.util.List;

public class ProductService_24110388 implements IProductService_24110388 {

    private final IProductDao_24110388 productDao = new ProductDao_24110388();

    @Override
    public List<Product_24110388> findAll() {
        return productDao.findAll();
    }

    @Override
    public Product_24110388 findById(int id) {
        return productDao.findById(id);
    }

    @Override
    public List<Product_24110388> findBySellerId(int sellerId) {
        return productDao.findBySellerId(sellerId);
    }

    @Override
    public void insert(Product_24110388 product) {
        productDao.insert(product);
    }

    @Override
    public void update(Product_24110388 product) {
        productDao.update(product);
    }

    @Override
    public void delete(int id) throws Exception {
        productDao.delete(id);
    }

    @Override
    public int count() {
        return productDao.count();
    }

    @Override
    public List<Product_24110388> findPaginated(int page, int pageSize) {
        return productDao.findPaginated(page, pageSize);
    }
}
