package com.stock.timeline.application.fixture

import com.stock.timeline.application.domain.Chart
import com.stock.timeline.application.domain.Record
import com.stock.timeline.application.domain.RecordType
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.springframework.mock.web.MockMultipartFile
import org.springframework.web.multipart.MultipartFile
import java.io.ByteArrayOutputStream
import java.time.LocalDate

object ChartFixture {
    fun createSampleChart(): Chart {
        return Chart(title = "Sample Chart")
    }

    fun createSampleRecord(type: RecordType): Record {
        return Record(
            date = LocalDate.now(),
            price = 100.0,
            description = "Sample Record",
            type = type,
            chart = createSampleChart()
        )
    }

    fun createSampleMultipartFile(): MultipartFile {
        val workbook = XSSFWorkbook()
        RecordType.entries.forEach { recordType ->
            val sheet = workbook.createSheet(recordType.name)
            val row = sheet.createRow(0)
            row.createCell(0).setCellValue("Date")
            row.createCell(1).setCellValue("Price")
            row.createCell(2).setCellValue("Description")
            val record = createSampleRecord(recordType)
            val recordRow = sheet.createRow(1)
            recordRow.createCell(0).setCellValue(record.date.toString())
            recordRow.createCell(1).setCellValue(record.price)
            recordRow.createCell(2).setCellValue(record.description)
        }
        val baos = ByteArrayOutputStream()
        workbook.write(baos)
        workbook.close()
        return MockMultipartFile(
            "file",
            "sample.xlsx",
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            baos.toByteArray()
        )
    }

}
