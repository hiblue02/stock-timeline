package com.stock.timeline.application.service

import com.stock.timeline.application.domain.Chart
import com.stock.timeline.application.domain.RecordType
import com.stock.timeline.application.repository.ChartRepository
import com.stock.timeline.application.repository.RecordRepository
import org.springframework.stereotype.Service

@Service
class ChartService(
    private val chartRepository: ChartRepository,
    private val recordRepository: RecordRepository
) {

    fun getAllCharts(): List<Chart> = chartRepository.findAll();
    fun getMonthRecords(chartId: Long) = recordRepository.findRecordsByChartIdAndType(chartId, RecordType.MONTH)
    fun getWeekRecords(chartId: Long) = recordRepository.findRecordsByChartIdAndType(chartId, RecordType.WEEK)
    fun getDayRecords(chartId: Long) = recordRepository.findRecordsByChartIdAndType(chartId, RecordType.DAY)

}
