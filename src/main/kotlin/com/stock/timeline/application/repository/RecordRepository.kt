package com.stock.timeline.application.repository

import com.stock.timeline.application.domain.Record
import com.stock.timeline.application.domain.RecordType
import org.springframework.data.jpa.repository.JpaRepository

interface RecordRepository : JpaRepository<Record, Long> {
    fun findRecordsByChartIdAndType(chartId: Long, type: RecordType): List<Record>
}
