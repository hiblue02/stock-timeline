package com.stock.timeline.application.ui

import com.stock.timeline.application.domain.Chart
import com.stock.timeline.application.domain.Record
import com.stock.timeline.application.service.ChartService
import org.springframework.http.HttpHeaders
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile
import java.io.ByteArrayInputStream


@RestController
@RequestMapping("charts")
internal class ChartController(
    private val chartService: ChartService
) {

    @GetMapping
    fun getAllCharts(): ResponseEntity<List<Chart>> {
        val allCharts = chartService.getAllCharts()
        return ResponseEntity.ok(allCharts)
    }

    @GetMapping("/{chartId}/week")
    fun getWeekRecords(@PathVariable chartId: Long): ResponseEntity<List<Record>> {
        val weekRecords = chartService.getWeekRecords(chartId)
        return ResponseEntity.ok(weekRecords)
    }

    @GetMapping("/{chartId}/month")
    fun getMonthRecords(@PathVariable chartId: Long): ResponseEntity<List<Record>> {
        val monthRecords = chartService.getMonthRecords(chartId)
        return ResponseEntity.ok(monthRecords)
    }


    @GetMapping("/{chartId}/day")
    fun getDayRecords(@PathVariable chartId: Long): ResponseEntity<List<Record>> {
        val dayRecords = chartService.getDayRecords(chartId)
        return ResponseEntity.ok(dayRecords)
    }

    @PostMapping("/upload")
    fun upload(@RequestParam file:MultipartFile, @RequestParam title: String) : ResponseEntity<String>{
        chartService.save(file, title)
        return ResponseEntity.ok("success")
    }

    @PostMapping("/{chartId}/ upload")
    fun uploadAgain(@RequestParam file:MultipartFile, @RequestParam title: String, @PathVariable chartId: Long) : ResponseEntity<String>{
        chartService.save(chartId, file, title)
        return ResponseEntity.ok("success")
    }

    @GetMapping("/download")
    fun downloadSample(): ResponseEntity<ByteArrayInputStream> {
        val excelStream: ByteArrayInputStream = chartService.downloadSample()

        val headers = HttpHeaders().apply {
            add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=sample.xlsx")
            add(HttpHeaders.CONTENT_TYPE, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        }

        return ResponseEntity(excelStream, headers, HttpStatus.OK)
    }


    @GetMapping("/{chartId}/download")
    fun download(@PathVariable chartId: Long): ResponseEntity<ByteArrayInputStream> {
        val excelStream: ByteArrayInputStream = chartService.downloadExcel(chartId)

        val headers = HttpHeaders().apply {
            add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=sample.xlsx")
            add(HttpHeaders.CONTENT_TYPE, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        }

        return ResponseEntity(excelStream, headers, HttpStatus.OK)
    }
}

