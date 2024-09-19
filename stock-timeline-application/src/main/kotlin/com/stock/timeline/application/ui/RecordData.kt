package com.stock.timeline.application.ui

import java.time.LocalDate

data class RecordData(
    val date: LocalDate,
    val price:Double,
    val description:String
)
