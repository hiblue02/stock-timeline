package com.stock.timeline.application.ui

import com.stock.timeline.application.domain.Chart
import com.stock.timeline.application.domain.Record
import com.stock.timeline.application.service.ChartService
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile


@RestController
@RequestMapping("charts")
internal class ChartController(
    private val chartService: ChartService<Any?>
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

}

