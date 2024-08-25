package com.stock.timeline.application

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class TimelineApplication

fun main(args: Array<String>) {
	runApplication<TimelineApplication>(*args)
}
