package cn.wolfcode.crm.service;

import cn.wolfcode.crm.domain.SystemDictionaryItem;
import cn.wolfcode.crm.query.QueryObject;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface ISystemDictionaryItemService {
    public abstract void save(SystemDictionaryItem entry);

    public abstract void delete(Long id);

    public abstract void update(SystemDictionaryItem entry);

    public abstract SystemDictionaryItem get(Long id);

    public abstract List<SystemDictionaryItem> listAll();

    //角色不支持高级查询
    public abstract PageInfo<SystemDictionaryItem> query(QueryObject qo);

    public abstract List<SystemDictionaryItem> listByParentId(Long parentId);

    public abstract List<SystemDictionaryItem> listJobs();

    public abstract List<SystemDictionaryItem> listSources();
}
