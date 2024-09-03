package com.stock.timeline.application.repository

import com.stock.timeline.application.domain.Chart
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface ChartRepository : JpaRepository<Chart, Long> {
}
