SELECT * FROM EMPLOYEE;

/* 실습 1
 * 사원 중 이메일 아이디가 5글자를 초과하는 사원의
 * 사원명, 사번, 이메일 정보를 조회한다.
 */
SELECT EMP_NAME 사원명, EMP_NO 사번, EMAIL 이메일 FROM EMPLOYEE
WHERE EMAIL LIKE '______%@%';
-- (5글자 초과이므로 _를 5개 넣고, 그 뒤에 %를 넣어 6글자 이상인 이메일 아이디도 검색한다.)
-- (@ 뒤에 % 안붙이면 제대로 검색 안된다.)

/* 실습 2
 * 사원들의 사원명, 이메일 조회하는데
 * 이메일은 아이디 부분만 조회한다.
 * 
 * 조회결과는 아래와 같이 보여야한다.
 * 홍길동 hong_gd
 */

SELECT EMP_NAME 사원명, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) AS 'EMAIL ID'
FROM EMPLOYEE;

SELECT EMP_NAME 사원명, EMAIL 
FROM EMPLOYEE
WHERE SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1);
-- WHERE절은 조건에 맞는 값을 비교하는 것이기 때문에 저렇게 WHERE절을 쓰면
-- SUBSTR의 결과 값으로 단순히 정수 값만 나오기 때문에 비교할 대상이 없어 에러가 발생한다.

/* 실습 3
 * 사원의 주민번호를 확인하여
 * 생년, 생월, 생일을 각각 조회하시오.
 * 
 * [출력 예시]
 * 이름  | 생년  | 생월  | 생일
 * 홍길동 | 00년  | 00월  | 00일
 */
SELECT EMP_NAME 이름,
		CONCAT(SUBSTR(EMP_NO, 1,2), '년') 생년,
		CONCAT(SUBSTR(EMP_NO, 3,2), '월') 생월,
		CONCAT(SUBSTR(EMP_NO,5,2), '일') 생일
FROM EMPLOYEE;

/* 실습 4
 * 사원의 사번, 사원명, 이메일, 주민번호를 조회하여
 * 이메일은 '@'전 까지, 주민번호는 7번째 자리 이후부터 '*'(000000-1******)로 처리하여 조회한다.
 */
SELECT EMP_ID 사번, EMP_NAME 사원명,
	   SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) AS '이메일',
	   RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') AS '주민번호',
	   -- CONCAT(SUBSTR(EMP_NO, 1, 8), '******') AS '주민번호'
	   -- 주민번호에 *을 붙여서 출력하는 또다른 방법
FROM EMPLOYEE;

/* 실습 5
 * 현재 근무하는 여성 사원의 사번, 사원명, 직급코드를 조회한다.
 * ENT_YN : 현재 근무 여부를 파악하는 컬럼(퇴사는 Y, 재직 중은 N)
 * WHERE 절에 함수 사용 가능하다.
 */
SELECT EMP_ID 사번, EMP_NAME 사원명, JOB_CODE 직급코드
FROM EMPLOYEE
WHERE ENT_YN = 'N' AND SUBSTR(EMP_NO, 8, 1) = '2';

/* 실습 6
 * 모든 직원들의 사번, 사원명, 부서코드, 직급코드, 재직 여부, 관리자 여부를 조회한다.
 * ENT_YN : 재직여부 판단하는 필드. Y면 퇴사자, N이면 재직자
 * MANAGER_ID가 별도 값이 있으면 사원, NULL값이면 관리자
 */
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_CODE 부서코드, JOB_CODE 직급코드,
	   IF(ENT_YN = 'Y', '퇴사', '재직') AS '재직 여부',
	   IF(IFNULL(MANAGER_ID,0) = 0, '관리자', '사원') AS '관리자 여부'
	   -- MANAGER_ID가 NULL일 경우 0을 돌려주는데, 그 값이 0이면 관리자 아니면 사원이다.
FROM EMPLOYEE;


SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE IF(ENT_YN = 'Y');
-- 에러 발생.
	  
-- CASE 함수를 이용해 실습 6 풀이
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_CODE 부서코드, JOB_CODE 직급코드,
	   CASE 
	   	WHEN(ENT_YN = 'Y') THEN '퇴사'
	   	WHEN(ENT_YN = 'N') THEN '재직'
	   END '재직 여부',
	   CASE
	   	WHEN (MANAGER_ID IS NULL) THEN '관리자'
	   	-- MANAGER_ID 가 NULL 값을 가지면 관리자
	   	-- WHEN (MANAGER_ID IS NOT NULL) THEN '사원'
	   	ELSE '사원'
	   END '관리자 여부'
FROM EMPLOYEE;

/* 실습 7
 * 입사한 달이 홀수 달인
 * 직원의 사번, 사원명, 입사일 정보를 조회한다.
 * 단, SUBSTR 함수와 HIRE_DATE를 활용한다.
 */

SELECT EMP_ID 사번, EMP_NAME 사원명, HIRE_DATE 입사일
FROM EMPLOYEE
WHERE MOD(SUBSTR(HIRE_DATE, 7, 1),2) = 1;
-- SUBSTR로 월 부분만 잘라내, 그 부분을 MOD 통해 나머지를 확인한다.
-- 2로 나눈 나머지가 1이면 홀수이다.
-- WHERE 절을 만족하는 ROW들만 조회한다.






