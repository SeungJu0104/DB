/* 실습 1
 * EMPLOYEE 테이블에서 주민번호가 잘못 표기된 사원들이 있다.
 * 해당 사원을 찾아 사번 순으로 각각 주민번호 앞자리를 '621230', '631126', '850705'로
 * 변경하는 UPDATE 문 구성하시오.
 */

-- 잘못 표기된 사원 조회
SELECT EMP_ID, EMP_NO
FROM EMPLOYEE E 
WHERE SUBSTR(EMP_NO, 5 ,2) > 31;

UPDATE EMPLOYEE SET EMP_NO = CONCAT('621230', SUBSTR(EMP_NO, 7)) WHERE EMP_ID = 200;
UPDATE EMPLOYEE SET EMP_NO = CONCAT('631126', SUBSTR(EMP_NO, 7)) WHERE EMP_ID = 201;
UPDATE EMPLOYEE SET EMP_NO = CONCAT('850705', SUBSTR(EMP_NO, 7)) WHERE EMP_ID = 214;
-- 생년월일만 수정하고, 나머지 부분은 가져와서 붙인다.

SELECT EMP_ID, EMP_NO
FROM EMPLOYEE E 
WHERE EMP_ID IN (200, 201, 214);

COMMIT;

/* 실습 2
 * 사번, 이름, 직급명, 부서명, 근무 지역을 조회할 수 있는 V_RES_EMP 라는 VIEW를 만들어,
 * VIEW를 통해 그 결과를 조회한다.
 */
SELECT * FROM EMPLOYEE;
SELECT * FROM LOCATION;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;
-- 1. 서브쿼리 준비
SELECT EMP_ID 사번, EMP_NAME 이름, JOB_NAME 직급명, DEPT_TITLE 부서명, LOCAL_NAME 근무지역
FROM EMPLOYEE E 
	LEFT JOIN DEPARTMENT D ON (DEPT_ID = DEPT_CODE)
	LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
	LEFT JOIN JOB ON (E.JOB_CODE = JOB.JOB_CODE);

-- 2. VIEW 생성
CREATE OR REPLACE VIEW V_RES_EMP(사번, 이름, 부서명, 근무지역)
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
	FROM EMPLOYEE E
		LEFT JOIN DEPARTMENT D ON (DEPT_ID = DEPT_CODE)
		LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
		LEFT JOIN JOB ON (E.JOB_CODE = JOB.JOB_CODE);

-- 3. 결과 조회
SELECT * FROM V_RES_EMP;

-- VIEW에 CASE문을 쓸 수 있을까?
CREATE OR REPLACE VIEW V_RES_EMP2(사번, 이름, 직급명, 부서명, 근무지역)
AS 
	SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_TITLE,
		CASE LOCAL_NAME
			WHEN 'ASIA1' THEN '동아시아'
			WHEN 'ASIA2' THEN '서아시아'
			WHEN 'ASIA3' THEN '중앙아시아'
			WHEN 'EU' THEN '유럽'
		END
	FROM EMPLOYEE E 
	LEFT JOIN DEPARTMENT D ON (DEPT_ID = DEPT_CODE)
	LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
	LEFT JOIN JOB USING (JOB_CODE);

SELECT * FROM V_RES_EMP2;




