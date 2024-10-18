package com.dkd.manage.domain.dto;

import lombok.Data;

import java.util.List;

@Data
public class TaskDto {

    // 创建类型
    private Long createType;
    // 设备编号
    private String innerCode;
    // 执行人id
    private Long userId;
    // 指派人id
    private Long assignorId;
    // 工单类型
    private Long productTypeId;
    // 描述信息
    private String desc;
    // 工单详情（只有补货工单才涉及）
    private List<TaskDetailsDto> details;
}
