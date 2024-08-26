package com.stock.timeline.application.service

import com.stock.timeline.application.domain.Chart
import com.stock.timeline.application.domain.Record
import com.stock.timeline.application.domain.RecordType
import com.stock.timeline.application.repository.ChartRepository
import com.stock.timeline.application.repository.RecordRepository
import org.apache.poi.ss.usermodel.*
import org.springframework.stereotype.Service
import org.springframework.web.multipart.MultipartFile
import java.time.LocalDate


@Service
class ChartService<InputStream>(
    private val chartRepository: ChartRepository,
    private val recordRepository: RecordRepository
) {

    fun getAllCharts(): List<Chart> = chartRepository.findAll();
    fun getMonthRecords(chartId: Long) = recordRepository.findRecordsByChartIdAndType(chartId, RecordType.MONTH)
    fun getWeekRecords(chartId: Long) = recordRepository.findRecordsByChartIdAndType(chartId, RecordType.WEEK)
    fun getDayRecords(chartId: Long) = recordRepository.findRecordsByChartIdAndType(chartId, RecordType.DAY)
    fun save(file: MultipartFile, title: String) {
        val workbook = WorkbookFactory.create(file.inputStream)

        val chart = chartRepository.save(Chart(title = title))

        RecordType.entries.forEach { recordType ->
            run {
                val sheet: Sheet = workbook.getSheet(recordType.name)
                extractedRecord(sheet, chart, recordType)
            }
        }
        workbook.close()

    }

    private fun extractedRecord(
        sheet: Sheet,
        chart: Chart,
        type: RecordType
    ) {
        for (row in sheet) {
            if (row.rowNum <= 2) continue
            recordRepository.save(
                Record(
                    date = extractedDate(row),
                    price = extractedPrice(row),
                    description = extractedDescription(row),
                    type = type,
                    chart = chart
                )
            )
        }
    }

    private fun extractedDescription(row: Row): String {
        val data = row.getCell(0)
        if (data.cellType == CellType.STRING) {
            return data.stringCellValue
        } else {
            throw IllegalArgumentException("Cell does not contain a description.")
        }
    }

    private fun extractedPrice(row: Row): Double {
        val data = row.getCell(0)
        if (data.cellType == CellType.NUMERIC) {
            return data.numericCellValue
        } else {
            throw IllegalArgumentException("Cell does not contain a numeric price.")
        }
    }

    private fun extractedDate(row: Row): LocalDate {
        val data = row.getCell(0)
        if (data.cellType == CellType.NUMERIC && DateUtil.isCellDateFormatted(data)) {
            val numericDate: Double = data.numericCellValue
            return DateUtil.getLocalDateTime(numericDate).toLocalDate()

        } else {
            throw IllegalArgumentException("Cell does not contain a numeric date.")
        }
    }
}

