package com.stock.timeline.application.service

import com.stock.timeline.application.domain.Chart
import com.stock.timeline.application.domain.RecordType
import com.stock.timeline.application.fixture.ChartFixture
import com.stock.timeline.application.repository.ChartRepository
import com.stock.timeline.application.repository.RecordRepository
import org.apache.poi.ss.usermodel.WorkbookFactory
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.BeforeEach
import org.mockito.ArgumentMatchers.any
import org.mockito.Mockito.*
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import java.util.*
import kotlin.test.Test

@SpringBootTest
class ChartServiceTest {

    @Autowired
    lateinit var chartService: ChartService

    private lateinit var chartRepository: ChartRepository
    private lateinit var recordRepository: RecordRepository

    @BeforeEach
    fun setUp() {
        chartRepository = mock(ChartRepository::class.java)
        recordRepository = mock(RecordRepository::class.java)
        chartService = ChartService(chartRepository, recordRepository)
    }

    @Test
    fun testUploadFile() {
        val file = ChartFixture.createSampleMultipartFile()
        val title = "Test Chart"

        `when`(chartRepository.save(any(Chart::class.java))).thenReturn(ChartFixture.createSampleChart())

        chartService.save(file, title)

        verify(chartRepository).save(any(Chart::class.java))
        verify(recordRepository).saveAll(anyList())
    }

    @Test
    fun testDownloadSample() {
        val inputStream = chartService.downloadSample()

        assertNotNull(inputStream)

        val workbook = WorkbookFactory.create(inputStream) as XSSFWorkbook
        val sheet = workbook.getSheet(RecordType.DAY.name)
        val row = sheet.getRow(0)

        assertEquals("date", row.getCell(0).stringCellValue)
        assertEquals("price", row.getCell(1).stringCellValue)
        assertEquals("description", row.getCell(2).stringCellValue)

    }

    @Test
    fun testDownloadExcel() {
        val chartId = 1L
        `when`(chartRepository.findById(chartId)).thenReturn(Optional.of(ChartFixture.createSampleChart()))
        val inputStream = chartService.downloadExcel(chartId)

        assertNotNull(inputStream)
    }
}
