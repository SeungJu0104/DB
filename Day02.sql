/* [DB에서 실행하는 명령 종류]
 * CRUD : 데이터 기본 사항 처리 로직
 * 1. CREATE : 데이터 추가 (INSERT)
 * 2. READ : 데이터 조회 (SELECT)
 * 3. UPDATE : 데이터 수정 (UPDATE)
 * 4. DELETE : 데이터 삭제 (DELETE)
 * 
 * [연산자]
 * 1. 비교 연산자
 * < , > , <= , >= , = , != , <> : 부등호 연산자
 * (!= , <> : '같지 않다'는 의미)
 * 
 * 2. 비교 명령어
 * BETWEEN A AND B : >= A AND <= B
 * NOT BETWEEN A AND B : < A AND > B
 * 
 * 3. LIKE : 입력한 숫자 또는 문자가 포함된 정보를 조회할 때 사용하는 연산자
 * (자바의 contains() 와 유사한 기능)
 * '_' : 임의의 아무 한 문자
 * '%' : 앞 뒤 전체 아무 문자
 * ESCAPE 문자를 선언해 그 뒤에 오는 문자를 특수문자가 아닌 일반문자로 선언해 사용할 수 있다.
 * WHERE EMAIL LIKE '___#_%@%' ESCAPE '#';
 * (ESCAPE 뒤에 ESCAPE로 쓸 문자를 선언한다. 여기서는 #을 사용했고, 다른 것도 상관 없다.)
 * 
 * 4. IN () : () 안에 있는 값 중 하나라도 일치하면 해당 일치하는 값을 조회하는 연산자
 * IN(값1, 값2, 값3, ...)
 * 
 * NOT IN () : ()안에 있는 값 중 하나라도 일치하면 해당 일치하는 값 이외의 값을 조회하는 연산자
 * NOT IN (값1, 값2, 값3, ...)
 * 
 * [함수]
 * 단일 행 함수 : 결과를 찾아 출력할 때마다 (각 행에) 함수가 적용
 * 1. 문자 관련 함수
 * (각 열(ROW) 개별로 연산한다. 단일 행 함수)
 * 
 * 1) LENGTH : BYTE 길이를 계산하는 함수
 * (단, 영어는 정상적으로 길이가 나오나 한글은 실 글자수보다 크게 나온다.)
 * (왜냐하면, 영어는 1바이트, 한글은 3바이트이기 때문이다.)
 * 
 * 2) CHAR_LENGTH : 글자 수를 계산하는 함수
 * (영어, 한글 모두 동일하게 나온다.)
 * 
 * 3) INSTR () : 주어진 값에서 원하는 문자가 몇번째인지 찾아 반환하는 함수
 * INSTR(값 또는 필드명, '원하는 문자')
 * 원하는 문자가 값에 없는 경우, 0을 반환한다.
 * 
 * 4) SUBSTR () : 주어진 문자열에서 특정 부분만 가져오는 함수
 * SUBSTR(값 또는 필드명, 시작 위치[, 가져올 개수])
 * [] 부분은 생략 가능 (그러면 시작 위치부터 끝까지 문자열을 갖고 온다.)
 * 값 또는 필드명의 시작 위치부터 종료 위치까지 문자열을 갖고 온다.
 * 
 * 5) LPAD 또는 RPAD () : 빈칸을 지정한 문자로 채우는 함수
 * LPAD는 왼쪽에 빈칸을 지정한 문자로 채우고, RPAD는 오른쪽을 지정한 문자로 채운다.
 * LPAD 또는 RPAD (값 또는 필드명, 크기, 빈칸 채울 문자)
 * 
 * 6) LTRIM 또는 RTRIM () : 현재 부여된 컬럼이나, 값으로 부터 공백만 찾아 지워주는 함수
 * LTRIM 또는 RTRIM (값 또는 필드명)
 * LTRIM은 왼쪽의 공백만 지워주고, RTRIM은 오른쪽의 공백만 지워준다.
 * LTRIM, RTRIM 모두 가운데 공백은 지워주지 않는다.
 * 즉, 왼쪽 또는 오른쪽에서 공백을 지워가다 공백이 아닌 문자를 만나면 함수가 종료된다.
 * 
 * 7) TRIM () : 주어진 컬럼이나 값에서 양 끝을 기준으로 특정 문자를 지워주는 함수
 * TRIM (값 또는 필드명) ==> 공백을 지워주는 기본 형태
 * TRIM (지우고자 하는 값 FROM 값 또는 필드명) ==> 특정 값을 양 끝을 기준으로 지워주는 형태
 * 
 * 8) LOWER 또는 UPPER () : 주어진 문자를 소문자 또는 대문자로 변경해주는 함수
 * 
 * 9) CONCAT () : 여러 문자열을 하나의 문자열로 합치는 함수
 * CONCAT(값 또는 필드명, 값 또는 필드명, ....)
 * 
 * 10) REPLACE () : 주어진 문자열에서 특정 문자를 변경해주는 함수
 * REPLACE (값 또는 필드명, 변경 대상 특정 문자, 특정 문자를 대체할 문자)
 * 
 * 2. 다중 행 함수(Multiple Row Function)
 * : 조건절을 만족하는 모든 행을 다 찾고나서, 모든 열(row)을 한번에 연산한다.
 * : 여러 매개변수를 가지지만, 결과 값은 1개만 나온다.
 * 
 * 그룹 함수 (Group Function)
 * SUM(), AVG(), MAX(), MIN(), COUNT()
 * 
 * SUM(숫자가 기록된 컬럼 또는 숫자 값) : 해당 컬럼들의 합계 함수
 * AVG(숫자가 기록된 컬럼 또는 숫자 값) : 해당 컬럼들의 평균 함수
 * MAX(숫자가 기록된 컬럼 또는 숫자 값) : 해당 컬럼들의 값들 중 최대값 함수
 * MIN(숫자가 기록된 컬럼 또는 숫자 값) : 해당 컬럼들의 값들 중 최소값 함수
 * COUNT(컬럼명 또는 *) : 해당 컬럼들의 개수세는 함수
 * 단, NULL값은 COUNT 함수에서 개수를 세지 않는다.
 * (NULL 값을 제외하고 개수를 센다.)
 * 
 * 3. 날짜 처리 함수
 * (단일 행 함수)
 * 
 * 1) SYSDATE() 또는 NOW() : 현재 컴퓨터의 날짜를 반환하는 함수
 * NOW()는 쿼리를 실행하는 시점, SYSDATE()는 함수가 실행되는 시점의 시간을 갖고 온다.
 * (날짜는 둘 다 동일하다.)
 * 
 * 2) DATEDIFF() : 단순하게 날짜 차이를 갖고오는 함수
 * DATEDIFF(날짜1, 날짜2)
 * 
 * 3) TIMESTAMPDIFF : 연, 분기, 월 주, 일 시, 분 초를 지정하여 차이를 갖고 오는 함수
 * TIMESTAMPDIFF(지정 기준, 날짜1, 날짜2)
 * 
 * YEAR : 연
 * QUARTER : 분기
 * MONTH : 월
 * WEEK : 주
 * DAY : 일
 * HOUR : 시
 * MINUTE : 분
 * SECOND : 초
 * 
 * EX. SELECT TIMESTAMPDIFF(MONTH, HIRE_DATE, NOW()) FROM EMPLOYEE;
 * 
 * 4) EXTRACT(YEAR 또는 MONTH 또는 DAY FROM 날짜)
 * (단일 행 함수)
 * : 지정 날짜로부터 원하는 일 / 월 / 년 을 추출하는 함수
 * 
 * 5) DATE_FORMAT()
 * (단일 행 함수)
 * : 날짜 정보를 원하는 형식으로 변경해주는 함수
 * DATE_FORMAT(날짜, 원하는 형식)
 * 
 * 6) STR_TO_DATE()
 * (단일 행 함수)
 * : 문자 타입을 날짜 타입으로 변경해주는 함수
 * STR_TO_DATE(문자, 날짜 형식)
 * 단, 문자형식과 날짜형식이 동일해야 변경 가능하다.
 * EX. SELECT STR_TO_DATE('20230110', '%Y%m%d'),
	   		  STR_TO_DATE('231110', '%y%m%d'),
	   		  STR_TO_DATE('23-10-10', '%y-%m-%d'),
	   		  STR_TO_DATE('23/09/10', '%y/%m/%d');
	   		  /를 쓰면 날짜 형식에도 /를 붙여주고, -를 쓰면 날짜 형식에도 -를 써야한다.
 * 날짜형식을 작성할 때 대문자 Y 쓰면 4자리 연도로 나온다.
 * 
 * 4. IF ()
 * (단일 행 함수)
 * : 조건에 AND, OR 등을 통해서 여러 조건을 사용할 수 있다.
 * IF(조건식, 참일 때 값, 거짓일 때 값)
 * (자바의 삼항연산자와 유사한 형태를 갖고 있다.)
 * WHERE 절의 조건은 SELECT되는 열의 개수를 조절하고,
 * IF문은 SELECT되는 결과 값을 참, 거짓에 따라 정한다.
 * (두 조건은 매우 다르다.)
 * (IF문은 SELECT에 직접 거는 조건?)
 * 
 * 5. CASE ()
 * : 자바의 IF, SWITCH처럼 표현 가능한 함수
 * : 다양하게 값을 표현할 필요가 있는 경우 주로 사용한다.
 * 
 * CASE 컬럼명
 * 	WHEN(조건식1) THEN 결과값1
 * 	WHEN(조건식2) THEN 결과값2
 * 	.
 * 	.
 *  ELSE 마지막 결과 값
 * END
 * 
 * CASE
 * 	WHEN(컬럼명 = 조건식1) THEN 결과값1
 * 	WHEN(컬럼명 = 조건식2) THEN 결과값2
 * 	.
 * 	.
 *  ELSE 마지막 결과 값
 * END
 * 
 * 6. IS NULL
 * (단일 행 함수)
 * : 널 값인지 확인하는 함수
 * 필드명 또는 값 IS NULL
 * 
 * 널 값이 아닌지 확인하는 것은 IS NOT NULL
 * 
 * 7. 숫자 함수
 * (단일 행 함수)
 * 1) MOD ()
 * : 주어진 컬럼이나 값을 나눈 나머지를 반환하는 함수
 * (나머지 값을 정수로 반환한다.)
 * MOD (주어진 컬럼 또는 값, 나눌 값 또는 컬럼)
 * 
 * 2) ROUND ()
 * : 지정한 숫자를 반올림할 때 사용하는 함수
 * ROUND (실수 또는 필드명, 반올림을 할 자리수)
 * (반올림할 자리수에 생략하면 소수 첫째자리 반올림)
 * (반올림할 자리수에 음수 넣으면, 정수의 해당 숫자 자리 반올림)
 * EX. ROUND(123.456, 1) ==> 123.5 ==> 소수 둘째자리 반올림
 * 	   ROUND(123.456, -2) ==> 100 ==> 정수 둘째자리 반올림
 * 
 * 3) CEIL () : 소수점 첫째자리에서 올림하는 함수
 * 
 * 4) FLOOR () : 소수점 이하 자리의 숫자를 버리는 함수
 * 
 * 5) TRUNCATE () : 지정 위치까지 숫자를 버리는 함수
 * TRUNCATE (숫자, 지정 위치)
 * (지정 위치 다음 자리부터 버린다.)
 * (지정 위치가 음수면, 정수의 해당 자리수 부터 버린다.)
 * 
 * 6) CEILING () : 소수점 반올림
 * 정의로는 반올림이지만, 실상은 올림시킨다.
 * 음수여도 똑같이 실상은 올림시킨다.
 */

SELECT * FROM EMPLOYEE;
-- 부서코드가 'D9'가 아닌 직원들의 모든 정보 조회한다. (!= 또는 <> 사용한다.)
SELECT * 
FROM EMPLOYEE 
WHERE DEPT_CODE != 'D9';
-- 또는 DEPT_CODE <> 'D9';

-- 급여가 350만원 이상 550만원 이하인 직원의 사번, 사원명, 부서코드, 직급코드, 급여정보를 조회한다.
-- 1. 부등호 연산자
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_CODE 부서코드, JOB_CODE 직급코드, SALARY 급여정보
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 5500000;

-- 2. BETWEEN A AND B 명령어
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_CODE 부서코드, JOB_CODE 직급코드, SALARY 급여정보
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 5500000;

-- 급여가 350만원 미만, 550만원 초과인 직원의 사번, 사원명, 부서코드, 직급코드, 급여정보를 조회한다.
-- 1. 부등호 연산자
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_CODE 부서코드, JOB_CODE 직급코드, SALARY 급여정보
FROM EMPLOYEE
WHERE SALARY < 3500000 OR SALARY > 5500000;

-- 2. NOT BETWEEN A AND B
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_CODE 부서코드, JOB_CODE 직급코드, SALARY 급여정보
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 5500000;

-- 사원명 가운데에 '중'이 들어간 사원 정보 조회한다.
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_중_';
-- (앞, 뒤의 각 한글자는 아무거나 들어가도 상관없고, 가운데만 '중'이면 된다.)

-- 주민번호를 기준으로 여성인 사원의 정보 조회한다.
-- 1. LIKE '_'
SELECT *
FROM EMPLOYEE
WHERE EMP_NO LIKE '_______2______';
-- (아니면 WHERE EMP_NO LIKE '______-2______';)

-- 2. LIKE '%'
SELECT *
FROM EMPLOYEE
WHERE EMP_NO LIKE '%-2%';
-- (-뒤에 2가 붙은 것만 찾는다.)

SELECT *
FROM EMPLOYEE
WHERE EMP_NO LIKE '%2%';
-- (중간에 2가 들어간 모든 것을 찾는다.)

-- 사원 중에 이메일 4번째 자리가 '_'인 사원 정보를 조회한다.
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%@%' ESCAPE '#';
-- (ESCAPE 문자로 #을 사용했다.)

SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '___^_%@%' ESCAPE '^';
-- (ESCAPE 문자로 ^을 사용했다.)

-- 부서코드가 D1 이거나 D6인 부서 직원을 조회한다.
-- 1. OR
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1' OR DEPT_CODE = 'D6';

-- 2. IN () 연산자
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IN('D1', 'D6');

-- D1 도 D6도 아닌 부서의 직원 정보를 조회한다.
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN('D1', 'D6');
-- (D1 이나 D6가 아닌 정보만 조회한다.)

-- LENGTH, CHAR_LENGTH 함수
SELECT LENGTH('hello'), CHAR_LENGTH('hello'); 
-- (FROM, WHERE 절 생략 가능)
-- (어떠한 테이블에서 가져오는 것이 아니기 때문에 FROM 생략할 수 있다.)
-- (FROM 써도 상관은 없다.)
-- (예를 들어, FROM EMPLOYEE를 하면 EMPLOYEE 테이블의 ROW 개수만큼 LENGTH와 CHAR_LENGTH 함수가 실행된다.)

SELECT LENGTH('이창진'), CHAR_LENGTH('이창진');
-- (LENGTH는 9를, CHAR_LENGTH는 3을 출력한다.)
-- (왜냐하면 한글은 3바이트이기 때문에 바이트 단위로 계산하는 LENGTH는 9가 나오는 것이다.)

-- INSTR 함수
SELECT INSTR('ABCDE', 'A'),
	   INSTR('ABCDE', 'B'),
	   INSTR('ABCDE', 'F');
-- (원하는 문자가 값에 없는 경우, 0을 반환한다.);
	  
SELECT EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;

-- SUBSTR 함수
SELECT 'HELLO WORLD', SUBSTR('HELLO WORLD', 1, 5);
-- (HELLO WORLD라는 값의 첫번째 자리부터 5개의 문자열을 갖고 오겠다.)

SELECT 'HELLO WORLD', SUBSTR('HELLO WORLD', 7);
-- (HELLO WORLD라는 값의 7번째 자리부터 값의 끝까지 문자열을 갖고 오겠다.)

-- LPAD / RPAD 함수
SELECT LPAD(EMAIL, 20, "#")
FROM EMPLOYEE;
-- (20칸 중에서 EMAIL 값을 넣고, 남은 공간의 왼쪽부터 #을 채워넣는다.)

SELECT RPAD(EMAIL, 20, "#")
FROM EMPLOYEE;
-- (20칸 중에서 EMAIL 값을 넣고, 남은 공간의 오른쪽부터 #을 채워넣는다.)

-- LTRIM / RTRIM 함수
SELECT LTRIM ('      HELLO');
-- (왼쪽 공백을 지워준다.)
SELECT LTRIM ('      HE LLO  ');
-- (왼쪽 공백만 지우고 가운데, 오른쪽의 공백은 남겨둔다.)

SELECT RTRIM ('HELLO      ');
-- (오른쪽 공백을 지워준다.)
SELECT RTRIM ('   HE LLO      ');
-- (오른쪽 공백만 지우고 가운데, 왼쪽 공백은 남겨둔다.)

-- TRIM 함수
SELECT TRIM('   HELLO   ');
-- (TRIM 함수의 기본형태로 공백만 삭제 한다.)

SELECT TRIM('0' FROM '000HELLO0000');
-- (양 끝의 특정 값인 0을 삭제한다.)

-- LOWER / UPPER 함수
SELECT LOWER('AbCd'), UPPER('AbCd');
-- (LOWER는 대문자인 문자를 소문자로 바꾸어줬고, UPPER는 소문자인 문자를 대문자로 바꿔줬다.)

-- CONCAT 함수
SELECT CONCAT('MYSQL', '실습 중입니다 :)');

SELECT CONCAT(EMP_NAME, '님')
FROM EMPLOYEE;

SELECT CONCAT(RPAD(SUBSTR(EMP_NAME,1,1),3,'*'),'님')
FROM EMPLOYEE;
-- (SUBSTR로 이름의 맨 첫글자만 가져와서 RPAD로 총 3자리 크기 만든 후 첫자리만 이름 첫글자를 쓰고 나머지는 공백으로 둔다.
-- 공백된 나머지 2자리는 *로 처리한 뒤에 CONACAT으로 합친다.)

-- REPLACE 함수
SELECT REPLACE('HELLO WORLD', 'HELLO', 'BYE');

-- SUM 함수
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- AVG 함수
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- MAX, MIN 함수
SELECT MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE;

/* '해외영업1부'에 근무하는 모든 사원의
 * 평균 급여, 최대 급여, 최저 급여, 급여 합계 조회
 */
SELECT * FROM DEPARTMENT;

SELECT AVG(SALARY) AS '평균 급여', MAX(SALARY) AS '최대 급여', MIN(SALARY) AS '최저 급여', SUM(SALARY) AS '급여 합계'
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE = '해외영업1부');
-- (DEPT_CODE가 D5인 행들을 모두 찾고 나서, 각 열별로 평균, 최대, 최소, 합계 연산을 수행한다.)

SELECT MAX(SALARY), EMP_NAME
FROM EMPLOYEE;
-- (에러 발생. 왜냐하면 EMP_NAME은 EMPLOYEE의 이름 전체를 갖고 오지만 MAX는 최대값 하나만 가져오므로
-- 결과 값의 개수가 맞지 않는다.)

-- COUNT 함수
SELECT COUNT(*)
FROM EMPLOYEE;
-- (EMPLOYEE의 전체 행 개수를 세준다.)

SELECT COUNT(EMP_NO)
FROM EMPLOYEE;
-- (EMP_NO의 행 개수를 세준다.)

SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;
-- (NULL 값은 개수를 세지 않는다.)

SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;
-- (중복을 제외한 DEPT_CODE의 행 개수를 세준다.)
-- (NULL 값은 개수를 세지 않는다.)

-- SYSDATE 함수
SELECT SYSDATE();
-- (DOCKER에 설정된 시간대가 실제 시각과 다르기 때문에 다른 시간이 나온다.)

-- NOW 함수
SELECT NOW();
-- (DOCKER에 설정된 시간대가 실제 시각과 다르기 때문에 다른 시간이 나온다.)

-- DATEDIFF 함수
SELECT HIRE_DATE '입사일',
	   DATEDIFF(NOW(), HIRE_DATE) '입사 후 일 수'
FROM EMPLOYEE;
-- (입사 일로부터 현재까지 일 수)

-- TIMESTAMPDIFF 함수
SELECT HIRE_DATE '입사일',
	   TIMESTAMPDIFF(YEAR, HIRE_DATE, NOW()) '입사 후 년 수'
FROM EMPLOYEE;
-- (입사 일로부터 현재까지 년 수)

-- EXTRACT 함수
SELECT EXTRACT(YEAR FROM HIRE_DATE),
	   EXTRACT(MONTH FROM HIRE_DATE),
	   EXTRACT(DAY FROM HIRE_DATE)
FROM EMPLOYEE;
-- (입사일에서 연도, 월, 일만 추출해 보여준다.)

-- DATE_FORMAT 함수
SELECT HIRE_DATE,
	   DATE_FORMAT(HIRE_DATE,'%Y%m%d%h%i%s'),
	   DATE_FORMAT(HIRE_DATE, '%Y/%m/%d %H:%i:%s'),
	   DATE_FORMAT(NOW(), '%y/%m/%d %H:%i:%s')
FROM EMPLOYEE;
-- (날짜 데이터인 입사일을 연월일시분초 형태의 문자열로 바꿔준다.)

-- STR_TO_DATE 함수
SELECT STR_TO_DATE('20230110', '%Y%m%d'),
	   STR_TO_DATE('231110', '%y%m%d'),
	   STR_TO_DATE('23-10-10', '%y-%m-%d'),
	   STR_TO_DATE('23/09/10', '%y/%m/%d');
-- (문자 형식과 날짜 형식이 동일해야한다.)

-- IF 함수
-- 현재 근무하는 직원들의 성별을 남, 여로 구분해 출력한다.
SELECT EMP_NAME, EMP_NO, IF(SUBSTR(EMP_NO, 8, 1) = '1', "남", "여") 성별
FROM EMPLOYEE
ORDER BY 성별 ASC;
-- WHERE 절의 조건은 SELECT되는 열의 개수를 조절하는 것이고,
-- IF문의 조건은 SELECT될 결과값을 참, 거짓에 따라 정할 수 있다.
-- (두 조건은 매우 다르다.)
-- (IF문은 SELECT에 직접 거는 조건?)

-- MOD 함수
SELECT MOD(10,3),
	   MOD(10,2),
	   MOD(10,7);
	  -- (나머지 값을 정수로 반환한다.)

-- ROUND 함수
SELECT ROUND(123.456),
	   ROUND(123.456,0),
	   ROUND(123.456,1), -- 소수 둘째자리 반올림
	   ROUND(123.456,2), -- 소수 셋째자리 반올림
	   ROUND(123.456,-2); -- 정수 둘째자리 반올림

-- CEIL 함수, FLOOR 함수
SELECT CEIL(123.456), FLOOR(123.456);

-- TRUNCATE 함수
SELECT TRUNCATE(123.456, 0),
	   TRUNCATE(123.456,1),
	   TRUNCATE(123.456,2),
	   TRUNCATE(123.456,-2);
-- CEILING 함수
SELECT CEILING(4.0), CEILING(4.1), CEILING(4.14), CEILING(4.15), CEILING(3.9);
SELECT CEILING(-4.0), CEILING(-4.1), CEILING(-4.14), CEILING(-4.6), CEILING(-3.9);



