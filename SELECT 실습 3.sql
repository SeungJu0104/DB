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






