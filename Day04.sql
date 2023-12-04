/* RANK ()
 * : 순위를 매기는 함수
 * : RANK () OVER (ORDER BY 컬럼명 정렬방식) 별칭
 * (동일한 순번이 있을 경우,
 * 이후 순번은 이전의 동일한 순번의 개수만큼 건너뛰고 순번을 매긴다.)
 * Ex) 1등 2등 2등 2등 5등 ...
 * 
 * DENSE RANK ()
 * : 순위를 매기는 함수
 * : DENSE_RANK () OVER (ORDER BY 컬럼명 정렬방식) 별칭
 * (단, 동일한 순번이 있을 경우, RANK 함수와 다르게
 * 동일한 순번이 이후 순번에 영향을 미치지 않는다.)
 * Ex) 1등 2등 2등 2등 3등 ...
 * 
 * ROW_NUMBER ()
 * : 동일 순번은 무시하고 순위를 매기는 함수
 * : ROW_NUMBER() OVER(ORDER BY 컬럼명 정렬방식) 별칭
 * Ex) 1등 2등 3등 ....
 * 
 * 상호 연관 쿼리 (상관 쿼리)
 * : 메인 쿼리가 사용하는 컬럼 값, 계산식 등을 서브쿼리에 적용해
 * 	 서브쿼리 실행 시 메인쿼리의 값도 함께 사용하는 방식
 * 
 * [DDL] (데이터 정의어, DATA DEFINITION LANGUAGE)
 * : 데이터베이스 스키마 정의, 조작
 * 
 * 1. CREATE
 * : 데이터 베이스 객체를 생성하는 DDL
 * : CREATE 객체 형태 객체명 (컬럼 자료형(길이) 제약조건);
 * 
 * Ex) 테이블 생성 
 * 	CREATE TABLE 테이블명 (컬럼 자료형(길이) 제약조건);
 * 
 * 제약 조건(CONSTRAINTS)
 * : 테이블에 데이터를 저장할 때, 지켜야하는 규칙
 * : 테이블의 각 컬럼마다 값을 기록하는 것에 대한 제약을 설정할 때 사용하는 조건
 * 
 * 1) NOT NULL
 * 	  : NULL 값을 허용하지 않는다.(반드시 값이 있어야한다.)
 * 	  : NOT NULL 제약 조건이 걸린 컬럼에 값을 기록해야하는 경우,
 * 		데이터 삽입/수정/삭제 시 NULL 값을 허용하지 않도록 컬럼 작성하면서 같이 작성해야한다.
 * 	  (컬럼레벨 제약 조건만 가능하다.)
 * 
 * 2) UNIQUE 
 * 	  : 중복을 허용하지 않는다.(유일해야 한다.)(대 소문자 구분안한다.)
 * 	  (컬럼레벨 제약 조건, 테이블 레벨 제약 조건 모두 걸 수 있다.)
 * 	  (UNIQUE 제약 조건을 개별 컬럼 별로 설정하면 컬럼 별로 중복 여부를 확인하고,
 *		여러 컬럼에 동시에 적용하면 컬럼들을 묶어서 중복 여부를 확인한다.
 *		여러 컬럼에 동시에 적용할 경우 반드시 테이블 레벨에서 UNIQUE 제약 조건을 선언해야한다.)
 *
 * 3) CHECK
 * 	  : 지정한 값 외에는 저장하지 못한다.
 * 	  : 값을 저장할 때 컬럼이 지정한 값 외에는
 * 		값이 기록되지 않도록 범위를 제한하는 조건
 * 	  (컬럼레벨 제약 조건, 테이블 레벨 제약 조건 모두 걸 수 있다.)
 * 	  : CHECK(컬럼명 값 또는 조건식)
 * 		Ex) 
 * 		CHECK(GENDER IN('M','F'))
 * 		CHECK(USER_ID IS NOT NULL)
 * 
 * 4) PRIMARY KEY (기본키)
 * 	  : 각 테이블 내에서 해당 ROW를 인식할 수 있는 고유한 값이다.
 * 	  : 각 테이블 내의 한 행에서 그 행을 식별하기위한 고유 값을 갖는 컬럼
 * 	  : 각 테이블 내에서 반드시 1개만 존재한다.
 * 	  : 여러 컬럼을 묶어서 PRIMARY KEY 적용 가능하다.
 * 	  : 기본키 설정하면 기본키 인덱스도 같이 생성된다.
 * 	  : 자바와 다르게 주소 참조가 아닌 내용 참조하다보니 기본 키는 거의 반드시 필요하다.
 * 	  : NOT NULL + UNIQUE 제약 조건
 * 		(NULL값 X, 중복 X)
 * 		(단순히 NOT NULL, UNIQUE 제약 조건 건다고 무조건 기본키 되는건 아니고, 반드시 따로 선언해야한다.)
 * 		(컬럼레벨 제약 조건, 테이블 레벨 제약 조건 모두 걸 수 있다.)
 * 		(참조 중이지 않은 기본키 컬럼의 데이터들은 따로 옵션 걸지 않아도 변경, 삭제 가능하다.)
 * 
 * 5) FOREIGN KEY (외래키, 외부키, 참조키)
 * 	  : 다른 테이블에 저장된 값을 연결해 참조로 갖고 오는 데이터에 지정하는 제약 조건.
 * 	  : 다른 테이블의 컬럼 값을 참조해 참조하는 테이블의 값만 허용한다.
 * 	  : 참조하고자 하는 다른 테이블의 컬럼은 반드시 PRIMARY KEY거나, UNIQUE 제약 조건이 걸려 있어야한다.
 * 		(단순히 어떤 테이블 참조한다하면, 자동으로 그 테이블의 PRIMARY KEY를 참조한다.)
 * 	  : FOREIGN KEY 제약 조건을 통해 다른 테이블과 관계(REALTIONSHIP)가 형성된다.
 * 		(참조할 테이블의 컬럼명과 테이블명은 변경은 가능하고, 참조할 테이블 컬럼에서 참조 중이지 않은 데이터들은 따로 옵션 안줘도 변경 가능하다.)
 * 		(참조할 테이블의 컬럼에 없는 값을 참조 받을 테이블의 컬럼에 추가하는 것은 불가하다.)
 * 		(참조할 테이블의 컬럼은 기본적으로 수정, 삭제가 불가하다.)
 * 	  	(그래서, 삭제를 하려면 참조하는 테이블을 먼저 삭제한 뒤에 참조되는 테이블을 삭제할 수 있다.)
 * 		(FOREIGN KEY 설정할 때, 수정 / 삭제 옵션 줄 필요가 있다. 옵션 설정한 뒤에 참조 대상 테이블의 값이 수정 또는 삭제되면, 참조 받는 테이블의 값도 수정또는 삭제된다.)
 * 	  : CONSTRAINT 제약 조건 명 FOREIGN KEY (참조 받을 테이블의 컬럼명) REFERENCES 참조할 테이블명(참조할 테이블의 컬럼명) ON UPDATE CASCADE ON DELETE CASCADE
 * 		(FOREIGN KEY 뒤 컬럼명에 () 안붙이면 에러 발생)
 * 		(테이블 레벨 제약 조건)
 * 	  : REFERENCES 참조할 테이블명 (참조할 테이블의 컬럼명)
 *		(컬럼 레벨 제약 조건)
 *
 *		{수정 / 삭제 옵션}
 *		: 참조되는 테이블의 컬럼 값이 삭제, 수정될 때 참조하는 값을 어떻게 처리할 것인지 설정하는 옵션.
 * 		: ON UPDATE CASCADE ON DELETE CASCADE
 * 		(참조 대상 테이블의 값이 수정 또는 삭제되면, 참조 받는 테이블의 값도 수정 또는 삭제된다.)
 * 
 * 테이블
 * : 데이터 저장을 위한 틀 (객체)
 * : 데이터들을 2차원의 표 형태로 담을 수 있는 객체
 * : CREATE TABLE 테이블명 (컬럼명 자료타입(크기) 제약조건);
 * (COMMENT 는 테이블 생성할 때 컬럼에 사용하는 주석)
 * SHOW FULL COLUMNS FROM 해당 테이블명; 하면 컬럼의 주석 확인 가능하다.
 * ALTER TABLE 해당 테이블명 MODIFY 컬럼명 자료형(크기) COMMENT '주석 내용'; 하면 테이블 생성 후에도 컬럼 주석 추가 가능하다.
 * 
 * 테이블 생성 시 기본값 설정
 * : CREATE TABLE 테이블명 (컬럼명 자료형(크기) [DEFAULT 기본 값 제약조건]);
 * 단, 기본 값 쓰려면 INSERT 할 때 DEFAULT를 써줘야한다.
 * : INSERT INTO 테이블명 VALUES(DEFAULT, DEFAULT, ...);
 * 
 * 서브쿼리 활용한 테이블 복사
 * : 컬럼명, 데이터 타입, 값, NOT NULL은 복사되지만, 다른 제약 조건은 복사되지 않는다.
 * : CREATE TABLE * AS SELECT 컬럼명 FROM 갖고 올 테이블명 [WHERE ...];
 * 
 * 서브쿼리 활용해 테이블 형식만 복사
 * : 테이블의 값을 제외한 형식 복사
 * : CREATE TABLE * AS SELECT 컬럼명 FROM 갖고 올 테이블명 WHERE 불가능한 조건;
 * (WHERE 절에 말아 안되는 조건을 주어 형식만 가져온다.) 
 * 
 * 서브쿼리 활용해 원하는 컬럼만 복사
 * : CREATE TABLE 테이블명 AS SELECT 컬럼명 FROM 갖고 올 테이블명 [WHERE...];
 * 
 * 서브쿼리 활용해 원하는 컬럼 형식만 복사
 * : CREATE TABLE 테이블명 AS SELECT 컬럼명 FROM 갖고 올 테이블명 WHERE 불가능한 조건;
 * 
 * 컬럼 자료형
 * (메모리, DB 응답시간 최소화 등 여러 이유로 상황에 맞는 적절한 자료형을 쓰는게 가장 효율적이다.)
 * 1. 숫자 : INT, INTEGER, FLOAT, DOUBLE, NUMBER, BIGINT, ...
 * 2. 문자 : CHAR(고정 길이), VARCHAR(가변 길이), TEXT, BLOB, ...
 * Ex) 크기가 10인 CHAR, VARCHAR가 있을 때, 크기가 2인 데이터가 들어오면
 * 		CHAR은 계속 크기 10을 유지하고, VARCHAR는 데이터 크기에 맞춰 크기 2만 사용한다.
 * 3. 날짜 : DATE, TIME, DATETIME, TIMESTAMP(설정된 타임존에 따라 처리), ...
 * 
 * 
 */



-- RANK 함수
-- 행 번호를 매겨본다.
SELECT EMP_NAME, SALARY,
	   RANK () OVER (ORDER BY SALARY DESC) 순위
FROM EMPLOYEE;
-- SALARY 컬럼도 RANK 함수에 의해 정한 순서대로 정렬되어 나온다.

-- 최상위 급여자 3명을 조회한다.
SELECT EMP_NAME, SALARY,
	   RANK () OVER (ORDER BY SALARY DESC) 순위
FROM EMPLOYEE
WHERE 순위 < 4;
-- WHERE문은 SELECT보다 먼저 실행되므로, 에러가 발생한다.

SELECT *
FROM(SELECT EMP_NAME, SALARY, 
		RANK() OVER(ORDER BY SALARY DESC) 순위
		FROM EMPLOYEE) A
WHERE 순위 < 4;
-- INLINE VIEW를 이용해 최상위 급여자 3명 조회한다.

SELECT EMP_NAME, SALARY,
	   RANK () OVER (ORDER BY SALARY DESC) 순위
FROM EMPLOYEE
LIMIT 3;
-- LIMIT로 제한을 걸어 최상위 급여자 3명 조회한다.

-- DENSE_RANK 함수
-- 행 번호를 매겨본다.
SELECT EMP_NAME, SALARY,
		DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위
FROM EMPLOYEE;

-- ROW_NUMBER 함수
SELECT EMP_NAME, SALARY,
		ROW_NUMBER() OVER(ORDER BY SALARY DESC) 번호
FROM EMPLOYEE;

-- 변수 @ROWNO 선언해 1씩 증가시키면서 SELECT
SET @ROWNO := 0; -- @는 변수 선언
SELECT @ROWNO := @ROWNO+1 AS ROWNUM,
		EMP_ID, EMP_NAME,
		SALARY
FROM EMPLOYEE;

-- 부서별 급여 합계가 전체 부서의 급여 총합의
-- 20%보다 많은 부서의 부서명, 부서급여 합계를 조회한다.

-- 단일 행 서브쿼리 활용
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE E 
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > (SELECT SUM(SALARY) * 0.2
					  FROM EMPLOYEE);

-- INLINE VIEW 활용
SELECT *
FROM (SELECT DEPT_CODE, SUM(SALARY) SUMSAL
		FROM EMPLOYEE
		GROUP BY DEPT_CODE) A
WHERE SUMSAL > (SELECT SUM(SALARY) * 0.2 FROM EMPLOYEE);
-- 별칭 A 인라인 뷰에서 WHERE절 조건에 맞는 값을 모두 SELECT 한다.
-- WHERE 절 안에 SELECT 문에서 SUMSAL 쓰면 에러 발생한다.
-- EMPLOYEE 테이블에는 SUMSAL이라는 별칭을 가진 컬럼이 없기 때문이다.
-- (SUMSAL은 INLINE VIEW에 존재하는 별칭이다.)

-- 상호연관 쿼리
-- 직급별 급여 평균보다 많이 받는 사원 정보를 조회한다.
SELECT AVG(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE E 
WHERE SALARY > (SELECT AVG(SALARY)
				FROM EMPLOYEE E2 
				WHERE E.JOB_CODE = E2.JOB_CODE 
				-- 메인쿼리의 JOB_CODE와 서브쿼리의 JOB_CODE가 동일한 행들의
				-- SALARY 평균을 구해서 메인쿼리의 각 행 SALARY와 비교한다. (상관 쿼리)
				);

-- [DDL]

DROP TABLE MEMBER; 
-- MEMBER라는 이름의 테이블이 혹시 존재할까봐 테이블 삭제 먼저 한번 수행.

-- CREATE
-- 테이블 생성
CREATE TABLE MEMBER(
	MEMBER_NO INT,
	MEMBER_ID VARCHAR(20),
	MEMBER_PWD VARCHAR(20),
	MEMBER_NAME VARCHAR(15) COMMENT '회원명'
	-- COMMENT는 주석
);
-- CREATE TABLE 테이블명 (컬럼명 자료형(크기) 제약조건);

SELECT * FROM MEMBER;
-- MEMBER 테이블 생성 확인

SHOW TABLES;
-- MULTI 안에 테이블들 확인

-- 컬럼 주석 확인 1
SHOW FULL COLUMNS FROM MEMBER;

-- 테이블 생성 후 컬럼에 주석 달기
ALTER TABLE MEMBER MODIFY MEMBER_NO INT COMMENT '회원번호';
ALTER TABLE MEMBER MODIFY MEMBER_ID VARCHAR(30) COMMENT '회원 아이디';

SHOW FULL COLUMNS FROM MEMBER;

-- 컬럼 주석 확인 2
SELECT TABLE_NAME, COLUMN_NAME, COLUMN_COMMENT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'MEMBER';

-- 제약 조건
-- 현재 걸린 제약 조건을 확인한다.
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'multi';

-- 1. NOT NULL : NULL 값 허용 안한다.
-- 제약 조건을 추가한 테이블 생성
CREATE TABLE USER_NOT_NULL(
	USER_NO INT NOT NULL, -- 컬럼 레벨 제약 조건
	USER_ID VARCHAR(20) NOT NULL, -- 컬럼 레벨 제약 조건
	USER_PW VARCHAR(20) NOT NULL, -- 컬럼 레벨 제약 조건
	USER_NAME VARCHAR(15) NOT NULL -- 컬럼 레벨 제약 조건
);

-- 테이블 생성 확인
SELECT * FROM USER_NOT_NULL;

-- NOT NULL 제약 조건 잘 들어갔는지 확인
DESC USER_NOT_NULL;

-- 테이블에 값 추가
INSERT INTO USER_NOT_NULL VALUES(1, 'USER01', 'PASS01', '홍길동');

-- 테이블에 데이터가 제대로 들어갔는지 확인
SELECT * FROM USER_NOT_NULL;

-- NULL 값을 추가
INSERT INTO USER_NOT_NULL VALUES(1, NULL, NULL, NULL);
-- NOT NULL 제약조건이 설정되어 있으므로, CANNOT BE NULL 에러 나온다.

-- 2. UNIQUE : 중복을 허용하지 않는다.

-- UNIQUE 제약 조건 개별 컬럼에 설정 : 컬럼별로 중복 여부 확인

-- UNIQUE 제약 조건 걸린 테이블 생성
CREATE TABLE USER_UNIQUE(
	USER_NO INT,
	USER_ID VARCHAR(20) UNIQUE, -- 컬럼레벨 제약 조건
	USER_PWD VARCHAR(20),
	USER_NAME VARCHAR(15),
	UNIQUE(USER_NO) -- 테이블 레벨 제약 조건
);

-- 테이블에 값 추가
INSERT INTO USER_UNIQUE VALUES(1,'USER01','PASS01','홍길동');

-- 테이블에 값이 제대로 들어갔는지 확인
SELECT * FROM USER_UNIQUE;

-- 테이블에 중복 값 추가(USER_NO가 1로 중복)
INSERT INTO USER_UNIQUE VALUES(1,'USER02','PASS02','김길동');
-- SQL Error [1062] [23000]: Duplicate entry '1' for key 'USER_UNIQUE.USER_NO'
-- 중복 값 넣으려했으니 안들어간다.

-- 테이블에 중복 값 추가(USER_ID가 중복)
INSER INTO USER_UNIQUE VALUES(2, 'USER01', 'PASS01', '홍길동');
-- 중복 값 넣으려했으니 에러 나오면서 안들어간다.

-- 테이블에 중복 값 안들어갔는지 확인
SELECT * FROM USER_UNIQUE;

-- UNIQUE 제약 조건 여러개 컬럼에 동시 적용 : 적용한 컬럼 동시에 묶어 중복 확인
-- (이 경우, 반드시 테이블 레벨에서 UNIQUE 제약 조건 적용 필요)
-- UNIQUE 제약 조건 걸린 테이블 생성
CREATE TABLE USER_UNIQUE2(
	USER_NO INT,
	USER_ID VARCHAR(20),
	USER_PWD VARCHAR(20),
	USER_NAME VARCHAR(15),
	UNIQUE(USER_ID, USER_NO) -- 테이블 레벨 제약 조건 선언
);
-- UNIQUE 제약 조건 적용 확인
DESC USER_UNIQUE2;

-- 테이블에 값 추가
INSERT INTO USER_UNIQUE2 VALUES(1, 'USER01', 'PASS01', '홍길동');
INSERT INTO USER_UNIQUE2 VALUES(1, 'USER02', 'PASS02', '김길동');
INSERT INTO USER_UNIQUE2 VALUES(2, 'USER01', 'PASS03', '박길동');
INSERT INTO USER_UNIQUE2 VALUES(2, 'USER02', 'PASS04', '최길동');
-- 각 컬럼별로 중복 여부를 찾는게 아니라 여러 컬럼 묶어서 중복 여부를 확인하니,
-- 이상없이 값들이 테이블에 추가됐다.
-- 각 컬럼별로 중복 여부를 찾았으면, 에러 발생했다.(USER_NO, USER_ID 모두 개별 컬럼으로는 중복 값을 갖고 있다.)

-- 테이블에 중복 없는 값들이 제대로 들어갔는지 확인
SELECT * FROM USER_UNIQUE2;

-- 3. CHECK : 지정한 값만 받겠다.

-- CHECK 제약 조건 걸린 테이블 작성
CREATE TABLE USER_CHECK(
	USER_NO INT,
	USER_ID VARCHAR(20),
	USER_PWD VARCHAR(15),
	USER_NAME VARCHAR(15),
	-- GENDER VARCHAR(3) CHECK(GENDER IN('남', '여')) -- 컬럼 레벨 제약 조건
	GENDER VARCHAR (3),
	CONSTRAINT CK_GENDER CHECK(GENDER IN('남', '여')) -- 테이블 레벨 제약 조건
	-- CONSTRAINT 뒤의 CHECK(제약 내용)을 확인할 제약조건의 새로운 이름(?) CHECK(제약 내용) 
	
);

-- 테이블 생성 확인
SELECT * FROM USER_CHECK;

-- 테이블에 값 추가
INSERT INTO USER_CHECK VALUES(1, 'USER01', 'PASS01', '홍길동', '남');
-- CHECK 제약 조건을 지켰기때문에 정상적으로 값이 추가된다.
INSERT INTO USER_CHECK VALUES(2, 'USER02', 'PASS02', '김길동', '남자');
-- SQL Error [3819] [HY000]: Check constraint 'CK_GENDER' is violated.
-- CHECK 제약 조건에서 지정한 값 외의 값들은 받지 않는다.
INSERT INTO USER_CHECK VALUES(2, 'USER02', 'PASS02', '김기동', 'M');
-- SQL Error [3819] [HY000]: Check constraint 'CK_GENDER' is violated.
-- CHECK 제약 조건에서 지정한 값 외의 값들은 받지 않는다.

-- CHECK 제약 조건을 지킨 값들만 들어갔는지 확인
SELECT * FROM USER_CHECK;

-- 제약 조건 확인
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'USER_CHECK';
-- 테이블 생성하면서 설정한 제약조건의 이름(CK_GENDER)가 보인다.
-- 나중에 제약 조건을 변경하거나 할 때 이 이름을 사용한다.
-- 따로 설정안하면 제약조건의 이름은 기본적으로 컬럼명이 들어간다.

-- CHECK 제약 조건을 부등호로 표기
-- CONSTRAINT 이용해 CHECK 제약 조건 걸린 테이블 생성
CREATE TABLE TEST_CHECK(
	TEST_DATA INT,
	CONSTRAINT CK_TEST_DATA CHECK(TEST_DATA > 0 AND TEST_DATA < 100)
	-- 테이블 레벨 제약 조건
	-- 여기서, CK_TEST_DATA는 설정한 CHECK 제약 조건의 이름
);

-- 테이블에 CHECK 제약 조건 범위 내의 값 추가
INSERT INTO TEST_CHECK VALUES(10);
INSERT INTO TEST_CHECK VALUES(50);
-- 정상적으로 값이 추가된다.

-- 테이블에 CHECK 제약 조건 범위 밖의 값 추가
INSERT INTO TEST_CHECK VALUES(-10);
-- SQL Error [3819] [HY000]: Check constraint 'CK_TEST_DATA' is violated.
-- CHECK 제약 조건 지정 값 외에는 안받는다.
INSERT INTO TEST_CHECK VALUES(-1);
-- SQL Error [3819] [HY000]: Check constraint 'CK_TEST_DATA' is violated.
-- CHECK 제약 조건 지정 값 외에는 안받는다.
INSERT INTO TEST_CHECK VALUES(110);
-- SQL Error [3819] [HY000]: Check constraint 'CK_TEST_DATA' is violated.
-- CHECK 제약 조건 지정 값 외에는 안받는다.

-- 테이블에 제약 조건 범위 내의 값이 잘 들어갔는지 확인
SELECT * FROM TEST_CHECK;

-- 4. PRIMARY KEY : 각 테이블 내에서 해당 행을 식별하기 위한 고유 값을 갖는 컬럼
-- PRIMARY KEY 제약 조건 걸린 테이블 생성
CREATE TABLE USER_PK_TABLE(
	USER_NO INT PRIMARY KEY, -- 컬럼 레벨 제약 조건
	USER_ID VARCHAR(20) UNIQUE NOT NULL, -- 컬럼 레벨 제약 조건
	USER_PWD VARCHAR(20) NOT NULL, -- 컬럼 레벨 제약 조건
	USER_NAME VARCHAR(15) NOT NULL -- 컬럼 레벨 제약 조건
);

-- PRIMARY KEY 제약 조건이 제대로 설정됐는지 확인
DESC USER_PK_TABLE;

-- 테이블에 값 추가
INSERT INTO USER_PK_TABLE VALUES(1, 'USER01', 'PASS01', '홍길동');
INSERT INTO USER_PK_TABLE VALUES(2, 'USER02', 'PASS02', '강길동');
INSERT INTO USER_PK_TABLE VALUES(2, 'USER03', 'PASS03', '장길동');
-- SQL Error [1062] [23000]: Duplicate entry '2' for key 'USER_PK_TABLE.PRIMARY'
-- PRIMARY KEY 제약 조건 위배(여기서는 중복 값이 들어갔다.)
INSERT INTO USER_PK_TABLE VALUES(NULL, 'USER02', 'PASS02', '강길동');
-- SQL Error [1048] [23000]: Column 'USER_NO' cannot be null
-- PRIMARY KEY 제약 조건 위배(여기서는 NULL 값을 사용했다.)
INSERT INTO USER_PK_TABLE VALUES(3, 'USER02', 'PASS02', '강길동');
-- SQL Error [1062] [23000]: Duplicate entry 'USER02' for key 'USER_PK_TABLE.USER_ID'
-- 여기서는 UNIQUE와 NOT NULL 제약 조건 걸린 USER_ID 컬럼에 USER02라는 중복 값 들어가서 에러 발생

-- 여러 컬럼에 PRIMARY KEY 제약 조건 적용
CREATE TABLE USER_PK_TABLE2(
	USER_NO INT,
	USER_ID VARCHAR(20) UNIQUE,
	USER_PWD VARCHAR(20) NOT NULL,
	USER_NAME VARCHAR(15) NOT NULL,
	CONSTRAINT PK_USER_NO2 PRIMARY KEY(USER_NO, USER_ID)
);

/* INSERT 결과
 * 1, USER01 => INSERT 성공
 * 2, USER02 => INSERT 성공
 * 1, USER03 => INSERT 성공
 * (두 컬럼을 묶어서 기본키로 쓰기 때문에_
 * 2, USER01 => INSERT 실패
 * (USER_ID에 UNIQUE 제약 조건 있기 때문에)
 */

-- 실습 때문에 MEMBER 테이블 삭제했다.
DROP TABLE MEMBER;

-- 5. FOREIGN KEY (참조키, 외래키, 외부키)
-- 참조 대상 테이블 생성
CREATE TABLE USER_GRADE(
	GRADE_CODE INT PRIMARY KEY,
	GRADE_NAME VARCHAR(20) NOT NULL
);

-- 테이블에 값 추가
INSERT INTO USER_GRADE VALUES(1, '일반 회원');
INSERT INTO USER_GRADE VALUES(2, 'VIP');
INSERT INTO USER_GRADE VALUES(3, 'VVIP');
INSERT INTO USER_GRADE VALUES(4, 'VVVIP');

-- 테이블에 제대로 값이 들어갔는지 확인
SELECT * FROM USER_GRADE;

-- 참조 대상 테이블로부터 값 받아올 테이블 1개 생성
CREATE TABLE USER_FOREIGN_KEY(
	USER_NO INT PRIMARY KEY,
	USER_ID VARCHAR(20),
	USER_PWD VARCHAR(20),
	USER_NAME VARCHAR(15),
	-- GRADE_CODE INT REFERENCES USER_GRADE(GRADE_CODE)
	-- GRADE_CODE 컬럼은 USER_GRADE 테이블의 GRADE_CODE를 참조한다.
	-- 컬럼 레벨 제약 조건
	GRADE_CODE INT,
	CONSTRAINT FK_GRADE_CODE FOREIGN KEY (GRADE_CODE) REFERENCES USER_GRADE(GRADE_CODE)
	-- CONSTRAINT 제약 조건 명 FOREIGN KEY (참조 받을 테이블의 컬럼명) REFERENCES 참조할 테이블명(참조할 테이블의 컬럼명)
	-- 테이블 레벨 제약 조건
);

-- 제약 조건 설정되었는지 확인
DESC USER_FOREIGN_KEY;

-- 테이블 생성 확인
SELECT * FROM USER_FOREIGN_KEY;

-- 참조하는 USER_GRADE 테이블의 GRADE_CODE 컬럼에 있는 데이터 범위 내의 값 추가
INSERT INTO USER_FOREIGN_KEY VALUES(1,'123','321','홍길동',2);
INSERT INTO USER_FOREIGN_KEY VALUES(2,'ABC','ABC1','김길동',4);
INSERT INTO USER_FOREIGN_KEY VALUES(3,'456','6541','박길동',1);
INSERT INTO USER_FOREIGN_KEY VALUES(4,'DEF','DEF1','최길동',3);
INSERT INTO USER_FOREIGN_KEY VALUES(5,'QWE','QWE1','장길동',1);

-- 테이블에 제대로 값 들어갔는지 확인
SELECT * FROM USER_FOREIGN_KEY;


INSERT INTO USER_FOREIGN_KEY VALUES(6,'ASD','ASD1','이길동',10);
-- SQL Error [1452] [23000]: Cannot add or update a child row: a foreign key constraint fails
-- 외래키로 지정된 GRADE_CODE는 참조하는 USER_GRADE 테이블의 GRADE_CODE 컬럼에 있는 데이터만 넣을 수 있기 때문이다.

SELECT * FROM USER_FOREIGN_KEY JOIN USER_GRADE USING(GRADE_CODE); -- USING으로 조인하면 순서가 무작위
SELECT * FROM USER_FOREIGN_KEY JOIN USER_GRADE ON(USER_GRADE.GRADE_CODE = USER_FOREIGN_KEY.GRADE_CODE);
-- ON으로 조인하면 첫번째 테이블 옆에 두번째 테이블이 붙어서 순서대로 나온다.


DELETE FROM USER_GRADE
WHERE GRADE_CODE = 4;
-- SQL Error [1451] [23000]: Cannot delete or update a parent row: a foreign key constraint fails
-- 참조되는 테이블의 컬럼은 기본적으로 수정, 삭제가 불가하다.
-- (여기서는 USER_GRADE 테이블의 GRADE_CODE 컬럼)
-- 그래서, 삭제를 하려면 참조하는 테이블을 먼저 삭제한 뒤에 참조되는 테이블을 삭제할 수 있다.
-- (즉, USER_FOREIGN_KEY 테이블을 삭제해야 USER_GRADE 테이블을 삭제할 수 있다.)

-- 수정 / 삭제 옵션
-- 참조되는 테이블의 컬럼 값이 수정, 삭제 될 때
-- 참조하는 값을 어떻게 처리할 것인지 설정하는 옵션.

-- 삭제 옵션 실습 위해 만들어 놓은거 삭제
DROP TABLE USER_FOREIGN_KEY;
DROP TABLE USER_GRADE;
-- 위에 만들어 놓은 코드로 USER_GRADE테이블 다시 생성

CREATE TABLE USER_FOREIGN_KEY(
	USER_NO INT PRIMARY KEY,
	USER_ID VARCHAR(20),
	USER_PWD VARCHAR(20),
	USER_NAME VARCHAR(15),
	-- GRADE_CODE INT REFERENCES USER_GRADE(GRADE_CODE)
	-- GRADE_CODE 컬럼은 USER_GRADE 테이블의 GRADE_CODE를 참조한다.
	-- 컬럼 레벨 제약 조건
	GRADE_CODE INT,
	CONSTRAINT FK_GRADE_CODE FOREIGN KEY (GRADE_CODE) 
	REFERENCES USER_GRADE(GRADE_CODE) ON UPDATE CASCADE ON DELETE CASCADE
	-- CONSTRAINT 제약 조건 명 FOREIGN KEY 참조할 테이블의 컬럼명 REFERENCES 참조할 테이블명(참조할 테이블의 컬럼명) ON UPDATE CASCADE ON DELETE CASCADE
	-- 테이블 레벨 제약 조건
	-- ON UPDATE CASCADE ON DELETE CASCADE 는 삭제 수정 옵션을 준 것이다.
);

-- 테이블 제대로 생성됐는지 확인
SELECT * FROM USER_FOREIGN_KEY;
SELECT * FROM USER_GRADE;
-- INSERT는 앞에 작성한 코드 재활용

-- 참조 대상 테이블의 값을 수정
UPDATE USER_GRADE
SET GRADE_CODE = 10
WHERE GRADE_CODE = 1;
-- GRADE_CODE 컬럼 내에 1인 값들을 10으로 수정한다.

-- 수정 잘 됐는지 확인
SELECT * FROM USER_FOREIGN_KEY;
SELECT * FROM USER_GRADE;
-- 참조 대상 테이블의 값이 수정되면, 참조 받는 테이블의 값도 수정된다.

-- 참조 대상 테이블의 값 삭제
DELETE FROM USER_GRADE
WHERE GRADE_CODE = 4;

-- 삭제 잘 됐는지 확인
SELECT * FROM USER_FOREIGN_KEY;
SELECT * FROM USER_GRADE;
-- 참조 대상 테이블의 값이 삭제되면, 참조 받는 테이블의 값도 삭제된다.

-- 서브쿼리 활용한 테이블 만들기
-- :컬럼명, 데이터 타입, 값, NOT NULL은 복사되지만, 다른 제약 조건은 복사되지 않는다.
CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;
-- CREATE TABLE 테이블명 AS SELECT 컬럼명 FROM 갖고 올 테이블명 [WHERE ...];

SELECT * FROM EMPLOYEE_COPY;

DESC EMPLOYEE;
DESC EMPLOYEE_COPY;

-- 테이블의 형식만 복사
-- : 테이블의 값을 제외한 형식 복사
-- (WHERE 절에 말아 안되는 조건을 주어 형식만 가져온다.)
CREATE TABLE EMPLOYEE_COPY2
AS SELECT * FROM EMPLOYEE WHERE 1=2;
-- CREATE TABLE 테이블명 AS SELECT 컬럼명 FROM 갖고 올 테이블명 WHERE 불가능한 조건;

-- 특정 컬럼만 복사
CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, SALARY '급여' FROM EMPLOYEE;
-- CREATE TABLE 테이블명 AS SELECT 컬럼명 FROM 갖고 올 테이블명 [WHERE...];

SELECT * FROM EMPLOYEE_COPY3;

-- 테이블 생성 시 기본값 설정
CREATE TABLE DEFAULT_TABLE(
	COL1 VARCHAR(30) DEFAULT '없음', -- DEFAULT 기본값
	COL2 DATE DEFAULT (CURRENT_DATE), -- DEFAULT 기본값
	COL3 DATETIME DEFAULT CURRENT_TIMESTAMP -- DEFAULT 기본값
);
-- CREATE TABLE 테이블명 (컬럼명 자료형(크기) DEFAULT 기본 값 제약조건);


INSERT INTO DEFAULT_TABLE VALUES(DEFAULT, DEFAULT, DEFAULT);
-- 기본 값 쓰려면 INSERT 할 때 DEFAULT를 써줘야한다.
-- INSERT INTO 테이블명 VALUES(DEFAULT, DEFAULT, ...);

SELECT * FROM DEFAULT_TABLE;

-- DEFAULT 설정 확인
DESC DEFAULT_TABLE;
