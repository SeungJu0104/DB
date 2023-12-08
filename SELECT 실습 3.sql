SELECT * FROM EMPLOYEE;
/* 실습 1
 * 모든 사원의 사번, 사원명, 관리자 사번, 관리자명을 조회한다.
 * 관리자가 없다면, '없음' 조회한다.
 * 단, SELECT문의 서브쿼리를 사용한다.(JOIN X)
 */
SELECT EMP_ID 사번, EMP_NAME 사원명, MANAGER_ID AS '관리자 사번',
		IFNULL((SELECT EMP_NAME FROM EMPLOYEE E2 WHERE E.MANAGER_ID = E2.EMP_ID), '없음') 관리자명
		-- EMP_ID는 기본키기 때문에 중복 없고, IFNULL문(여기선 상관쿼리문)은 하나의 값만을 결과로 가져오기 때문에 단일 행 서브쿼리이다.
		-- 상관쿼리 + 단일 행 서브쿼리 ==> 스칼라 서브쿼리 : SELECT문에서 주로 사용하고, SELECT LIST라고도 부른다.
FROM EMPLOYEE E 
ORDER BY 4;

/* 실습 2
 * MEMBER 테이블을 생성해, 사용자 정보를 받을 수 있는 테이블 객체를 생성한다.
 * 회원번호 : INT, 기본키
 * 회원아이디 : VARCHAR, 중복 불가, 필수 입력사항
 * 회원 비밀번호 : VARCHAR, 필수 입력 사항
 * 회원 이름 : VARCHAR
 * 성별 : VARCHAR, M / F만 입력
 * 회원 연락처 : VARCAHR
 * 생년월일 : VARCHAR
 * 각 컬럼의 크기와 이름은 임의로 처리하고,
 * 생성 후 회원정보는 5개 이상 INSERT 후 확인한다.
 */
CREATE TABLE MEMBER (
	M_NO INT ,
	M_ID VARCHAR(20) NOT NULL,
	M_PW VARCHAR(20) NOT NULL,
	M_NAME VARCHAR(20),
	M_SEX VARCHAR(5),
	M_PHONE VARCHAR(30),
	M_BIRTH VARCHAR(30),
	CONSTRAINT PK_M_NO PRIMARY KEY(M_NO),
	CONSTRAINT UK_M_ID UNIQUE(M_ID),
	CONSTRAINT CK_M_SEX CHECK(M_SEX IN ('M', 'F'))
	-- NOT NULL은 테이블 레벨 제약 조건 선언 안된다.
	-- 테이블 레벨에서 NOT NULL UNIQUE 해도 안된다.
);

INSERT INTO MEMBER VALUES(1, 'TEST01', 'TEST01', '김소현', 'M', '010-1111-1111', '900101');
INSERT INTO MEMBER VALUES(2, 'TEST02', 'TEST01', '김소현', 'M', '010-1111-1111', '900101');
INSERT INTO MEMBER VALUES(3, 'TEST03', 'TEST03', '김소현', 'F', '010-1111-1111', '900101');
INSERT INTO MEMBER VALUES(4, 'TEST04', 'TEST04', '김소현', 'F', '010-1111-1111', '900101');
INSERT INTO MEMBER VALUES(5, 'TEST05', 'TEST05', '김동욱', 'M', '010-1111-1111', '900110');
INSERT INTO MEMBER VALUES(6, 'test05', 'TEST05', '김동욱', 'M', '010-1111-1111', '900110');

SELECT * FROM MEMBER;
DROP TABLE MEMBER;
