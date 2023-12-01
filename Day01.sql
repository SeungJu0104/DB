-- --하고 띄어쓰기까지 한칸해야 주석 (자바의 //와 같은 역할)
-- 실행은 실행하려는 명령어로 커서를 이동시키고 컨트롤과 엔터키 또는 알트키와 X키 같이 누르기.
-- 알트 X 키는 전체 SQL문을 위부터 하나씩 실행하고,
-- 컨트롤 엔터 키는 해당 커서가 있는 SQL문만 실행한다.
-- 디비버는 우리가 작성한 SQL문을 MYSQL에 넘겨주고, 실 연산은 MYSQL이 한다.
-- MYSQL이 연산한 결과(RESULTSET)를 디비버가 가져와 보여준다.

SHOW TABLES;

-- 테이블 생성
CREATE TABLE STUDENTS(
	ID INT,
	NAME VARCHAR(100),
	PHONE CHAR(13),
	ADDRESS VARCHAR(1000)
);

SHOW TABLES;

SELECT * FROM EMPLOYEE;

-- 한줄 주석
/*여러 줄 주석*/
-- ;는 문장의 끝(자바와 동일)
-- 자바와 다르게 위에서 아래로 순차적으로 실행하는 것이 아니라
-- 커서가 위치한 문장만 실행한다.
-- DB에서는 문자와 문자열 구분이 없다. '' "" 모두 문자를 의미한다.
-- 실행은 실행하려는 명령어로 커서를 이동시키고 컨트롤과 엔터키 또는 알트키와 X키 같이 누르기.
-- DB는 대문자를 보통 사용한다.

-- SELECT 문 --
/* [SELECT 문]
 * 데이터 조회 위한 SQL문 (DML)
 * 
 * SELECT 컬럼, 컬럼,...  ==> 조회하고자 하는 내용
 * FROM 테이블명 ==> 조회하고자 하는 테이블명
 * WHERE 또는 HAVING 조건 ==> 조회할 내용의 조건
 * ORDERBY 또는 GROUPBY 컬럼 ==> 정렬
 * WHERE, HAVING, GROUPBY, ORDERBY 는 보통 생략 가능하다.
 * 단, GROUPBY를 사용하면 조건을 걸 때는 반드시 HAVING만 쓸 수 있다.
 * (WHERE 사용 불가능)
 * WHERE절의 조건은 SELECT되는 열의 개수를 조절한다.
 * 단, IF문은 SELECT될 값을 참, 거짓에 따라 정할 수 있다.
 * (두 조건은 매우 다르다.)
 * (IF문은 SELECT에 직접 거는 조건?)
 * 
 * 단, 가져올 별도의 테이블 없을 때, SELECT를 이용해 함수만 실행할 경우는 FROM도 생략 가능.
 * 예를 들어, SELECT LENGTH('hello'), CHAR_LENGTH('hello'); 를 한다면
 * 어떠한 테이블에서 가져오는 것이 아니기 때문에 FROM 생략할 수 있다.
 * 굳이 FROM을 써도 상관은 없다.
 * 예를 들어, SELECT LENGTH('hello'), CHAR_LENGTH('hello') FROM EMPLOYEE를 하면
 * EMPLOYEE 테이블의 ROW 개수만큼 LENGTH와 CHAR_LENGTH 함수가 실행된다.
 * 
 * 컬럼을 이용해 연산 가능하다.
 * 
 * 모든 컬럼: *
 */

-- EMPLOYEE 테이블의 모든 행과 모든 컬럼을 조회

SELECT * -- 모든 컬럼
FROM EMPLOYEE;

-- 모든 사원(EMPLOYEE)의 아이디(EMP_ID)와 사원명(EMP_NAME), 연락처(PHONE)만 조회

SELECT EMP_ID, EMP_NAME, PHONE -- 아이디, 사원명, 연락처 컬럼만 조회한다.
FROM EMPLOYEE; -- 사원 테이블로부터

-- WHERE 구문(절)
/* 테이블에서 조건을 만족하는 값을 가진 행을 선택해 조회하는 조건절
 * 조건에 만족하지 않는 값을 가진 행은 갖고 오지 않는다.
 * 
 * 조건은 여러개 설정 가능하다.
 * 중첩 조건도 가능하다.
 * (AND, OR 등 명령어를 사용한다.)(자바에서는 &&, || 로 표현했다.)
 * DB에서 = 는 같다를 의미한다. (자바에서는 대입의 의미였다.)
 * 
 */

-- 부서코드(DEPT_CODE)가 'D6'인 사원들의 정보를 모두 조회하기

SELECT * -- 모든 컬럼 조회한다.
FROM EMPLOYEE -- 사원 테이블로부터
WHERE DEPT_CODE = 'D6'; -- 부서코드가 D6인 사원들만
-- DB에서 = 는 같다를 의미한다. (자바에서는 대입의 의미였다.)

/* 실습 1
 * 직급코드(JOB_CODE)가 'J1'인 사원(EMPLOYEE)의
 * 사번(EMP_ID), 사원명(EMP_NAME), 직급코드(JOB_CODE), 부서코드(DEPT_CODE)를 조회한다.
 */

SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_CODE -- 사번, 사원명, 직급코드, 부서코드를 조회한다.
FROM EMPLOYEE -- 사원의
WHERE JOB_CODE = 'J1'; -- 직급코드가 J1인

-- '' "" 모두 문자를 의미한다.

/* 실습 2
 * 급여(SALARY)가 300만원 이상인 사원(EMPLOYEE)의 
 * 아이디(EMP_ID), 사원명(EMP_NAME), 직급코드(JOB_CODE), 급여 정보(SALARY)를 조회한다.
 */

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY -- 아이디, 사원명, 직급코드, 급여정보를 조회한다.
FROM EMPLOYEE -- 사원의
WHERE SALARY >= 3000000; -- 연봉이 300만원 이상인

/* 실습 3
 * 부서코드가 'D6'이면서, 이름이 '유재식'인 사원의 모든 정보를 조회한다.
 */

SELECT * -- 모든 정보를 조회한다.
FROM EMPLOYEE -- 사원의
WHERE (DEPT_CODE = 'D6') AND (EMP_NAME = '유재식'); -- 부서코드가 D6이면서, 이름이 유재식인

/* 컬럼 명에 별칭(별명) 달기
 * 1. AS로 표현 : 컬럼명 옆에 AS를 붙이고, 그 옆에 별칭을 작성한다.
 * 2. AS를 생략하고 표현 : 컬럼명 옆에 한칸 띄우고 별칭을 작성한다.
 * 두 가지 방법 모두 '' "" 유무 상관없이 가능하다.
 * 단, AS를 생략하고 표현할 경우에 별칭 안에서 띄어쓰기나 )가 있으면 자동 인식을 못하므로,
 * 반드시 '' "" 로 구분해줘야한다.
 */
DESC EMPLOYEE;

-- 1. AS로 별칭 달기
SELECT EMP_ID AS 사원번호, EMP_NAME AS 사원명
FROM EMPLOYEE;

SELECT EMP_ID AS '사원번호', EMP_NAME AS "사원명"
FROM EMPLOYEE;

-- 2. AS를 생략하고 별칭 달기
SELECT EMP_ID 사번, EMP_NAME 사원명
FROM EMPLOYEE;

SELECT EMP_ID '사번', EMP_NAME "사원명"
FROM EMPLOYEE;

-- 단, AS를 생략할 경우에 별칭에 띄어쓰기나 )가 들어가면 반드시 "" ''로 구분해줘야한다.
SELECT EMP_ID 사번, EMP_NAME 사원 명
FROM EMPLOYEE;

SELECT EMP_ID 사)번, EMP_NAME 사원명
FROM EMPLOYEE;

SELECT EMP_ID "사)번", EMP_NAME '사원 명'
FROM EMPLOYEE;

/* 실습 4
 * 부서가 D1 이거나 D2인 사원들의 사원명, 입사일, 연락처 조회한다.
 * (단, 조회하는 컬럼에 사원명, 입사일, 연락처로 별칭을 붙인다.)
 */

SELECT EMP_NAME 사원명, HIRE_DATE 입사일, PHONE 연락처 
-- 사원명, 입사일, 연락처 조회한다.(별칭은 각각 사원명, 입사일, 연락처)
FROM EMPLOYEE -- 사원의
WHERE DEPT_CODE = 'D1' OR DEPT_CODE = 'D2'; -- 부서가 D1 이거나 D2인

/* 실습 5
 * 사원들의 연봉을 조회한다.
 * (SALARY는 월급)
 */

-- 컬럼을 이용해 연산할 수 있다.
-- NULL은 0이 아니다.
-- 컬럼 값이 NULL이라면, 어떠한 연산을 처리해도 결과는 NULL이다.
SELECT EMP_NAME, SALARY, (SALARY*12) AS 연봉
FROM EMPLOYEE;

SELECT EMP_NAME '사원명', SALARY '기본 월급', (SALARY*12) '기본 연봉', BONUS '보너스', ((SALARY + (SALARY * BONUS)) * 12) '연봉 합계'
FROM EMPLOYEE;

-- IFNULL(컬럼명, NULL일 경우 값) : 조회한 컬럼 값이 NULL일 경우, 별도로 설정한 값으로 변경한다.
SELECT BONUS, IFNULL(BONUS, 0)
FROM EMPLOYEE;

SELECT EMP_NAME '사원명', SALARY '기본 월급', (SALARY * 12) '기본 연봉', 
	   IFNULL(BONUS, 0) '보너스', ((SALARY + (SALARY * IFNULL(BONUS, 0))) * 12) '연봉 합계'
FROM EMPLOYEE;

-- DISTINCT 해당 컬럼명 : 컬럼에 중복되는 데이터가 여러개 존재할 경우, 중복을 제거하고 1개만 조회한다.
-- (NULL도 포함해 중복을 제거한다.)(NULL도 하나의 값이다.)
SELECT DEPT_CODE
FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

-- 여러 컬럼을 DISTINCT하면 중복 제거가 잘 안된다.
SELECT DISTINCT DEPT_CODE, EMP_NAME
FROM EMPLOYEE;
-- DEPT_CODE에서 중복 값이 남아있다.




CREATE TABLE TEST (
	NUM INT PRIMARY KEY,
	NAME VARCHAR(15)
);

CREATE TABLE TEST2 (
	NO INT,
	PHONE VARCHAR(30)
);

INSERT INTO TEST VALUES(1, '아이유');
INSERT INTO TEST VALUES(2, '한지민');
INSERT INTO TEST VALUES(3, '한효주');

SELECT * FROM TEST;

INSERT INTO TEST2 VALUES(1, '01011111111');
INSERT INTO TEST2 VALUES(2, '01022222222');
INSERT INTO TEST2 VALUES(3, '01033333333');
INSERT INTO TEST2 VALUES(1, '01033333333');
INSERT INTO TEST2 VALUES(2, '01033333333');
INSERT INTO TEST2 VALUES(6, '010');

SELECT * FROM TEST1;

ALTER TABLE TEST2 ADD CONSTRAINT FK_NO FOREIGN KEY (NO) REFERENCES TEST(NUM); 

DESC TEST2;
DESC TEST1;

ALTER TABLE TEST RENAME TO TEST1;
ALTER TABLE TEST1 RENAME COLUMN NUM TO CODE;

ALTER TABLE TEST RENAME TO TEST1;
ALTER TABLE TEST1 RENAME COLUMN NUM TO CODE;

INSERT INTO TEST1 VALUES(4, '이준기');
UPDATE TEST1 SET CODE = 5 WHERE CODE = 4;
DELETE FROM TEST1 WHERE CODE = 5;

ALTER TABLE TEST1 DROP COLUMN CODE;


































