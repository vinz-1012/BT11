package vn.iotstar.dethi05.service.impl;

import vn.iotstar.dethi05.dao.ICategoryDao_24110388;
import vn.iotstar.dethi05.dao.impl.CategoryDao_24110388;
import vn.iotstar.dethi05.entity.Category_24110388;
import vn.iotstar.dethi05.service.ICategoryService_24110388;

import java.util.List;

public class CategoryService_24110388 implements ICategoryService_24110388 {

    private final ICategoryDao_24110388 categoryDao = new CategoryDao_24110388();

    @Override
    public List<Category_24110388> findAll() {
        return categoryDao.findAll();
    }

    @Override
    public Category_24110388 findById(int id) {
        return categoryDao.findById(id);
    }

    @Override
    public void insert(Category_24110388 category) {
        categoryDao.insert(category);
    }

    @Override
    public void update(Category_24110388 category) {
        categoryDao.update(category);
    }

    @Override
    public void delete(int id) throws Exception {
        categoryDao.delete(id);
    }

    @Override
    public int count() {
        return categoryDao.count();
    }

    @Override
    public List<Category_24110388> findPaginated(int page, int pageSize) {
        return categoryDao.findPaginated(page, pageSize);
    }
}
