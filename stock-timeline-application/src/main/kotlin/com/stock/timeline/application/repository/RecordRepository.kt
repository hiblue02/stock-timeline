package com.stock.timeline.application.repository

import com.stock.timeline.application.domain.Chart
import com.stock.timeline.application.domain.Record
import com.stock.timeline.application.domain.RecordType
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.transaction.annotation.Transactional

interface RecordRepository : JpaRepository<Record, Long> {

    @Transactional
    @Modifying
    @Query("delete from Record r where r.chart = ?1")
    fun deleteAllByChart(chart: Chart): Int

    fun findRecordsByChartIdAndType(chartId: Long, type: RecordType): List<Record>
}
