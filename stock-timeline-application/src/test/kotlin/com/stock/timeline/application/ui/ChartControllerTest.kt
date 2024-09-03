package com.stock.timeline.application.ui

import com.stock.timeline.application.domain.Chart
import com.stock.timeline.application.service.ChartService
import org.junit.jupiter.api.Test
import org.mockito.Mockito.doNothing
import org.mockito.Mockito.`when`
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest
import org.springframework.boot.test.mock.mockito.MockBean
import org.springframework.http.MediaType
import org.springframework.mock.web.MockMultipartFile
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders
import org.springframework.test.web.servlet.result.MockMvcResultMatchers
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.status

@WebMvcTest(ChartController::class)
class ChartControllerTest {

    @Autowired
    private lateinit var mockMvc: MockMvc

    @MockBean
    private lateinit var chartService: ChartService

    @Test
    fun `all charts`() {
        val charts = listOf(Chart(1L, "Chart1"), Chart(2L, "Chart2"))
        `when`(chartService.getAllCharts()).thenReturn(charts)
        mockMvc.perform(MockMvcRequestBuilders.get("/charts"))
            .andExpect(status().isOk)
            .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON))
            .andExpect(MockMvcResultMatchers.jsonPath("$[0].id").value(1))
            .andExpect(MockMvcResultMatchers.jsonPath("$[0].title").value("Chart1"))
            .andExpect(MockMvcResultMatchers.jsonPath("$[1].id").value(2L))
            .andExpect(MockMvcResultMatchers.jsonPath("$[1].title").value("Chart2"))

    }

    @Test
    fun `should upload file`() {
        val file = MockMultipartFile("file", "test.xlsx", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", ByteArray(0))
        val title = "Test Chart"

        doNothing().`when`(chartService).save(file, title)

        mockMvc.perform(MockMvcRequestBuilders.multipart("/charts/upload")
            .file(file)
            .param("title", title))
            .andExpect(status().isOk)
            .andExpect(MockMvcResultMatchers.content().string("success"))
    }



}
