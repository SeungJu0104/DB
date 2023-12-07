/* 실습 1
 * '해외영업2부'인 부서의 부서코드를 찾고,
 * 해당 부서의 사원들 중 급여를 200만원이상 받는 직원의
 * 사번, 사원명, 급여를 조회하시오.
 */

-- SELECT * FROM DEPARTMENT;
-- SELECT * FROM EMPLOYEE;
SELECT EMP_ID 사번, EMP_NAME 사원명, SALARY 급여
FROM EMPLOYEE
WHERE (DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE = '해외영업2부'))
		-- DEPT_CODE = 'D6'
		AND (SALARY >= 2000000);

/* 실습 2
 * 실습 1을 참고하여
 * 부서가 '해외영업2부'이거나 급여가 200만원 이상인 직원의
 * 사번, 사원명, 급여를 조회하시오.
 */

SELECT EMP_ID AS 사번, EMP_NAME AS 사원명, SALARY AS 급여
FROM EMPLOYEE
WHERE ((DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE = '해외영업2부'))
		-- DEPT_CODE = 'D6'
		OR SALARY >= 2000000);





