/* DATE_ADD () 또는 DATE_SUB ()
 * DATE_ADD (날짜형태의 숫자 문자 날짜 타입 값 또는 컬럼, INTERVAL 기간 YEAR / MONTH / DAY) : 인터벌 기간 후의 날짜
 * DATE_SUB (날짜형태의 숫자 문자 날짜 타입 값 또는 컬럼, INTERVAL 기간 YEAR / MONTH / DAY) : 인터벌 기간 전의 날짜
 * 
 * DAYOFWEEK ()
 * : 해당 날짜의 요일을 알 수 있다.
 * : 1은 일요일, 7일 토요일
 * : DAYOFWEEK (날짜형태의 숫자 문자 날짜 타입 값 또는 컬럼)
 * 
 * LAST_DAY ()
 * : 주어진 날짜의 마지막 일자를 조회한다.
 * 
 * CAST () 또는 CONVERT () 
 * : 주어진 값을 원하는 형식으로 변경하는 함수
 * : CAST(값 또는 컬럼 AS 변경 타입)
 * : CONVERT (값 또는 컬럼, 변경 타입)
 * 
 * 관계형 데이터베이스에서는 DBMS의 설정 정보들을 테이블 형태로 관리한다.
 * 이를 데이터사전(데이터 딕셔너리)라고 부른다.
 * 기본적으로 시스템 관리자만 설정을 변경할 수 있지만,
 * 사용자 계정도 사용자가 접속한 동안에는 변경 가능하다. 대신 재접속하면 초기화된다.
 * 
 * ---SELECT 문의 실행 순서---
 * SELECT 컬럼 AS 별칭, 계산식, 함수, ...
 * FROM 테이블명
 * WHERE 조건
 * GROUP BY 그룹을 묶을 컬럼명
 * HAVING 그룹에 대한 조건식, 함수
 * (HAVING 쓰면 WHERE 안쓴다.)
 * ORDER BY 컬럼명 별칭 컬럼 순서 [ASC / DESC][, 컬럼명 ...]
 * (SELECT 결과가 가져온 ROW의 개수가 0일 수 있다. 단순히 아무것도 안가져온 것이다.)
 * (DELETE 도 결과가 지운 ROW의 개수가 0일 수 있다. 단순히 아무것도 안지운 것이다.)
 * (FROM에 2개 이상의 테이블 써서 갖고 올 수 있다.)
 * 1. 테이블을 가져온다.
 * 2. WHERE 조건식과 각 ROW 대조
 * 3. GROUP BY의 컬럼명으로 묶는다.
 * 4. HAVING의 조건대로 그룹에 대한 조건 대조
 * 5. SELECT 문 내용대로 실행
 * 6. ORDER BY 내용대로 정렬
 * 
 * ORDER BY 절
 * : SELECT 절을 통해 저회한 행의 결과들을 특정 기준에 맞춰 정렬하는 구문
 * 기본 정렬 기준은 기본키의 오름차순
 * 정렬 기준은 1개이상 사용할 수 있다.
 * 다만, 앞에 쓴 기준대로 정렬한 뒤에, 뒤에 쓴 기준들 대로 정렬한다.
 * SELECT 문의 별칭 또는 컬럼 순서의 수를 갖고 정렬도 가능하다.
 * (정리할 때 별칭 순서 예시 하나 붙이기)
 * 
 * GROUP BY 절
 * : 특정 컬럼이나 계산식을 하나의 그룹으로 묶어 한 테이블 내에 소그룹 별로 조회하려할 때 선언하는 구문
 * 여러개의 컬럼을 쓸 수 있다.
 * (앞에 있는 컬럼 기준으로 소그룹을 만들고, 뒤에 있는 컬럼들 기준으로 그 안에 다시 소그룹들을 만든다.)
 * 
 * HAVING 구문
 * : GROUP BY한 각 소그룹에 대한 조건을 설정
 * : GROUP BY를 사용했을 때 사용한다.
 * WHERE 절은 못쓰는건 아니나 WHERE 절을 이용하면 SELECT 구문 실행 구조 상 이상한 결과 값을 갖고온다.
 * (WHERE이 먼저 실행되고, 그 다음에 GROUP BY를 실행하기 때문이다.)
 * 그래서 GROUP BY를 쓰면, WHERE이 아닌 HAVING으로 조건을 설정해야 정확한 결과 값이 나온다.
 * (예시 하나 붙이기)
 * 
 * [SET OPERATOR]
 * : 두 개 이상의 SELECT 결과(RESULT SET)를 합쳐 집합 형태의 결과로 조회하는 명령어
 * 
 * 합집합
 * 	1) UNION 
 * 	: 두 개 이상의 SELET한 결과를 하나로 합치는 명령어
 * 	(단, 중복 결과는 1번만 보여준다.)
 * 	: 두 개 이상의 SELECT문 중간에 UNION을 붙인다.
 * 	(UNION 할 경우, UNION 앞에 있는 SELECT 문에는 ;를 쓰면 안된다.)
 * 	(UNION 할 SELECT 문들은 SELECT할 컬럼의 개수가 맞아야 한다.)
 * 	(정리할 때 예시 붙이기)
 * 
 * 	2) UNION ALL
 * 	: 두 개 이상의 SELECT한 결과를 하나로 합치는 명령어
 * 	(단, UNION과 다르게 중복 결과를 모두 보여준다.)
 * 	: 두 개 이상의 SELECT문 중간에 UNION ALL을 붙인다.
 * 	(UNION 할 경우, UNION 앞에 있는 SELECT 문에는 ;를 쓰면 안된다.)
 * 	(UNION 할 SELECT 문들은 SELECT할 컬럼의 개수가 맞아야 한다.)
 * 
 * 3) JOIN
 * : 2개 이상의 테이블을 하나로 합쳐 사용하는 명령어
 * : 결과 값이 아닌 다른 테이블을 옆에 붙이는 개념이다.
 * : 참조 관계가 아니어도 JOIN 가능하다.
 * : 조인하고자 하는 테이블을 FROM 구문 다음에 JOIN 테이블명 ON () 또는 USING () 구문을 사용한다.
 * ( ()안에 조건을 넣는다. 공통 컬럼 외에도 다른 조건 넣을 수 있다.)
 * (두 테이블의 비교 기준이 될 공통 컬럼명이 다른 경우 ON의 ()안에서 두 컬럼을 연결한다.)
 * (두 테이블의 비교 기준이 될 공통 컬럼명이 같은 경우 ON의 () 안에 테이블의 컬럼인지 명확하게 인식시켜줘야한다.)
 * (아니면 USING의 () 안에 공통 컬럼명만 적는다.)
 * (다만, USING을 쓰면 조인한 테이블의 컬럼이 섞여서 나올 수 있다.)
 * (그리고 공통 컬럼명이 같을 때 만약 SELECT문에 공통컬럼이 쓰인다면, SELECT문에도 해당 컬럼이 어떤 테이블의 컬럼인지 명시해야한다.)
 * 
 * (정리할 때 예시 붙이기)
 * 
 * INNER JOIN
 * : 조건에 일치하는 데이터만 선택
 * : 조건에 일치하지 않는 데이터들은 갖고 오지 않는다.
 * (JOIN은 기본적으로 INNER JOIN을 실행한다.)
 * 
 * OUTER JOIN(LEFT, RIGHT)
 * LEFT : 첫번째 테이블을 기준으로 두번째 테이블을 조합한다.
 * Ex) FROM EMPLOYEE JOIN JOB ==> EMPLOYEE가 첫번째 테이블, JOB이 두번째 테이블.
 * (조건을 만족하지 않는 경우, 첫번째 테이블의 필드값은 그대로 두고 두번째 테이블의 필드 값은 NULL로 처리한다.)
 * (INNER JOIN와 다르게 조건에 일치하지 않는 데이터여도 갖고는 온다.)
 * 
 * 
 * RIGHT : 두번째 테이블을 기준으로 첫번째 테이블을 조합한다.
 * Ex) FROM EMPLOYEE JOIN JOB ==> EMPLOYEE가 첫번째 테이블, JOB이 두번째 테이블.
 * (조건을 만족하지 않는 경우, 두번째 테이블의 필드 값을 그대로 두고 첫번째 테이블의 필드 값은 NULL로 처리한다.)
 * 
 * SELF JOIN
 * : 한 테이블의 정보 중 값 비교가 필요한 정보들을 계산하여 조회한다.
 * : 자기 자신을 조인한다.
 * (자기 자신을 JOIN하다보니 컬럼명이 동일하므로, 테이블을 명확하게 구분해줘야한다.)
 * 
 * 다중 JOIN
 * : 여러 개의 테이블을 JOIN 한다.
 * : 기본적으로 JOIN 선언 방식과 동일하나, 앞서 조인한 결과를 기준으로 뒤의 테이블들을 조인한다.
 * (그러므로, 조인 순서가 매우 중요하다.)
 * 
 * SUB QUERY
 * : 메인 쿼리 안에서 조건이나 검색을 위한 또 다른 쿼리를 추가해 작성하는 기법.
 * : SELECT, FROM, WHERE, GROUP BY, HAVING, OREDER BY, JOIN, DML, DDL 등 거의 대부분 사용 가능하다.
 * (FROM에 사용되는 서브쿼리는 테이블 명으로 테이블을 직접 조회하는 대신,
 * 서브쿼리 결과(RESULT SET)을 테이블처럼 활용해 데이터를 조회한다.) ==> INLINE VIEW(인라인 뷰)
 * (FROM에서 사용되는 서브쿼리는 별칭 선언해야한다.)
 * 
 * 1. 단일 행 서브쿼리
 * : 결과 값이 1개 나오는 서브쿼리
 * 
 * 2. 다중 행 서브쿼리
 * : 결과 값이 2개 이상 나오는 서브쿼리
 * 
 * 3. 다중 행 다중 열 서브쿼리
 * : 여러 컬럼과 여러 로우를 가지는 서브쿼리
 * ()를 적절하게 써야한다.
 * 
 */

-- DATE_ADD / DATE_SUB 함수
SELECT EMP_NAME, HIRE_DATE,
	   DATE_ADD(HIRE_DATE, INTERVAL 4 MONTH) AS '인터벌 기간 뒤의 날짜',
	   DATE_ADD(HIRE_DATE, INTERVAL 2 YEAR) AS '인터벌 기간 뒤의 날짜',
	   DATE_ADD(HIRE_DATE, INTERVAL 4 DAY) AS '인터벌 기간 뒤의 날짜',
	   DATE_SUB(HIRE_DATE, INTERVAL 1 YEAR) AS '인터벌 기간 전의 날짜',
	   DATE_SUB(HIRE_DATE, INTERVAL 5 MONTH) AS '인터벌 기간 전의 날짜',
	   DATE_SUB(HIRE_DATE, INTERVAL 5 DAY) AS '인터벌 기간 전의 날짜'
FROM EMPLOYEE;

-- DAYOFWEEK 함수
SELECT DAYOFWEEK(NOW());
SELECT DAYOFWEEK('20230120');

-- 사원들이 입사한 날의 요일을 조회한다.
-- 단, 숫자가 아닌 일요일 - 토요일로 조회한다.
SELECT EMP_NAME 사원명,
	CASE 
		WHEN DAYOFWEEK(HIRE_DATE) = 1 THEN '일요일'
		WHEN DAYOFWEEK(HIRE_DATE) = 2 THEN '월요일'
		WHEN DAYOFWEEK(HIRE_DATE) = 3 THEN '화요일'
		WHEN DAYOFWEEK(HIRE_DATE) = 4 
		OR DAYOFWEEK(HIRE_DATE) = 5 THEN '수요일'
		WHEN DAYOFWEEK(HIRE_DATE) = 6 THEN '금요일'
		WHEN DAYOFWEEK(HIRE_DATE) = 7 THEN '토요일'
	END '입사 요일'
FROM EMPLOYEE;

-- LAST_DAY 함수
SELECT LAST_DAY(NOW());

-- CAST / CONVERT 함수
SELECT CAST('231011' AS DATE),
		CONVERT(20231011 , DATE),
		CAST(NOW() AS DATE)

SELECT CAST(202020201111 AS CHAR),
		CONVERT(2020201111, CHAR)
		-- 문자를 숫자로 형변환은??

-- ----------------------------------------------------------------------------
SELECT '123' + '456'; -- 문자와 문자를 합쳤는데 둘을 합쳐서 숫자타입으로 반환한다.
SELECT '123' + '456ABC'; -- 문자는 버리고 숫자만 합쳐서 숫자타입으로 반환한다.(에러는 무시)
SELECT '123'+'4AB5C6'; -- 문자 버리고 숫자만 합쳐서 숫자 타입으로 반환한다.(에러는 무시)

-- ------------------------------------------------------------------------------

-- 관계형 데이터베이스에서는 DBMS의 설정 정보들을 테이블 형태로 관리한다.
SHOW TABLES;
SELECT * FROM INFORMATION_SCHEMA.TABLES;

SET TIME_ZONE = 'ASIA/SEOUL';
SELECT NOW();
SELECT @@SESSION.TIME_ZONE;

-- [ORDER BY 절]
SELECT EMP_ID, EMP_NAME 이름, SALARY * 12 AS '기본 연봉', DEPT_CODE 부서코드
FROM EMPLOYEE
ORDER BY EMP_ID;
-- EMP_ID는 기본키기 때문에 원래부터 기본적으로 EMP_ID 기준으로 자동 정렬되어서 나왔다.

SELECT EMP_ID, EMP_NAME 이름, SALARY * 12 AS '기본 연봉', DEPT_CODE 부서코드
FROM EMPLOYEE
ORDER BY EMP_NAME;
-- EMP_NAME 기준으로 오름차순 정렬한다.
-- 오름차순은 기본 정렬 세팅이기 때문에 따로 명령어 입력할 필요 없다.

SELECT EMP_ID, EMP_NAME 이름, SALARY * 12 AS '기본 연봉', DEPT_CODE 부서코드
FROM EMPLOYEE
ORDER BY DEPT_CODE DESC;
-- DEPT_CODE 기준 내림차순 정렬한다.
-- 내림차순은 따로 DESC라는 명령어를 입력해야한다.

SELECT EMP_ID, EMP_NAME 이름, SALARY * 12 AS '기본 연봉', DEPT_CODE 부서코드
FROM EMPLOYEE
ORDER BY DEPT_CODE DESC, EMP_NAME;
-- DEPT_CODE 기준 내림차순 정렬 후,
-- DEPT_CODE가 동일한 것들 끼리 EMP_NAME 기준으로 오름차순 정렬한다.
-- 정렬 기준은 1개 이상 사용할 수 있다.

SELECT EMP_ID, EMP_NAME 이름, SALARY * 12 AS '기본 연봉', DEPT_CODE 부서코드
FROM EMPLOYEE
ORDER BY 3 DESC, 4;
-- SELECT 문의 3번째 컬럼을 기준으로 내림차순 정렬한다.
-- 컬럼 명이 너무 긴 경우가 있으면, 별칭을 쓰거나 이런 식으로 처리 가능하다.

SELECT EMP_ID, EMP_NAME 이름, SALARY * 12 AS '기본 연봉', DEPT_CODE 부서코드
FROM EMPLOYEE
ORDER BY '기본 연봉';
-- 별칭이 기본 연봉인 필드명(SALARY * 12) 기준 오름차순 정렬한다.
-- 컬럼 명이 너무 긴 경우가 있으면, 별칭을 써서 처리 가능하다.

-- [GROUP BY 절]
-- 사원 전체의 급여 평균
SELECT TRUNCATE(AVG(SALARY), -3)
FROM EMPLOYEE;

-- 부서 D1의 평균 급여
SELECT TRUNCATE(AVG(SALARY), -3)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- 각 부서별 평균 급여
SELECT DEPT_CODE, TRUNCATE(AVG(SALARY), -3)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;
-- EMPLOYEE 테이블을 가져와 DEPT_CODE 기준으로 소그룹을 묶은 뒤에,
-- DEPT_CODE와 TRUNCATE(AVG(SALARY),-3)한 값들을 SELECT해
-- DEPT_CODE 기준으로 오름차순 정렬한다.

-- [HAVING 구문]
-- 부서별 급여 평균이 300만원 이상인 부서만 조회한다.
SELECT DEPT_CODE, TRUNCATE(AVG(SALARY), -3)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 3000000;
-- WHERE 절 쓰면 뭔가 결과는 나오지만, 제대로 된 결과는 나오지 않는다.
-- SELECT 문 실행 구조 상 WHERE 절의 조건이 GROUP BY보다 먼저 실행되기 때문에 결과가 이상해진다.
-- 즉, WHERE SALARY > 3000000하면 300만원 이상 받는 사람만 남고,
-- 이를 갖고 소그룹들 만들어 평균 구하니 결과가 이상해진다.
-- (각 그룹에 300만원 이하 받는 사람들 포함이 안된 평균 결과가 나온다.)
-- HAVING 쓰면 GROUP BY 이후에 실행되기 때문에 정확히 원하는 조건대로 결과를 받을 수 있다.

-- GROUP BY 여러개 컬럼
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE 
ORDER BY 1,2;
-- DEPT_CODE로 한번 묶고, 그 안에서 JOB_CODE 별로 다시 묶어 각 급여 합계를 조회한다. 
-- DEPT_CODE라는 소그룹 안에, JOB_CODE라는 소그룹으로 묶는다.

-- [SET OPERATOR]
-- UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE E
WHERE DEPT_CODE = 'D5'
UNION -- 중복은 한번만 출력하고, 두 개 이상의 SELECT 문을 합친다.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE E
WHERE SALARY > 3000000;
-- UNION 할 경우, UNION 앞에 있는 SELECT 문에는 ;를 쓰면 안된다.
-- UNION 할 SELECT 문들은 SELECT할 컬럼의 개수가 맞아야 한다.

-- 예를 들어,
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE E
WHERE DEPT_CODE = 'D5'
UNION -- 중복은 한번만 출력하고, 두 개 이상의 SELECT 문을 합친다.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE E
WHERE SALARY > 3000000;
-- 하면 컬럼의 개수가 다르다고 하는 에러나 발생한다.

-- 그리고 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, EMP_NO
FROM EMPLOYEE E
WHERE DEPT_CODE = 'D5'
UNION -- 중복은 한번만 출력하고, 두 개 이상의 SELECT 문을 합친다.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE E
WHERE SALARY > 3000000;
-- 하면 컬럼의 개수는 맞기 때문에 합치기는 하나
-- EMP_NO와 SALARY가 다 다르기 때문에 각각으로 하나씩 나온다.

-- UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE E
WHERE DEPT_CODE = 'D5'
UNION ALL-- 중복은 모두 출력하고, 두 개 이상의 SELECT 문을 합친다.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE E
WHERE SALARY > 3000000;
-- UNION ALL 할 경우, UNION 앞에 있는 SELECT 문에는 ;를 쓰면 안된다.
-- UNION ALL 할 SELECT 문들은 SELECT할 컬럼의 개수가 맞아야 한다.

-- JOIN
-- 두 테이블에서 공통 컬럼의 이름이 다른 경우
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
-- DEPT_TITLE은 DEPARTMENT 테이블에 있는 컬럼
FROM EMPLOYEE 
JOIN DEPARTMENT ON (EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID)
-- 또는
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- EMPLOYEE 테이블을 가져와서,
-- ()안에 있는 컬럼을 공통 컬럼으로 활용해 DEPARTMENT 테이블을 EMPLOYEE 테이블 옆에 붙이고
-- SELECT를 실행한다.

-- 두 테이블에서 공통 컬럼의 이름이 같을 경우
-- 1. ON ()
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB ON(EMPLOYEE.JOB_CODE = JOB.JOB_CODE);
-- ON의 () 안에 테이블의 컬럼인지 명확하게 인식시켜줘야한다.
-- 그리고 SELECT문에 공통컬럼이 쓰인다면, SELECT문에도 어떤 테이블의 컬럼인지 명시해야한다.
-- 해당 구문에 SELECT * 하면 각 테이블의 JOB_CODE가 따로 나온다.

-- 2. USING()
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);
-- USING을 사용하면, ()안에 어떤 테이블의 컬럼인지 명시할 필요 없다.
-- 단순히 ()안에 공통 컬럼명만 쓰면 된다.

-- INNER JOIN
SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
INNER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- DEPT_CODE에 NULL 값이 사라진 상태로 조회된다.
-- DEPT_ID에는 따로 NULL 값에 대한 내용이 없기 때문이다.
-- (기본키라 NULL값이 있으면 안되기도 하고)

-- OUTER JOIN
-- LEFT
SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- INNER JOIN 때 갖고 오지 않았던 데이터 2개를 가져와,
-- 두번째 테이블 SELECT 컬럼인 DEPT_TITLE에는 NULL 값을 넣는다.
-- (첫번째 테이블의 갖고 오지 않았던 데이터의 DEPT_CODE는 원래 NULL 값이었다.)

-- RIGHT
SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- INNER JOIN 때 갖고 오지 않았던 데이터 2개를 가져와,
-- 첫번째 테이블 SELECT 컬럼인 EMP_NAME, DEPT_CODE에는 NULL 값을 넣는다.
-- 두번째 테이블 SELECT 컬럼인 DEPT_TITLE은 원래 갖고 있던 값 그대로 나온다.

-- SELF JOIN
-- 직원 정보와 직원 담당 매니저 정보를 조회한다.
SELECT E.EMP_ID "사번", E.EMP_NAME "이름" , E.MANAGER_ID "관리자 사번" , E2.EMP_NAME "관리자명"
FROM EMPLOYEE E -- E는 테이블을 지칭하는 별칭
JOIN EMPLOYEE E2 ON (E.MANAGER_ID = E2.EMP_ID); -- E2는 테이블을 지칭하는 별칭
-- 자기 자신을 JOIN하다보니 컬럼명이 동일하므로, 테이블을 명확하게 구분해줘야한다.
-- INNER JOIN이기 때문에 MANAGER_ID에 없는 EMP_ID의 값들은
-- 조건에 일치하지 않으므로 가져오지 않는다.

-- 다중 JOIN
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME 
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION L ON (LOCATION_ID = LOCAL_CODE);
-- EMPLOYEE 테이블에 DEPARTMENT 테이블을 조건에 맞춰 조인하고,
-- 그 결과 테이블에 LOCATION 테이블을 조건에 맞춰 조인한 뒤,
-- 원하는 컬럼들을 SELECT 한다.
-- 일단 INNER JOIN이기 때문에 조건에 안맞는 값들은 아예 안 갖고 온다.

-- [SUB QUERY]
-- 단일 행 서브쿼리
-- 최소 급여를 받는 사원의 정보를 조회한다.
-- 기존 작성 방식
-- 1) 최소 급여 확인
SELECT MIN(SALARY) FROM EMPLOYEE E ;
-- 2) 최소 급여 받는 사원 정보 조회
SELECT * FROM EMPLOYEE E WHERE SALARY = 1380000;

-- 단일 행 서브쿼리 활용
SELECT * 
FROM EMPLOYEE E 
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);
-- 최소 급여 값이라는 1개의 결과 값을 준다.

-- 다중 행 서브쿼리
-- 각 직급별 최소 급여를 받는 사원의 정보를 조회한다. 
SELECT *
FROM EMPLOYEE E 
WHERE SALARY IN (SELECT MIN(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE);
-- 각 직급별 최소 급여 값이라는 여러 개의 결과 값을 준다.
-- 결과 값이 여러개이므로 = 는 사용 불가하다.

-- 다중 행 다중 열 서브쿼리
-- 여러 컬럼과 여러 로우를 가지는 서브쿼리를 사용해 결과를 조회한다.
SELECT *
FROM EMPLOYEE E 
WHERE SALARY IN (SELECT JOB_CODE, MIN(SALARY)
				 FROM EMPLOYEE E2 
				 GROUP BY JOB_CODE);
-- WHERE 절 안에 컬럼과 로우의 개수가 맞지 않기 때문에 에러 난다.

SELECT *
FROM EMPLOYEE E 
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
				 			FROM EMPLOYEE E2 
				 			GROUP BY JOB_CODE)
-- 컬럼과 로우의 개수를 맞추면 정상적으로 실행된다.
-- 다중 행 다중 열

-- 다중 행 다중 열 서브쿼리와 일반 단일 행 서브쿼리의 차이
-- 퇴사한 여직원과 같은 직급, 같은 부서에 근무하는 직원들의 정보를 조회한다.
-- 1) 단일 행
SELECT *
FROM EMPLOYEE E 
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE E2 WHERE ENT_YN = 'Y')
	AND JOB_CODE =  (SELECT JOB_CODE FROM EMPLOYEE E3 WHERE ENT_YN = 'Y');

-- 2) 다중 열
SELECT * 
FROM EMPLOYEE E 
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_C
ODE, JOB_CODE FROM EMPLOYEE E2 WHERE ENT_YN = 'Y');

-- FROM 문에서 서브 쿼리(INLINE VIEW)
SELECT *
FROM(
	SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_TITLE, JOB_NAME
	FROM EMPLOYEE
	JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
	JOIN JOB USING (JOB_CODE)
	) A;




