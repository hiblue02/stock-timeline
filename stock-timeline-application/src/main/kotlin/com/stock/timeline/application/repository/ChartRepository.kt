package com.stock.timeline.application.repository

import com.stock.timeline.application.domain.Chart
import org.springframework.data.jpa.repository.JpaRepository

interface ChartRepository : JpaRepository<Chart, Long> {
}
