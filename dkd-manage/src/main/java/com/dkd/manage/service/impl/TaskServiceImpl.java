package com.dkd.manage.service.impl;

import java.time.Duration;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.dkd.common.constant.DkdContants;
import com.dkd.common.exception.ServiceException;
import com.dkd.common.utils.DateUtils;
import com.dkd.manage.domain.Emp;
import com.dkd.manage.domain.TaskDetails;
import com.dkd.manage.domain.VendingMachine;
import com.dkd.manage.domain.dto.TaskDetailsDto;
import com.dkd.manage.domain.dto.TaskDto;
import com.dkd.manage.domain.vo.TaskVo;
import com.dkd.manage.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import com.dkd.manage.mapper.TaskMapper;
import com.dkd.manage.domain.Task;
import org.springframework.transaction.annotation.Transactional;

/**
 * 工单Service业务层处理
 *
 * @author hlxllo
 * @date 2024-10-18
 */
@Service
public class TaskServiceImpl implements ITaskService {
    @Autowired
    private TaskMapper taskMapper;

    @Autowired
    private IVendingMachineService vendingMachineService;

    @Autowired
    private IEmpService empService;

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private ITaskDetailsService taskDetailsService;

    /**
     * 查询工单
     *
     * @param taskId 工单主键
     * @return 工单
     */
    @Override
    public Task selectTaskByTaskId(Long taskId) {
        return taskMapper.selectTaskByTaskId(taskId);
    }

    /**
     * 查询工单列表
     *
     * @param task 工单
     * @return 工单
     */
    @Override
    public List<Task> selectTaskList(Task task) {
        return taskMapper.selectTaskList(task);
    }

    /**
     * 新增工单
     *
     * @param task 工单
     * @return 结果
     */
    @Override
    public int insertTask(Task task) {
        task.setCreateTime(DateUtils.getNowDate());
        return taskMapper.insertTask(task);
    }

    /**
     * 修改工单
     *
     * @param task 工单
     * @return 结果
     */
    @Override
    public int updateTask(Task task) {
        task.setUpdateTime(DateUtils.getNowDate());
        return taskMapper.updateTask(task);
    }

    /**
     * 批量删除工单
     *
     * @param taskIds 需要删除的工单主键
     * @return 结果
     */
    @Override
    public int deleteTaskByTaskIds(Long[] taskIds) {
        return taskMapper.deleteTaskByTaskIds(taskIds);
    }

    /**
     * 删除工单信息
     *
     * @param taskId 工单主键
     * @return 结果
     */
    @Override
    public int deleteTaskByTaskId(Long taskId) {
        return taskMapper.deleteTaskByTaskId(taskId);
    }

    /**
     * 查询工单列表
     *
     * @param task
     * @return taskVoList
     */
    @Override
    public List<TaskVo> selectTaskVoList(Task task) {
        return taskMapper.selectTaskVoList(task);
    }

    /**
     * 新增工单
     *
     * @param taskDto
     * @return 结果
     */
    @Transactional
    @Override
    public int insertTaskDto(TaskDto taskDto) {
        // 查询售货机是否存在
        VendingMachine vm = vendingMachineService.selectVendingMachineByInnerCode(taskDto.getInnerCode());
        if (vm == null) {
            throw new ServiceException("设备不存在");
        }
        // 校验售货机状态与工单类型是否相符
        checkCreateTask(vm.getVmStatus(), taskDto.getProductTypeId());
        // 检查设备是否有未完成的同类型工单
        hasUnfinishedTask(taskDto);
        // 检查员工是否存在
        Emp emp = empService.selectEmpById(taskDto.getUserId());
        if (emp == null) {
            throw new ServiceException("员工不存在");
        }
        // 校验员工区域是否匹配
        if (!vm.getRegionId().equals(emp.getRegionId())) {
            throw new ServiceException("员工所在区域与设备所在区域不匹配");
        }
        // 将dto转为po并补充属性，保存工单
        Task task = BeanUtil.copyProperties(taskDto, Task.class);
        // 创建工单
        task.setTaskStatus(DkdContants.TASK_STATUS_CREATE);
        // 执行人名称
        task.setUserName(emp.getUserName());
        // 所属区域id
        task.setRegionId(vm.getRegionId());
        // 地址
        task.setAddr(vm.getAddr());
        // 工单编号
        task.setTaskCode(generateTaskCode());
        // 创建时间
        task.setCreateTime(DateUtils.getNowDate());
        int result = taskMapper.insertTask(task);
        // 判断是否为补货工单
        if (Objects.equals(taskDto.getProductTypeId(), DkdContants.TASK_TYPE_SUPPLY)) {
            // 保存工单详情
            List<TaskDetailsDto> details = taskDto.getDetails();
            if (CollUtil.isEmpty(details)) {
                throw new ServiceException("工单详情不能为空");
            }
            // 将dto转为po并补充属性
            List<TaskDetails> taskDetailsList = details.stream().map(dto -> {
                TaskDetails taskDetails = BeanUtil.copyProperties(dto, TaskDetails.class);
                taskDetails.setTaskId(task.getTaskId());
                return taskDetails;
            }).collect(Collectors.toList());
            taskDetailsService.insertTaskDetailsBatch(taskDetailsList);

        }
        return result;
    }

    /**
     * 取消工单
     * @param task
     * @return 结果
     */
    @Override
    public int cancelTask(Task task) {
        // 判断工单状态是否可以取消
        // 先根据id查数据库
        Task taskDb = taskMapper.selectTaskByTaskId(task.getTaskId());
        // 如果工单状态为已取消，则抛出异常
        if (taskDb.getTaskStatus().equals(DkdContants.TASK_STATUS_CANCEL)) {
            throw new ServiceException("工单已取消，无法再次取消");
        }
        // 如果工单状态为已完成，则抛出异常
        if (taskDb.getTaskStatus().equals(DkdContants.TASK_STATUS_FINISH)) {
            throw new ServiceException("工单已完成，无法取消");
        }
        // 设置更新字段
        // 更新状态为取消
        task.setTaskStatus(DkdContants.TASK_STATUS_CANCEL);
        // 更新时间
        task.setUpdateTime(DateUtils.getNowDate());
        return taskMapper.updateTask(task);
    }

    // 生成并获取当天工单编号（唯一标识）
    private String generateTaskCode() {
        // 获取当前日期并格式化为年月日
        String dateStr = DateUtils.getDate().replaceAll("-", "");
        // 根据日期生成redis的键
        String key = "dkd.task.code" + dateStr;
        // 判断key是否存在
        if (!redisTemplate.hasKey(key)) {
            // 如果key不存在，设置初始值为1，并指定过期时间为1天
            redisTemplate.opsForValue().set(key, 1, Duration.ofDays(1));
            // 返回工单编号
            return dateStr + "0001";
        }
        // 如果key存在，计数器+1
        return dateStr + StrUtil.padPre(redisTemplate.opsForValue().increment(key).toString(), 4, "0");
    }

    // 校验售货机状态与工单类型是否相符
    private void checkCreateTask(Long vmStatus, Long productTypeId) {
        // 如果是投放工单，设备在运行中，抛出异常
        if (productTypeId == DkdContants.TASK_TYPE_DEPLOY && vmStatus == DkdContants.VM_STATUS_RUNNING) {
            throw new ServiceException("设备正在运行中，无法进行投放操作");
        }
        // 如果是是维修工单，设备不在运行中，抛出异常
        if (productTypeId == DkdContants.TASK_TYPE_REPAIR && vmStatus != DkdContants.VM_STATUS_RUNNING) {
            throw new ServiceException("设备不在运行中，无法进行维修操作");
        }
        // 如果是补货工单，设备不在运行中，抛出异常
        if (productTypeId == DkdContants.TASK_TYPE_SUPPLY && vmStatus != DkdContants.VM_STATUS_RUNNING) {
            throw new ServiceException("设备不在运行中，无法进行补货操作");
        }
        // 如果是撤机工单，设备不在运行中，抛出异常
        if (productTypeId == DkdContants.TASK_TYPE_REVOKE && vmStatus != DkdContants.VM_STATUS_RUNNING) {
            throw new ServiceException("设备不在运行中，无法进行撤机操作");
        }
    }

    // 检查设备是否有未完成的同类型工单
    private void hasUnfinishedTask(TaskDto taskDto) {
        Task task = new Task();
        task.setInnerCode(taskDto.getInnerCode());
        task.setProductTypeId(taskDto.getProductTypeId());
        task.setTaskStatus(DkdContants.TASK_STATUS_PROGRESS);
        // 查询是否有符合条件的工单列表
        List<Task> taskProgressing = taskMapper.selectTaskList(task);
        task.setTaskStatus(DkdContants.TASK_STATUS_CREATE);
        List<Task> taskCreated = taskMapper.selectTaskList(task);
        // 如果有，抛出异常
        if (taskProgressing.size() > 0 || taskCreated.size() > 0) {
            throw new ServiceException("设备存在未完成的工单，无法创建新的工单");
        }
    }
}
