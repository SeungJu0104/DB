SELECT * FROM EMPLOYEE;
/* 실습 1
 * 사원명과 주민번호를 조회한다.
 * 단, 주민번호 9번째 자리부터 끝까지는 * 문자로 채운다.
 */
SELECT EMP_NAME 사원명, RPAD(SUBSTR(EMP_NO, 1, 10), 14, '*') 주민번호 
FROM EMPLOYEE;

/* 실습 2
 * 부서코드가 D5, D9인 직원들 중에서 2004년에 입사한 직원의 수를 조회한다.
 * 사번 사원명 부서코드 입사일
 */
SELECT COUNT(EMP_ID)
FROM EMPLOYEE
WHERE (DEPT_CODE IN ('D5', 'D9')) AND (EXTRACT(YEAR FROM HIRE_DATE) = 2004);

/* 실습 3
 * 직원명, 입사일, 입사한 달의 근무 일수를 조회한다.
 * 단, 주말도 포함한다.
 * LAST_DAY() : 주어진 날짜의 해당 월의 마지막 날 반환
 */
SELECT EMP_NAME 직원명, HIRE_DATE 입사일, DATEDIFF(LAST_DAY(HIRE_DATE), HIRE_DATE) AS '입사 달의 근무 일수'
FROM EMPLOYEE;

/* 실습 4
 * 직원명, 부서코드, 생년월일, 나이를 조회한다.
 * 단, 생년월일은 주민번호에서 추출해서 00년 00월 00일로 출력한다.
 * 나이는 주민번호에서 추출해 날짜데이터로 변환한 뒤, 계산한다.
 */
SELECT EMP_NAME 직원명, DEPT_CODE 부서코드, FORMAT(SUBSTR(EMP_NO, 1, 6), '__년 __월 __일')
FROM EMPLOYEE;

SELECT STR_TO_DATE(SUBSTR(EMP_NO,1 ,6), '%y%m%d')
FROM EMPLOYEE;

SELECT EXTRACT(YEAR FROM SUBSTR(EMP_NO,1 ,6))
FROM EMPLOYEE;

/* 실습 5
 * 부서코드가 D5이면 총무부, D6이면 기획부, D9면 영업부로 처리하시오.
 * 단, 부서코드가 D5, D6, D9인 직원만 조회합니다.
 * CASE 함수를 사용한다.
 */
SELECT 
	CASE DEPT_CODE IN ('D5', 'D6', 'D9')
		WHEN(DEPT_CODE = 'D5') THEN '총무부'
		WHEN(DEPT_CODE = 'D6') THEN '기획부'
		WHEN(DEPT_CODE = 'D9') THEN '영업부'
	END '부서코드'
FROM EMPLOYEE;



