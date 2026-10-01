package vn.iotstar.dethi05.service.impl;

import vn.iotstar.dethi05.dao.ISellerDao_24110388;
import vn.iotstar.dethi05.dao.impl.SellerDao_24110388;
import vn.iotstar.dethi05.entity.Seller_24110388;
import vn.iotstar.dethi05.service.ISellerService_24110388;

import java.util.List;

public class SellerService_24110388 implements ISellerService_24110388 {

    private final ISellerDao_24110388 sellerDao = new SellerDao_24110388();

    @Override
    public List<Seller_24110388> findAll() {
        return sellerDao.findAll();
    }

    @Override
    public Seller_24110388 findById(int id) {
        return sellerDao.findById(id);
    }

    @Override
    public List<Seller_24110388> findAllWithProducts() {
        return sellerDao.findAllWithProducts();
    }

    @Override
    public void update(Seller_24110388 seller) {
        sellerDao.update(seller);
    }
}
