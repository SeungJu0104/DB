SELECT * FROM EMPLOYEE;
/* [1번 문제]
 * EMPLOYEE 테이블을 참조해
 * 전화번호의 8번째 자리가 '2'인 사람의
 * 이름, 이메일, 전화번호를 조회하시오.
 * (전화번호는 PHONE 컬럼, 이름은 EMP_NAME 컬럼, 이메일은 EMAIL 컬럼을 사용한다.)
 */

SELECT EMP_NAME 이름, EMAIL 이메일, PHONE 전화번호
FROM EMPLOYEE E 
WHERE SUBSTR(PHONE, 8, 1) = '2';
-- 별칭은 필수 사항까지는 아니다.


/* [2번 문제]
 * 먼저, EMPLOYEE_RE 테이블을 생성하고, EMPLOYEE 테이블을 복사한다.
 * 그 다음에 DEPT_CODE가 D1이고, 
 * HIRE_DATE의 각 데이터들의 연도에서 5를 더한 값이 2000년 이상인 
 * EMP_NAME, 5년 후의 HIRE_DATE, DEPT_CODE만 EMPLOYEE_RE 테이블에서 조회하시오.
 */

-- 테이블 복사
CREATE TABLE EMPLOYEE_RE
AS SELECT * FROM EMPLOYEE;

-- 테이블 생성 확인
SELECT * FROM EMPLOYEE_RE;

-- 결과 조회
SELECT EMP_NAME, DATE_ADD(HIRE_DATE, INTERVAL 5 YEAR), DEPT_CODE
FROM EMPLOYEE_RE
WHERE 
	DEPT_CODE = 'D1'
	AND 
	EXTRACT(YEAR FROM HIRE_DATE) + 5 >= 2000;

/* [3번 문제]
 * EMPLOYEE_RE 테이블과 DEPARTMENT 테이블을 참고해
 * DEPT_CODE 기준으로 그룹을 만든 다음,
 * DEPT_CODE가 NULL값이 아닌 
 * 부서별 평균 월급(AVG(SALARY)과 부서명(DEPT_TITLE)을 
 * DEPT_CODE 기준으로 오름차순 정렬해 조회한다.
 * (부서별 평균 월급은 '(숫자)백만원' 같은 형식으로 나오게 한다. Ex. 3백만원)
 * (부서별 평균 월급은 맨 앞 둘째자리에서 반올림한다.)
 */
SELECT DEPT_TITLE, CONCAT(SUBSTR(ROUND(AVG(SALARY), -(LENGTH(TRUNCATE(AVG(SALARY),0))-1)),1,1), '백만원') 월급
FROM EMPLOYEE_RE ER 
LEFT JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_CODE
HAVING DEPT_CODE IS NOT NULL
ORDER BY DEPT_CODE;

/* [4번 문제]
 * EMPLOYEE 테이블을 참조해
 * EMAIL의 '@'가 몇번째에 위치해 있는지 조회하시오.
 */

SELECT INSTR(EMAIL, '@')
FROM EMPLOYEE;

/* [5번 문제]
 * DEPT_ID, DEPT_TITLE, DEPT_LEAD_PF 라는 3개의 컬럼을 가진
 * DEPT 테이블을 생성하고, 해당 테이블 전체 컬럼을 조회하시오.
 * (DEPT_ID는 VARCHAR 타입, 크기는 5로 생성하고, PRIMARY KEY 제약 조건을 준다.)
 * (DEPT_TITLE은 VARCHAR 타입, 크기는 20으로 생성하고, NOT NULL과 UNIQUE 제약 조건을 준다.)
 * (DEPT_LEAD_PF는 VARCHAR 타입, 크기는 15로 생성하고, 기본 값은 '부재'로 준다.)
 */

CREATE TABLE DEPT(
	DEPT_ID VARCHAR(5) PRIMARY KEY,
	DEPT_TITLE VARCHAR(20) NOT NULL UNIQUE,
	DEPT_LEAD_PF VARCHAR(15) NOT NULL DEFAULT '부재'
);

-- 테이블 생성 및 제약 조건, 타입 정확한지 확인
DESC DEPT;
DROP TABLE DEPT;

SELECT * FROM DEPT;

/* [6번 문제]
 * DEPT 테이블을 참조해 DEPT_LEAD_PF 컬럼의 기본 값을 변경하고,
 * DEPT 테이블의 DEPT_LEAD_PF 컬럼을 조회하시오.
 * (ALTER TABLE 테이블명 ALTER COLUMN 변경할 컬럼명 SET DEFAULT '기본 값';)
 * (조회해도 기본 값이 안보이는 것이 정상적인 결과 값이다.)
 */

ALTER TABLE DEPT
ALTER COLUMN DEPT_LEAD_PF SET DEFAULT '미정';
-- ALTER 이용해 DEFAULT 설정해도, 기존에 걸려있던 NOT NULL 제약 조건은 없어지는 것이 아니라 그대로 남아있다.

-- 기본 값이 설정되었는지 확인
DESC DEPT;
SELECT DEPT_LEAD_PF FROM DEPT;

/* [7번 문제]
 * DEPT 테이블의
 * DEPT_ID, DEPT_TITLE, DEPT_LEAD_PF 컬럼들에 데이터들을 INSERT하고,
 * 해당 테이블 전체를 조회하시오.
 * (최소 3개 이상 INSERT한다.)
 * (최소 1개 이상 DEPT_LEAD_PF 컬럼에 DEFAULT를 넣는다.)
 * (앞에서 작성한 STUDENT_INFO 테이블의 DEPT_CODE 컬럼에 있는 데이터 값들을 집어 넣는다.)
 */

INSERT INTO DEPT VALUES('D1', '경영학과', '김주호');
INSERT INTO DEPT VALUES('D2', '경영정보학과', '노영종');
INSERT INTO DEPT VALUES('D3', '경제학과', '김연신');
INSERT INTO DEPT VALUES('D4', '미술사학과', '유홍준');
INSERT INTO DEPT VALUES('D5', '컴퓨터공학과', DEFAULT);
INSERT INTO DEPT VALUES('D6', '문예창작과', DEFAULT);

SELECT * FROM DEPT;

/* [8번 문제]
 * ST_ID, ST_NAME, ST_BIRTH, ST_GENDER, ST_DEPT_CODE, ST_PHONENO, ST_EMAIL 
 * 이라는 7개의 컬럼을 가진 STUDENT_INFO 테이블을 생성하고, 해당 테이블의 모든 컬럼을 조회하시오.
 * (ST_ID 컬럼은 VARCHAR 타입, 크기는 10으로 생성하고, PRIMARY KEY 제약 조건을 준다.)
 * (ST_NAME 컬럼은 CHAR 타입, 크기는 20으로 생성하고, NOT NULL 제약 조건을 준다.)
 * (ST_BIRTH 컬럼은 VARCHAR 타입으로 생성하고, 크기는 15로 생성한다.)
 * (ST_GENDER 컬럼은 VARCHAR 타입, 크기는 3으로 생성하고, 대소문자 'M' 또는 'F'만 받는 CHECK 제약 조건을 준다.)
 * (ST_DEPT_CODE 컬럼은 VARCHAR 타입, 크기는 5로 생성하고, NOT NULL 제약 조건을 준다.)
 * (ST_PHONENO 컬럼은 VARCHAR 타입, 크기는 15로 생성하고, UNIQUE 제약 조건을 준다.)
 */

CREATE TABLE STUDENT_INFO(
	ST_ID VARCHAR(10) PRIMARY KEY,
	ST_NAME CHAR(20) NOT NULL,
	ST_BIRTH VARCHAR(15),
	ST_GENDER VARCHAR(3) CHECK(ST_GENDER IN ('M', 'F', 'm', 'f')),
	ST_DEPT_CODE VARCHAR(5) NOT NULL,
	ST_PHONENO VARCHAR(15) UNIQUE
);

-- 테이블 생성 및 제약 조건, 타입 정확한지 확인
DESC STUDENT_INFO;
SELECT * FROM STUDENT_INFO;

/* [9번 문제]
 * STUDENT_INFO 테이블에 5개 이상의 값을 INSERT 하고, 모든 컬럼을 조회하시오.
 * (ST_PHONENO 컬럼에 값을 넣을 때는 '010-XXXX-XXXX' 형태로 값을 넣는다.)
 * (ST_PHONENO 컬럼에 최소 하나 이상 NULL 값을 넣는다.)
 * (ST_GENDER 컬럼에 대문자 M 또는 F값, 소문자 m 또는 f값을 각각 최소 하나 이상 넣는다.)
 */

INSERT INTO STUDENT_INFO VALUES(204769, '김승규', '900930', 'M', 'D1', '010-4556-9812');
INSERT INTO STUDENT_INFO VALUES(218462, '김민재', '961115', 'm', 'D3', '010-6784-1359');
INSERT INTO STUDENT_INFO VALUES(218544, '이강인', '010219', 'M', 'D2', '010-7468-1355');
INSERT INTO STUDENT_INFO VALUES(198562, '손흥민', '920708', 'm', 'D4', '010-3112-4583');
INSERT INTO STUDENT_INFO VALUES(188741, '조규성', '980125', 'M', 'D1', NULL);
INSERT INTO STUDENT_INFO VALUES(201648, '아이유', '930516', 'F', 'D5', '010-1289-7447');
INSERT INTO STUDENT_INFO VALUES(235564, '이미주', '940923', 'f', 'D5', NULL);

-- 테이블에 제대로 값이 들어갔는지 확인
SELECT * FROM STUDENT_INFO;

/* [10번 문제]
 * STUDENT_INFO 테이블의 ST_GENDER 컬럼 데이터들 중 
 * 소문자 m, f로 된 데이터들을 대문자로 변경한 뒤, ST_GENDER 컬럼만 조회한다.
 * (가능하면 CASE문 사용하고, 아니면 UPDATE 문을 2번 사용한다.)
 * (조회할 때, ST_GENDER 컬럼의 별칭은 '성별')
 */

-- 1) CASE문
UPDATE STUDENT_INFO 
SET ST_GENDER =
	CASE ST_GENDER
		WHEN 'm' THEN 'M'
		WHEN 'f' THEN 'F'
	END 
	
SELECT ST_GENDER 성별 FROM STUDENT_INFO;

-- 2) UPDATE문
UPDATE STUDENT_INFO
SET ST_GENDER = 'M'
WHERE ST_GENDER = 'm';

UPDATE STUDENT_INFO
SET ST_GENDER = 'F'
WHERE ST_GENDER = 'f';

-- 테이블에 변경 사항이 반영되었는지 확인
SELECT ST_GENDER 성별 FROM STUDENT_INFO;

/* [11번 문제]
 * 먼저, STUDENT_INFO 테이블의 ST_DEPT_CODE 컬럼이
 * DEPT 테이블의 DEPT_ID 컬럼을 참조하도록
 * FOREIGN KEY 제약 조건을 설정한다.
 * 그리고 STUDENT_INFO 테이블과 DEPT 테이블의 ST_NAME, DEPT_TITLE을 
 * ST_NAME 기준 오름차순으로 정렬해 조회한다.
 * (ST_NAME의 별칭은 '이름', DEPT_TITLE의 별칭은 '학과'로 한다.)
 * (조회할 때는 JOIN과 INLINE VIEW를 같이 사용한다.)
 */

-- FOREIGN KEY 제약 조건 설정
ALTER TABLE STUDENT_INFO 
ADD FOREIGN KEY (ST_DEPT_CODE)
REFERENCES DEPT(DEPT_ID);

-- 제약 조건 설정 확인
DESC STUDENT_INFO;

-- JOIN 과 INLINE VIEW를 활용해 조회한다.
-- 1)
SELECT *
FROM (
	SELECT ST_NAME 이름, DEPT_TITLE 학과
	FROM STUDENT_INFO SI 
	LEFT JOIN DEPT ON (ST_DEPT_CODE = DEPT_ID)
	ORDER BY ST_NAME
) ST_DEPT_INFO;


-- 2)
SELECT ST_NAME 이름, DEPT_TITLE 학과
FROM (
	SELECT *
	FROM STUDENT_INFO SI 
	LEFT JOIN DEPT ON (ST_DEPT_CODE = DEPT_ID)
	ORDER BY ST_NAME
) ST_DEPT_INFO2;



/* [12번 문제]
 * STUDENT_INFO 테이블에 ST_SCH라는 기본 값은 0을 갖는 컬럼을 추가한다,
 * 그 다음, STUDENT_INFO 테이블의 ST_BIRTH 컬럼의 데이터들을 참고해
 * 적당한 연도를 하나 정한 후 해당 연도 이후에 태어난 학생들의
 * ST_SCH 컬럼 값을 1000000으로 변경한다.
 * 마지막으로 ST_SCH 컬럼 값이 1000000인 학생들의 
 * 이름(ST_NAME), 학과(DEPT_TITLE)를 조회한다.
 */

ALTER TABLE STUDENT_INFO 
ADD COLUMN ST_SCH INT DEFAULT 0;

UPDATE STUDENT_INFO 
SET ST_SCH = 1000000
WHERE SUBSTR(ST_BIRTH, 1, 2) > 95;

SELECT ST_NAME 이름, DEPT_TITLE 학과 
FROM 
STUDENT_INFO LEFT JOIN DEPT ON (ST_DEPT_CODE = DEPT_ID)
WHERE ST_SCH > 0;

/* [13번 문제]
 * STUDENT_INFO 테이블을 참조해
 * 학생들의 생년월일(ST_BIRTH) 뒤에 '-*******'가 붙도록
 * VIEW를 작성하시오.
 * (RPAD, CONCAT을 이용한다.)
 * (별칭은 '주민번호')
 */

CREATE OR REPLACE VIEW V_STUDENT_INFO
AS 
SELECT RPAD(CONCAT(ST_BIRTH, '-'), 14, '*') 주민번호
FROM (STUDENT_INFO);

SELECT * FROM V_STUDENT_INFO;

/* [14번 문제]
 * DEPT 테이블에서
 * DEPT_ID가 'D6'인 값을 삭제한 뒤,
 * DEPT 테이블의 모든 컬럼을 조회하시오.
 */

DELETE FROM DEPT WHERE DEPT_ID = 'D6';
-- DEPT_ID가 'D6'인 ROW는 참조 주고있지 않아 삭제 가능하다.

SELECT * FROM DEPT;

/* [15번 문제]
 * STUDENT_INFO 테이블의 ST_PHONENO 컬럼의 NULL 값들을
 * '010-XXXX-XXXX' 형태의 임의의 값으로 변경하고,
 * 이름(ST_NAME)과 전화번호(ST_PHONENO)를 조회하시오.
 */

UPDATE STUDENT_INFO 
SET ST_PHONENO = '010-4133-2166'
WHERE ST_NAME = '이미주';

UPDATE STUDENT_INFO 
SET ST_PHONENO = '010-7422-4851'
WHERE ST_NAME = '조규성';

SELECT ST_NAME 이름, ST_PHONENO 전화번호
FROM STUDENT_INFO;

/* [16번 문제]
 * STUDENT 테이블에서 ST_BIRTH 컬럼의 데이터들을
 * 날짜 타입으로 변환하고, 
 * 오늘 날짜와 몇 일이나 차이나는지 조회하시오.
 * (별칭은 '생후 일 수')
 */

SELECT DATEDIFF(SYSDATE(), STR_TO_DATE(ST_BIRTH,'%y%m%d')) AS '생후 일 수'
FROM STUDENT_INFO;














































