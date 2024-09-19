package com.stock.timeline.application.service

import com.stock.timeline.application.domain.Chart
import com.stock.timeline.application.domain.Record
import com.stock.timeline.application.domain.RecordType
import com.stock.timeline.application.repository.ChartRepository
import com.stock.timeline.application.repository.RecordRepository
import com.stock.timeline.application.sample.sampleDayRecord
import com.stock.timeline.application.sample.sampleMonthRecord
import com.stock.timeline.application.sample.sampleWeekRecord
import org.apache.poi.ss.usermodel.*
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import org.springframework.web.multipart.MultipartFile
import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream
import java.time.LocalDate


@Service
class ChartService(
    private val chartRepository: ChartRepository,
    private val recordRepository: RecordRepository
) {

    fun getAllCharts(): List<Chart> = chartRepository.findAll()
    fun getMonthRecords(chartId: Long) = recordRepository.findRecordsByChartIdAndType(chartId, RecordType.MONTH)
    fun getWeekRecords(chartId: Long) = recordRepository.findRecordsByChartIdAndType(chartId, RecordType.WEEK)
    fun getDayRecords(chartId: Long) = recordRepository.findRecordsByChartIdAndType(chartId, RecordType.DAY)

    @Transactional
    fun save(file: MultipartFile, title: String) {
        val workbook = WorkbookFactory.create(file.inputStream)
        val chart = chartRepository.save(Chart(title = title))
        recordRepository.saveAll(extractedRecords(workbook, chart))
        workbook.close()
    }

    fun downloadSample(): ByteArrayInputStream {
        val workbook = XSSFWorkbook()
        RecordType.entries.forEach { recordType ->
            val sheet = workbook.createSheet(recordType.name)
            val records = when (recordType) {
                RecordType.DAY -> sampleDayRecord()
                RecordType.WEEK -> sampleWeekRecord()
                RecordType.MONTH -> sampleMonthRecord()
            }
            addRecordsToSheet(sheet, records)
        }

        val baos = ByteArrayOutputStream()
        workbook.write(baos)
        workbook.close()
        return ByteArrayInputStream(baos.toByteArray())
    }

    // 실제 데이터 레코드를 다운로드하는 함수
    fun downloadExcel(chartId: Long): ByteArrayInputStream {
        val workbook = XSSFWorkbook()
        RecordType.entries.forEach { recordType ->
            val sheet = workbook.createSheet(recordType.name)
            val records = when (recordType) {
                RecordType.DAY -> getDayRecords(chartId)
                RecordType.WEEK -> getWeekRecords(chartId)
                RecordType.MONTH -> getMonthRecords(chartId)
            }
            addRecordsToSheet(sheet, records)
        }

        val baos = ByteArrayOutputStream()
        workbook.write(baos)
        workbook.close()
        return ByteArrayInputStream(baos.toByteArray())
    }

    // 데이터를 추가하는 함수
    private fun addRecordsToSheet(sheet: Sheet, records: List<Record>) {
        val header = sheet.createRow(0)
        val headerColumns = arrayOf("date", "price", "description")
        headerColumns.forEachIndexed { index, column ->
            val cell = header.createCell(index)
            cell.setCellValue(column)
        }

        records.forEachIndexed { index, record ->
            val row = sheet.createRow(1 + index)
            row.createCell(0).setCellValue(record.date)
            row.createCell(1).setCellValue(record.price)
            row.createCell(2).setCellValue(record.description)
        }
    }

    private fun extractedRecords(
        workbook: Workbook,
        chart: Chart
    ): MutableList<Record> {
        val records = mutableListOf<Record>()
        RecordType.entries.forEach { recordType ->
            val sheet = workbook.getSheet(recordType.name)
            sheet?.let {
                records.addAll(extractedSheetRecord(sheet, chart, recordType))
            }
        }
        return records
    }

    @Transactional
    fun save(chartId: Long, file: MultipartFile, title: String) {
        val chart = chartRepository.findById(chartId).orElseThrow { NoSuchElementException() }
        chart.title = title
        recordRepository.deleteAllByChart(chart)
        val workbook = WorkbookFactory.create(file.inputStream)
        recordRepository.saveAll(extractedRecords(workbook, chart))
    }

    private fun extractedSheetRecord(
        sheet: Sheet,
        chart: Chart,
        type: RecordType
    ): MutableList<Record> {
        val records = mutableListOf<Record>()
        for (row in sheet) {
            if (row.rowNum < 1) continue
            val record = Record(
                date = extractedDate(row),
                price = extractedPrice(row),
                description = extractedDescription(row),
                type = type,
                chart = chart
            )
            records.add(record)
        }
        return records
    }

    private fun extractedDescription(row: Row): String {
        val data = row.getCell(2)
        if (data.cellType == CellType.STRING) {
            return data.stringCellValue
        } else {
            throw IllegalArgumentException("Cell does not contain a description.")
        }
    }

    private fun extractedPrice(row: Row): Double {
        val data = row.getCell(1)
        if (data.cellType == CellType.NUMERIC) {
            return data.numericCellValue
        } else {
            throw IllegalArgumentException("Cell does not contain a numeric price.")
        }
    }

    private fun extractedDate(row: Row): LocalDate {
        val data = row.getCell(0)
        if (data.cellType == CellType.NUMERIC) {
            val numericDate: Double = data.numericCellValue
            return DateUtil.getLocalDateTime(numericDate).toLocalDate()

        } else {
            throw IllegalArgumentException("Cell does not contain a numeric date.")
        }
    }

}

