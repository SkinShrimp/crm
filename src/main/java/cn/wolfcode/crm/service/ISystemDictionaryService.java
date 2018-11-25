package cn.wolfcode.crm.service;

import cn.wolfcode.crm.domain.SystemDictionary;
import cn.wolfcode.crm.query.QueryObject;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface ISystemDictionaryService {
    public abstract void save(SystemDictionary entry);

    public abstract void delete(Long id);

    public abstract void update(SystemDictionary entry);

    public abstract SystemDictionary get(Long id);

    public abstract List<SystemDictionary> listAll();

    //角色不支持高级查询
    public abstract PageInfo<SystemDictionary> query(QueryObject qo);
}
