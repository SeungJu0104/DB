/* 실습 1
 * EMPLOYEE 테이블의 직원 급여 정보와 SAL_GRADE 테이블의 급여 등급을 합쳐서
 * 사번, 사원명, 급여, 등급 기준 최소급여, 최대 급여를 조회한다.
 */
SELECT * FROM EMPLOYEE;
SELECT * FROM SAL_GRADE;
-- 1. ON()
SELECT EMP_ID, EMP_NAME, SALARY, MAX_SAL, MIN_SAL
FROM EMPLOYEE
JOIN SAL_GRADE ON (EMPLOYEE.SAL_LEVEL = SAL_GRADE.SAL_LEVEL);
-- 2. USING()
SELECT EMP_ID, EMP_NAME, SALARY, MAX_SAL, MIN_SAL
FROM EMPLOYEE
JOIN SAL_GRADE USING (SAL_LEVEL);
-- SELECT문에 공통컬럼이 쓰이지 않았기 때문에, SELECT문에도 어떤 테이블의 컬럼인지 따로 명시 안해도 된다.

/* 실습 2
 * 직급이 대리이면서 아시아 지역에서 근무하는 사원의
 * 사번, 사원명, 직급명, 부서명, 근무지역명, 급여를 조회한다.
 */
-- 1)
SELECT EMP_ID 사번, EMP_NAME 사원명, JOB_NAME 직급명, DEPT_TITLE 부서명, SALARY 급여
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION L ON (LOCATION_ID = LOCAL_CODE)
JOIN JOB J USING (JOB_CODE)
WHERE E.JOB_CODE = (SELECT JOB_CODE FROM JOB WHERE JOB_NAME = '대리') AND 
	  D.LOCATION_ID IN (SELECT LOCAL_CODE FROM LOCATION WHERE LOCAL_NAME LIKE 'ASIA%');
-- 여기서 IN 안쓰고 = 쓰면 SELECT 문으로 갖고오는건 3개의 ROW인데, 담을 수 있는건 단일 행이기 때문에
-- = 쓰면 안돌아간다. 그래서 IN으로 3개 중 아무거나 있어도 돌아가도록 만들었다.
-- (JOB_CODE SELECT 문은 어차피 결과 값이 하나기 때문에 문제 없다.)
-- 이 문제에서는 JOIN 순서가 영향을 주진 않는다.
-- 다만, USING을 쓰면 조인한 테이블에서 컬럼 순서가 무작위로 섞일 수 있다.

-- 2)
SELECT EMP_ID 사번, EMP_NAME 사원명, JOB_NAME 직급명, DEPT_TITLE 부서명, SALARY 급여
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION L ON (LOCATION_ID = LOCAL_CODE)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE JOB_NAME = '대리' AND LOCAL_NAME LIKE 'ASIA%';
	 
-- 3) 조인 조건에 넣어서 조인될 테이블 자체를 원하는 결과만 갖고 있도록 만든다.
SELECT EMP_ID 사번, EMP_NAME 사원명, JOB_NAME 직급명, DEPT_TITLE 부서명, SALARY 급여
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION L ON (LOCATION_ID = LOCAL_CODE AND LOCAL_NAME LIKE 'ASIA%')
-- LOCATION_ID와 LOCAL_CODE가 일치하고, 
-- LOCAL_NAME 중 ASIA라는 문자를 포함한 LOCATION 테이블의 데이터만 이전에 조인한 테이블 결과에 붙는다.
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE AND JOB_NAME = '대리');
-- JOB_CODE가 일치하고, JOB_NAME이 '대리'인 JOB 테이블의 데이터가 이전에 조인한 테이블 결과에 붙는다.