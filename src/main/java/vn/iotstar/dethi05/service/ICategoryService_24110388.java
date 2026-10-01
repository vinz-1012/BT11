package vn.iotstar.dethi05.service;

import vn.iotstar.dethi05.entity.Category_24110388;
import java.util.List;

public interface ICategoryService_24110388 {
    List<Category_24110388> findAll();
    Category_24110388 findById(int id);
    void insert(Category_24110388 category);
    void update(Category_24110388 category);
    void delete(int id) throws Exception;
    int count();
    List<Category_24110388> findPaginated(int page, int pageSize);
}
