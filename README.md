# stock-timeline

### 하고 싶었던 것
- 주식 가격, 일자와 관련된 기록(설명)을 입력하고, 그래프로 보여주는 어플리케이션을 만들고 싶었다. 

### 구현한 것
#### 메인 
![stock-timeline-main.png](image%2Fstock-timeline-main.png)
  
#### 주식 차트 목록
![stock-timeline-chart-list.png](image%2Fstock-timeline-chart-list.png)
<details>
 <summary><code>GET</code> <code><b>/</b></code> <code>charts</code> 주식 차트 목록 조회 </summary>

##### Parameters
- None

##### Responses
- http code: ```200``` 
- content-type: ```application/json;charset=UTF-8``` 
- response:
  ```json
    [{"id":1,"title":"example1234","updateDateTime":"2024-09-19T23:46:25.303502"}] 
   ```
</details>

<details>
 <summary><code>GET</code> <code><b>/</b></code> <code>charts/download</code> 주식 차트 샘플 다운로드 </summary>

##### Parameters
- None

##### Responses
- http code: ```200```
- content-type: ```application/vnd.openxmlformats-officedocument.spreadsheetml.sheet```
- response: None
</details>

<details>
 <summary><code>GET</code> <code><b>/</b></code> <code>charts/{chartId}/download</code> 주식 차트 다운로드 </summary>

##### Parameters
- chartId (Long)

##### Responses
- http code: ```200```
- content-type: ```application/vnd.openxmlformats-officedocument.spreadsheetml.sheet```
- response: None
</details>

    
#### 주식 차트 등록/수정
![stock-timeline-chart-create.png](image%2Fstock-timeline-chart-create.png)
<details>
 <summary><code>POST</code> <code><b>/</b></code> <code>charts/upload</code> 주식 차트 엑셀파일 등록 </summary>

##### Parameters
- title (String)
- file (MultipartFile)

##### Responses
- http code: ```200```
- content-type: None
- response: None

</details>
<details>
 <summary><code>POST</code> <code><b>/</b></code> <code>charts/{chartId}/upload</code> 주식 차트 엑셀파일 재등록 </summary>

##### Parameters
- chartId (Long)
- title (String)
- file (MultipartFile)

##### Responses
- http code: ```200```
- content-type: None
- response: None

</details>

#### 주식 차트 그래프 보기
![stock-timeline-graph.png](image%2Fstock-timeline-graph.png)
<details>
 <summary><code>GET</code> <code><b>/</b></code> <code>charts/{chartId}/day</code> 일간 차트 조회 </summary>

##### Parameters
- chartId (Long)

##### Responses
-  http code: ```200```
-  content-type: ```application/json```

-  response : 
    ```json
    [
        {
            "date": "2024-01-01",
            "price": 20000.0,
            "description": "Sample day record"
        },
        {  
            "date": "2024-01-02",
            "price": 10000.0,
            "description": "Sample day record"
        },
        {
            "date": "2024-01-03",
            "price": 22348.0,
            "description": "Sample day record"
        }
    ]
    ```

</details>

<details>
 <summary><code>GET</code> <code><b>/</b></code> <code>charts/{chartId}/day</code> 일간 차트 조회 </summary>

##### Parameters
- chartId (Long)

##### Responses
-  http code: ```200```
-  content-type: ```application/json```

-  response :
    ```json
    [
        {
            "date": "2024-01-01",
            "price": 20000.0,
            "description": "Sample day record"
        },
        {  
            "date": "2024-01-02",
            "price": 10000.0,
            "description": "Sample day record"
        },
        {
            "date": "2024-01-03",
            "price": 22348.0,
            "description": "Sample day record"
        }
    ]
    ```

</details>
<details>
 <summary><code>GET</code> <code><b>/</b></code> <code>charts/{chartId}/week</code> 주간 차트 조회 </summary>

##### Parameters
- chartId (Long)

##### Responses
-  http code: ```200```
-  content-type: ```application/json```
-  response :
    ```json
    [
      {
        "date": "2024-01-01",
        "price": 20000.0,
        "description": "Sample week record"
      },
      {
        "date": "2024-01-08",
        "price": 10000.0,
        "description": "Sample week record"
      },
      {
        "date": "2024-01-15",
        "price": 22348.0,
        "description": "Sample week record"
      }
    ]
    ```
</details>

<details>
 <summary><code>GET</code> <code><b>/</b></code> <code>charts/{chartId}/month</code> 월간 차트 조회 </summary>

##### Parameters
- chartId (Long)

##### Responses
-  http code: ```200```
-  content-type: ```application/json```
  -  response :
      ```json
      [
        {
          "date": "2024-01-01",
          "price": 20000.0,
          "description": "Sample month record"
        },
        {
          "date": "2024-02-01",
          "price": 10000.0,
          "description": "Sample month record"
        },
        {
          "date": "2024-03-01",
          "price": 22348.0,
          "description": "Sample month record"
        }
      ]
      ```
</details>

### 새롭게 알게 된 것: CORS - Cross-Origin Resource Sharing
프론트엔드 서버와 백엔드 서버를 따로 구성하면, 백엔드 서버에서 다른 주소의 요청을 받을 수 있도록 설정해야 한다. 
같은 출처(주소)가 같은 곳에 대한 요청만 허용하는 것이 기본 설정이기 때문이다. 
스프링 웹 서블릿에서는 CorsResitory로 설정할 수 있다. 
```java
@Configuration
class WebMnbConfig : WebMvcConfigurer {

    override fun addCorsMappings(registry: CorsRegistry) {
        registry.addMapping("/**")
            .allowedOrigins("*")
            .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
        super.addCorsMappings(registry)
    }
}
```


### 사용 기술 스택
#### ui
Flutter(Dart)
#### server
JPA, Kotiln, H2 Database, SpringBoot, Gradle 
