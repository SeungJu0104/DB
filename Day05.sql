/* [DDL]
 * CREATE
 * : 데이터베이스 객체 생성
 * (테이블, 뷰, 데이터베이스, 인덱스, ...)
 * 
 * ALTER
 * : 생성한 객체 수정
 * : 컬럼의 자료형이나 크기를 수정할 때, 문자와 숫자 간 형변환 및 기존 크기보다 작게 만들 때는 유의해야한다.
 * : ALTER TABLE 테이블명 명령어(Ex. ADD, DROP, MODIFY, RENAME TO ...) 수정 내용;
 * 
 * ALTER를 이용한 제약 조건 추가
 * ALTER TABLE 테이블명 ADD PRIMARY KEY (컬럼명)
 * ALTER TABLE 참조 받을 테이블명 ADD [CONSTRAINT 제약 조건 컬럼명] FOREIGN KEY (참조 받을 컬럼명) REFERENCES 참조할 대상 테이블명 (참조할 대상 테이블의 컬럼명)
 * (FOREIGN KEY 뒤 컬럼명에 () 안붙이면 에러 발생)
 * ([] 부분은 생략 가능하다.)
 * ALTER TABLE 테이블명 ADD UNIQUE (컬럼명)
 * ALTER TABLE 테이블명 ADD CHECK(값 또는 조건식)
 * ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL
 * 
 * 
 * 
 * -- 근데 기본키, 외래키 같은 제약 조건 걸린 컬럼을 ALTER로 지우면 어떻게 되는가?? 외래키 제약조건에 의해 삭제 불가능
 * 
 * DROP
 * : 생성한 객체 삭제
 * : DROP TABLE 테이블명
 * 
 * 
 * [DML]
 * : 데이터 조작 언어
 * 
 * CRUD
 * CREATE : INSERT / 추가
 * READ : SELECT / 조회
 * UPDATE : UPDATE / 수정
 * DELETE : DELETE / 삭제
 * 
 * INSERT 
 * : 새로운 행을 특정 테이블에 추가하는 명령어
 * 
 * 1) 특정 컬럼에 값을 추가하는 방법
 * : INSERT INTO 테이블명(컬럼명, 컬럼명, ...) VALUES (값1, 값2, ...)
 * : 명시한 컬럼 수만큼 값을 맞춰 넣어야한다.
 * 예를 들어, 컬럼명을 3개를 작성했다면, 값도 3개 넣어야한다.
 * 
 * 2) 모든 컬럼에 값을 추가하는 방법
 * : INSERT INTO 테이블명 VALUES (값1, 값2, ...);
 * : 테이블 내 모든 컬럼에 값이 들어간다.
 * 이 경우, 반드시 전체 컬럼의 개수를 맞춰 넣어야한다.
 * 
 * 3) INSERT문에 서브쿼리 활용
 * : INSERT 문에 서브쿼리를 사용해 VALUES 대신 값을 지정하여 추가 가능하다.
 * : INSERT INTO 테이블명 (컬럼명) (서브쿼리문);
 * 
 * UPDATE
 * : 해당 테이블의 데이터를 수정하는 명령어
 * : 실행 후 데이터의 개수(ROW의 개수)는 변하지 않는다.
 * : UPDATE 시에 변경할 값이 해당 컬럼의 제약 조건을 위배해서는 안된다.
 * : UPDATE 테이블명 SET 컬럼명 = 바꿀 값 [WHERE 조건식];
 * (조건식을 따로 작성 안하면, 해당 컬럼이 모두 바꿀 값으로 변경된다.)
 * (바꿀 값에 CASE문 쓸 수 있다.)
 * (UPDATE 결과인 변경 ROW의 개수가 0일 수 있다. 단순히 아무것도 변경안된 것이다.)
 * 
 * 
 * 1) UPDATE문에 서브쿼리 활용
 * : UPDATE 테이블 SET 컬럼명 = (서브쿼리) [WHERE 조건식 또는 서브쿼리];
 * (WHERE 절에도 서브쿼리를 쓸 수 있다.)
 * (단일 행, 다중 열 서브쿼리는 SQL 버전 문제 때문에 사용 불가하다.)
 * 
 * DELETE
 * : 테이블의 행을 삭제하는 명령어
 * : 실행 후에는 테이블의 ROW 개수가 줄어든다.
 * : DELETE FROM 테이블명 [WHERE 조건];
 * (만약, 조건문 작성 안하고 실행하면 테이블의 모든 데이터(ROW)가 삭제된다.)
 * (DELETE 결과인 지운 ROW의 개수가 0일 수 있다. 단순히 아무것도 안지운 것이다.)
 * (DROP은 테이블 자제를 지우는 것이고, DELETE는 테이블 내에 데이터를 지우는 것이다.)
 * 
 * [TCL] (TRANSTION CONTROL LANGUAGE)
 * : 트랜젝션 제어 언어
 * : COMMIT, ROLLBACK, SAVEPOINT, ROLLBACK TO
 * 
 * 1) ROLLBACK
 * : 가장 최근에 COMMIT 했던 시점으로 돌아간다.
 * 
 * 2) COMMIT
 * : 현재까지의 변경 사항을 데이터베이스에 반영한다.
 * 
 * TRANSCTION
 * : 데이터를 처리하는 작업을 잘게 나눈 데이터 처리의 최소 단위
 * : 하나의 트랜잭션으로 이루어진 작업은 반드시 작업 내용이
 *   모두 성공하거나, 모두 실패해야 한다.
 * : 성공하면 COMMIT되고, 중간에 하나라도 실패하면 이전 과정들 모두 성공했더라도 전부 ROLLBACK
 * 	 (각 작업이 성공하면 반드시 COMMIT한다.)
 * 	 (만약 과정에 DDL이 포함되어 있다면, DDL 구문이 실행될 때는 자동 COMMIT되고, 이건 ROLLBACK 안된다.)
 * Ex) 만약 UPDATE - UPDATE - INSERT - DELETE로 이루어진 트랜잭션이 있는데,
 * 		UPDATE 2번 모두 COMMIT하고 INSERT가 실패한다면 앞서 COMMIT한 UPDATE 까지 모두 ROLLBACK 한다.
 * : DDL에는 사용 불가하고, DML에만 사용 가능하다.
 * 
 * [VIEW]
 * : SELECT 를 실행한 결과 화면을 담는 객체
 * : 조회한 SELECT문 자체를 저장한다.
 * (즉, 호출할 때마다 해당 쿼리를 실행해 결과를 보여주는 객체이다.)
 * (VIEW에는 데이터가 담겨있지 않다.)
 * (일반 사용자에게 노출하고 싶은 정보나, 업무에 필요한 정보들만 조회할 수 있도록 제공)
 * : 원본 테이블의 값이 변경되면, VIEW에서도 값이 변경된다.
 * (VIEW는 SELECT 쿼리를 저장하고 있기 때문이다.)
 * : CREATE [OR REPLACE] VIEW 뷰명[(SELECT 문을 통해 갖고 올 컬럼들의 별칭)] AS 서브쿼리(VIEW를 통해 확인할 SELECT문);
 * (CREATE OR REPLACE로 뷰 선언한 뒤, 동일 이름의 뷰를 만들면 동일 이름의 새로운 뷰로 대체한다.)
 * (VIEW의 SELECT 문에 IF문, CASE문 사용할 수 있다.)
 * 
 * [AUTO_INCREMENT]
 * : INSERT 할 때마다 자동으로 키를 1씩 증가시킨다.
 * : 컬럼 선언할 때 옆에 AUTO_INCREMENT 붙인다.
 * : 컬럼명 자료형(크기) AUTO_INCREMENT
 * (중간에 DELETE 사용해서 내용 지우고, 다시 INSERT하면
 * 지우기 전 마지막 값에 1을 더해서 나온다.)
 * (DROP해서 테이블 완전히 지우면 다시 처음부터 시작한다.)
 * 
 * 
 */

-- [ALTER]
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- ALTER를 이용해 DEPT_COPY테이블에 LNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR(20);

-- 테이블에 컬럼 추가 확인
SELECT * FROM DEPT_COPY;

-- ALTER를 이용해 DEPT_COPY 테이블의 LNAME 컬럼 삭제
ALTER TABLE DEPT_COPY DROP COLUMN LNAME;

-- 테이블에 컬럼 삭제 확인
SELECT * FROM DEPT_COPY;

-- 기본 값을 적용해 컬럼 추가
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR(20) DEFAULT '한국';

-- 테이블에 컬럼 추가 및 기본 값 확인
SELECT * FROM DEPT_COPY;

-- ALTER를 이용한 컬럼의 자료형 수정
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(30);
-- 기존에 VARCHAR 타입, 크기 10이었던 DEPT_ID 컬럼을 CHAR 타입, 크기 30으로 변경

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR(3);
-- 크기를 줄이니, SQL Error [1265] [01000]: Data truncated for column 'DEPT_TITLE' at row 1 에러 발생.
-- 너무 작은 크기로 줄여서 기존 데이터를 담을 수 없어서 에러 난다.

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR(10);
-- 적절한 크기로 다시 주자 변경 된다.

-- ALTER를 이용한 컬럼의 이름 변경
ALTER TABLE DEPT_COPY RENAME COLUMN LNAME TO LOC_NAME;

DESC DEPT_COPY;

-- ALTER를 이용해 테이블 이름 변경
ALTER TABLE DEPT_COPY RENAME TO DEPT_COPY2;

DESC DEPT_COPY; -- DEPT_COPY 테이블 존재안한다고 나온다.
DESC DEPT_COPY2; -- 정상적으로 이름 변경되어 정보가 나온다.

-- ALTER로 모든 컬럼을 지울 수는 없다.
-- (반드시 테이블에는 1개 이상의 컬럼이 있어야한다.)
ALTER TABLE DEPT_COPY2 DROP COLUMN LOC_NAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
-- 정상적으로 삭제 된다.
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
-- SQL Error [1090] [42000]: You can't delete all columns with ALTER TABLE; use DROP TABLE instead
-- 반드시 테이블에는 1개 이상의 컬럼이 있어야한다.

-- 근데 기본키, 외래키 같은 제약 조건 걸린 컬럼을 ALTER로 지우면 어떻게 되는가?? 안지워진다.

DESC DEPT_COPY2;

-- ALTER를 이용한 제약 조건 추가
-- DEPARTMENT 테이블에 DEPT_ID 컬럼에 PRIMARY KEY 추가
ALTER TABLE DEPARTMENT ADD PRIMARY KEY (DEPT_ID);

-- DEPARTMENT 테이블에 LOCATION_ID에 FOREIGN KEY를 추가
ALTER TABLE DEPARTMENT ADD FOREIGN KEY (LOCATION_ID) REFERENCES LOCATION(LOCAL_CODE);
-- FOREIGN KEY 뒤 컬럼명에 () 안붙이면 에러 발생

-- EMPLOYEE 테이블에 DEPT_CODE 컬럼에 FOREIGN KEY를 추가
ALTER TABLE EMPLOYEE ADD CONSTRAINT FK_EMP_DEPCODE FOREIGN KEY(DEPT_CODE) 
REFERENCES DEPARTMENT(DEPT_ID);
-- EMPLOYEE 테이블의 DEPT_CODE 컬럼이 DEPARTMENT 테이블의 DEPT_ID를 외래키로 참조한다.

-- EMPLOYEE 테이블의 SAL_LEVEL 컬럼에 SAL_GRADE 테이블의 SAL_LEVEL 컬럼을 FOREIGN KEY 추가
ALTER TABLE EMPLOYEE ADD FOREIGN KEY (SAL_LEVEL) REFERENCES SAL_GRADE(SAL_LEVEL);

-- EMPLOYEE 테이블의 JOB_CODE 컬럼에 JOB 테이블의 JOB_CODE 컬럼을 FK로 참조한다.
ALTER TABLE EMPLOYEE ADD FOREIGN KEY (JOB_CODE) REFERENCES JOB(JOB_CODE);

-- EMPLOYEE 테이블의 ENT_YN에 CHECK 제약 조건을 건다.
ALTER TABLE EMPLOYEE ADD CHECK(ENT_YN IN ('Y', 'N'));

-- EMPLOYEE 테이블의 SALARY에 CHECK 제약 조건을 건다.
ALTER TABLE EMPLOYEE ADD CHECK(SALARY > 0);

-- EMPLOYEE 테이블의 ENT_NO에 UNIQUE 제약 조건을 건다.
ALTER TABLE EMPLOYEE ADD UNIQUE(EMP_NO);

-- LOCATION 테이블의 NATIONAL_CODE에 외래키 제약 조건을 건다.
ALTER TABLE  LOCATION ADD FOREIGN KEY (NATIONAL_CODE)
REFERENCES NATIONAL(NATIONAL_CODE);

-- ALTER 이용해 제약 조건 추가한 결과 확인
DESC DEPARTMENT;
DESC EMPLYOEE;
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'multi' AND TABLE_NAME = 'DEPARTMENT';
SELECT * FROM LOCATION;

-- [DROP]
-- 테이블 삭제
DROP TABLE DEPT_COPY2;

-- [INSERT]
-- INSERT의 컬럼을 명시해 데이터 추가
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE,
					DEPT_CODE, JOB_CODE, SAL_LEVEL, SALARY, BONUS,
					MANAGER_ID, HIRE_DATE, ENT_DATE,  ENT_YN)
VALUES (500, '이창진', '700101-1234567', 'LE_cj@multi.kr', '01011112222',
		'D1', 'J7', 'S4', 3100000, 0.1, 200, NOW(), NULL, DEFAULT);
-- INSERT INTO 내에 작성한 컬럼의 개수에 맞춰 값의 개수도 똑같이 넣어줘야한다.
-- 적거나 많으면 에러 발생
-- DEFAULT를 INSERT INTO에 쓰면, 테이블 생성할 때 지정한 DEFAULT 값이 나온다.
	
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '이창진';

-- INSERT의 컬럼 작성 생략하고 모든 컬럼에 데이터 추가
CREATE TABLE TEST_INS(
	NO1 INT,
	NO2 INT
);

INSERT INTO TEST_INS VALUES (10,20);
-- 테이블이 갖고 있는 모든 컬럼의 개수만큼 값의 개수도 넣어줘야한다.
-- 적거나 많으면 에러 발생
SELECT * FROM TEST_INS;

INSERT INTO EMPLOYEE
VALUES (900, '김씨', '510203-1234567', 'kimc@multi.kr', '01058887444',
		'D1', 'J7', 'S3', '4300000', 0.2, 200, NOW(),NULL, DEFAULT);
-- DEPT_CODE 등 EMPLOYEE 테이블 내에서 외래키 제약 조건 걸린 것들은 범위 내의 값 쓰기

SELECT * FROM EMPLOYEE E WHERE EMP_ID = 900;


-- 지금까지 작업한 내용을 데이터베이스에 반영 및 저장
COMMIT;

-- INSERT문에 서브쿼리 활용
CREATE TABLE EMP_01(
	EMP_ID INT,
	EMP_NAME VARCHAR(20),
	DEPT_TITLE VARCHAR(40)
);

INSERT INTO EMP_01 (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
					FROM EMPLOYEE
					LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
					);
-- EMP_ID는 기본키이기 때문에 NULL 값이나 중복 값이 없다. ==> 모든 값이 존재한다.
-- DEPT_TITLE 값이 이 없는 EMP_ID들이 있기 때문에 LEFT JOIN해서 없는 값들을 NULL 처리한다.

SELECT * FROM EMP_01;

COMMIT; -- 변경 사항 반영

-- [UPDATE]
-- D9 총무부를 전략 기획부로 변경
-- 이전에 생성한 DEPT_COPY 테이블 삭제
DROP TABLE DEPT_COPY;

-- DEPARTMENT 테이블 복사해 새 테이블 생성
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

UPDATE DEPT_COPY SET DEPT_TITLE = '전략기획부'
WHERE DEPT_ID = 'D9';
-- WHERE절로 조건 안주면 테이블의 DEPT_TITLE 컬럼 내 값 모두 '전략기획부로' 바뀐다.

SELECT * FROM DEPT_COPY;

COMMIT;

-- UPDATE 문에 서브쿼리 활용
-- 유재식 사원과 같은 급여, 보너스를 받게 방명수 사원의 정보를 변경한다.
-- 1) 단일행, 단일열 서브쿼리
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS FROM EMPLOYEE;

UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '유재식'),
	BONUS = (SELECT BONUS FROM EMPLOYEE WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';

SELECT * FROM EMP_SALARY WHERE EMP_NAME IN ('유재식', '방명수');

COMMIT;

-- 2) 단일 행, 다중 열 서브쿼리 -- SQL 버전 문제 때문에 안된다.
-- 위의 SET 문장을 한 문장으로 만들 수 있을까??
-- CREATE TABLE EMP_SALARY2
-- AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS FROM EMPLOYEE;
-- 
-- UPDATE EMP_SALARY2 
-- SET (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_SALARY2 WHERE EMP_NAME = '유재식') 
-- WHERE EMP_NAME = '방명수';
-- -- 유재식이라는 이름이 있는 1개 행의 SALARY, BONUS 라는 2개의 열을 
-- -- 방명수라는 이름이 있는 1개의 행의 SALARY, BONUS 라는 2개의 열에 변경한다.
-- 
-- SELECT * FROM EMP_SALARY2 WHERE EMP_NAME IN ('유재식', '방명수');
-- 
-- 
-- CREATE TABLE EMP_SALARY3
-- AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS FROM EMPLOYEE;
-- 
-- UPDATE EMP_SALARY2 
-- SET (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_SALARY2 WHERE EMP_NAME = '유재식') 
-- WHERE EMP_NAME IN ('방명수', '이창진');
-- -- 유재식이라는 이름이 있는 1개 행의 SALARY, BONUS 라는 2개의 열을 
-- -- 방명수라는 이름이 있는 1개의 행의 SALARY, BONUS 라는 2개의 열에 변경한다.
-- -- 이창진이라는 이름이 있는 1개의 행의 SALARY, BONUS 라는 2개의 열에 변경한다.
-- 
-- SELECT * FROM EMP_SALARY WHERE EMP_NAME IN ('유재식', '방명수', '이창진');

-- UPDATE 시에 변경할 값이 해당 컬럼의 제약 조건을 위배해서는 안된다.
UPDATE EMPLOYEE 
SET DEPT_CODE = 'D0'
WHERE DEPT_CODE = 'D6';
-- SQL Error [1452] [23000]: Cannot add or update a child row: a foreign key constraint fails 
-- 참조 주고 있는 테이블에 없는 값(DEPARTMENT 테이블의 DEPT_ID에 없는 값)을 주면, 외래키 제약 조건 위배된다.
-- DEPT_ID에는 D6는 있지만, D0는 없다.
-- 즉, 참조할 테이블(DEPARTMENT)의 컬럼(DEPT_ID)에 없는 값을 참조 받을 테이블(EMPLOYEE)의 컬럼(DEPT_CODE)에 추가하는 것은 불가하다.

UPDATE EMPLOYEE
SET EMP_ID = NULL 
WHERE EMP_ID = 200;
-- Column 'EMP_ID' cannot be null
-- PRIMARY KEY는 NOT NULL, UNIQUE 제약 조건을 갖고 있기 때문에
-- PRIMARY KEY 제약 조건에 위배된다.

COMMIT;

-- [DELETE]
-- DELETE를 사용할 때에 반드시 지울 내용에 대해 파악한 후 실행해야한다.
DELETE FROM DEPARTMENT 
WHERE DEPT_ID = 'D1';
-- SQL Error [1451] [23000]: Cannot delete or update a parent row: a foreign key constraint fails
-- EMPLOYEE 테이블에 참조를 주고 있는 DEPARTMENT 테이블의 DEPT_ID 컬럼의 값을 삭제하려하니
-- 외래키 제약 조건에 위배되어 에러 발생한다.
-- (참조 주는 테이블에 삭제 또는 수정 옵션 주지 않고, 수정하려하면 에러 발생한다.)

SELECT * FROM EMP_SALARY;


-- 데이터 전체 삭제
DELETE FROM EMP_SALARY;
-- WHERE 절로 따로 조건 안주면, 테이블 내 데이터 전부 삭제된다.
-- DROP은 테이블 자체를 삭제하는 것이다.

SELECT * FROM EMP_SALARY;


ROLLBACK;

-- 원하는 데이터만 삭제
DELETE FROM EMP_SALARY
WHERE EMP_ID = 200;

SELECT * FROM EMP_SALARY;

COMMIT;

-- [TCL]
-- DDL에는 사용 불가하고, DML에만 사용 가능하다.
CREATE TABLE USER_TBL(
	USER_NO INT UNIQUE,
	USER_ID VARCHAR(20) NOT NULL UNIQUE,
	USER_PW VARCHAR(20) NOT NULL
);

DROP TABLE  USER_TBL;
ROLLBACK;
SELECT * FROM USER_TBL;
-- ROLLBACK해도 테이블 안살아난다.
-- DDL은 TCL이 적용되지 않는다.

INSERT INTO USER_TBL VALUES(1, 'TEST01', 'tEST01');
INSERT INTO USER_TBL VALUES(2, 'test02', 'TEST01');
-- UNIQUE는 대소문자 구분 안한다.

COMMIT;-- 현재까지 변경사항을 데이터베이스에 반영한다.

SELECT * FROM USER_TBL;

INSERT INTO USER_TBL VALUES(3,'TEST03', 'PASS03');
-- UNIQUE는 대소문자 구분 안한다.

ROLLBACK; -- 가장 최근에 COMMIT했던 시점으로 돌아간다.

SELECT * FROM USER_TBL;
-- ROLLBACK 했기 때문에 마지막 COMMIT 시점인 
-- INSERT INTO USER_TBL VALUES(2, 'test02', 'TEST01');
-- 실행한 직후로 돌아간다.

COMMIT;

-- [VIEW]
-- VIEW 생성
CREATE OR REPLACE VIEW V_EMP
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMPLOYEE;

-- VIEW 호출
SELECT * FROM V_EMP;

-- VIEW 정보
SHOW CREATE VIEW V_EMP;

-- 원본 테이블의 데이터가 변경되면, VIEW를 통해 보여지는 데이터도 함께 변경된다.
-- (VIEW가 SELECT 쿼리를 저장하고 있기 때문이다.)

UPDATE EMPLOYEE
SET EMP_NAME = '박창진'
WHERE EMP_ID = '900';
-- WHERE 절 조건 안쓰면 EMP_NAME 컬럼 데이터 전체 '박창진'으로 바뀐다.

SELECT * FROM V_EMP;

-- VIEW 삭제
DROP VIEW V_EMP;

-- VIEW에 컬럼별 별칭 부여
CREATE OR REPLACE VIEW V_EMP(사번, 사원, 부서코드)
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMPLOYEE;

SELECT * FROM V_EMP;

-- [AUTO_INCREMENT]
CREATE TABLE AT_TEST(
	ID INT AUTO_INCREMENT PRIMARY KEY,
	NAME VARCHAR(30)
);

INSERT INTO AT_TEST VALUES(NULL, '홍길동');
-- 1번씩 실행할 때마다 ID 컬럼 값이 1씩 증가하면서 추가된다.
-- 기본키 부분에 NULL값 세팅하면 자동으로 1부터 시작해 1씩 올라간다.
-- (NULL아니라 1써도 1부터 시작해서 1씩 올라간다.)

SELECT * FROM AT_TEST;

DELETE FROM AT_TEST;
-- AT_TEST 내용 DELETE로 삭제하고 INSERT 다시하면,
-- 1부터 다시 나오는게 아니라 삭제하기 전 숫자에 1 더한 값부터 나온다.

DROP TABLE AT_TEST;



-- JDBC 실습용 테이블 생성
CREATE TABLE MYTEST(
	MNO INT AUTO_INCREMENT PRIMARY KEY,
	MNAME VARCHAR(20) NOT NULL,
	NICKNAME VARCHAR(20) NOT NULL
);

DESC MYTEST;

INSERT INTO MYTEST VALUES(NULL,'LEE','LCJ');

SELECT * FROM MYTEST;

DELETE FROM MYTEST;

COMMIT;

DROP TABLE MYTEST;




CREATE TABLE Board(
	boardno int PRIMARY KEY auto_increment,
	boardtitle varchar(100) NOT NULL,
	boardwriter varchar(100) NOT NULL,
	boardcontent varchar(500) NOT NULL,
	boarddate date NOT NULL
);

DESC Board;

SELECT * FROM Board;

INSERT INTO Board values(NULL, "맨유", "텐하흐", "10위", NOW());


DROP TABLE Board;

































