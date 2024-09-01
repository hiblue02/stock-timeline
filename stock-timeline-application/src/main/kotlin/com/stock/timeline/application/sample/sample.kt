package com.stock.timeline.application.sample

import com.stock.timeline.application.domain.Chart
import com.stock.timeline.application.domain.Record
import com.stock.timeline.application.domain.RecordType
import java.time.LocalDate

fun sampleDayRecord() = listOf(
    Record(
        date = LocalDate.parse("2024-01-01"),
        price = 20000.0,
        description = "Sample day record",
        type = RecordType.DAY,
        chart = createSampleChart()
    ),
    Record(
        date = LocalDate.parse("2024-01-02"),
        price = 10000.0,
        description = "Sample day record",
        type = RecordType.DAY,
        chart = createSampleChart()
    ),
    Record(
        date = LocalDate.parse("2024-01-03"),
        price = 22348.0,
        description = "Sample day record",
        type = RecordType.DAY,
        chart = createSampleChart()
    )
)

fun sampleWeekRecord() = listOf(
    Record(
        date = LocalDate.parse("2024-01-01"),
        price = 20000.0,
        description = "Sample week record",
        type = RecordType.WEEK,
        chart = createSampleChart()
    ),
    Record(
        date = LocalDate.parse("2024-01-08"),
        price = 10000.0,
        description = "Sample week record",
        type = RecordType.WEEK,
        chart = createSampleChart()
    ),
    Record(
        date = LocalDate.parse("2024-01-15"),
        price = 22348.0,
        description = "Sample week record",
        type = RecordType.WEEK,
        chart = createSampleChart()
    )
)

fun sampleMonthRecord() = listOf(
    Record(
        date = LocalDate.parse("2024-01-01"),
        price = 20000.0,
        description = "Sample month record",
        type = RecordType.MONTH,
        chart = createSampleChart()
    ),
    Record(
        date = LocalDate.parse("2024-02-01"),
        price = 10000.0,
        description = "Sample month record",
        type = RecordType.MONTH,
        chart = createSampleChart()
    ),
    Record(
        date = LocalDate.parse("2024-03-01"),
        price = 22348.0,
        description = "Sample month record",
        type = RecordType.MONTH,
        chart = createSampleChart()
    )
)

// 샘플 Chart 객체 생성 함수
fun createSampleChart(): Chart {
    return Chart(title = "Sample 1")
}
