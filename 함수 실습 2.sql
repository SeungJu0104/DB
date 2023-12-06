SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;
SELECT * FROM JOB;
/* 실습 1
 * 근속 년수가 25년 이상인 사원들의
 * 사번, 사원명, 부서코드, 입사일 조회한다.
 */
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_CODE 부서코드, HIRE_DATE 입사일
FROM EMPLOYEE
WHERE DATE_ADD(HIRE_DATE, INTERVAL 25 YEAR) <= NOW();
-- (입사일로부터 25년 지난 연도가 현재 연도보다 작으면 입사 후 25년이 지난 것이다.)

/* 실습 2
 * 부서별 총 인원, 급여 합계, 급여 평균, 최대 급여, 최소 급여를 조회한다.
 * 급여 평균, 급여 합계는 백의자리까지 버림 처리한다.
 */
SELECT DEPT_CODE, COUNT(*), TRUNCATE(SUM(SALARY), -3), TRUNCATE(AVG(SALARY), -3), MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;
-- EMPLOYEE 테이블을 가져와 DEPT_CODE 기준 소그룹을 묶은 뒤,
-- SELECT 문 내용대로 값들을 조회하고,
-- DEPT_CODE 기준으로 오름차순 정렬한다.(DEPT_CODE는 작성한 SELECT문의 첫번째에 위치하므로 1이다.)

/* 실습 3
 * 직급 코드, 직급별 보너스를 받는 사원의 수를 조회한다.
 * 직급 코드 순으로 내림차순 정렬
 */
SELECT JOB_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1 DESC;
-- EMPLOYEE 테이블을 가져와 JOB_CODE 별로 소그룹으로 묶은 후,
-- JOB_CODE와 소그룹 별 BONUS의 행 갯수를 카운트 한 뒤,
-- JOB_CODE 기준으로 내림차순 정렬한다.

/* 실습 4
 * 남성 직원과 여성 직원들의 수를 조회한다.
 * GROUP BY 에서 함수도 사용할 수 있다.
 * 남성 여성 구별은 EMP_NO를 사용한다.
 */
SELECT SUBSTR(EMP_NO, 8, 1) 남여구분, COUNT(*) 직원수
-- 만약 여기에 EMP_NAME을 추가하면 열의 개수가 맞지 않아 에러 발생한다.
-- GROUP BY 통해 돌려주는 열은 2개인데, EMP_NAME은 2개보다 많은 열을 갖고 있기 때문이다.
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1)
-- 8번째 자리가 1인지 2인지에 따라 소그룹으로 묶는다.

/* 실습 5
 * 부서별 그룹의 급여 합계가 900만원을 초과하는 부서의
 * 부서코드, 급여 합계를 조회한다.
 */
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 9000000; -- 각 부서별 급여 합계가 900만원 초과하는 부서
-- EMPLOYEE 테이블을 가져와
-- DEPT_CODE에 따라 소그룹으로 묶은 후
-- 부서별 급여 합계(SUM(SALARY))가 900만원 이상인 조건에 맞춰
-- DEPT_CODE 와 해당 그룹의 급여 합계를 SELECT 한다.


	 

	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
