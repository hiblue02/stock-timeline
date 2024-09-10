package com.stock.timeline.application.repository

import com.stock.timeline.application.domain.Chart
import com.stock.timeline.application.domain.Record
import com.stock.timeline.application.domain.RecordType
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository

@Repository
interface RecordRepository : JpaRepository<Record, Long> {

    @Modifying
    @Query("delete from Record r where r.chart = ?1")
    fun deleteAllByChart(chart: Chart): Int

    @Query("select r from Record r where r.chart.id = ?1 and r.type = ?2")
    fun findRecordsByChartIdAndType(chartId: Long, type: RecordType): List<Record>
}
