package com.stock.timeline.application.domain

import jakarta.persistence.Entity
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import jakarta.persistence.Id
import jakarta.persistence.ManyToOne
import java.time.LocalDate

@Entity
data class Record(
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id:Long? = null,
    val date:LocalDate,
    val price:Double,
    val description:String,
    val type: RecordType,
    @ManyToOne
    val chart:Chart
)
