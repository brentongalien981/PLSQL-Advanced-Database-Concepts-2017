-- Hands-On Assignments Part 1

-- Assignment 2-1
/*
DECLARE
  lv_test_date DATE := '10-DEC-2012';
  lv_test_num CONSTANT NUMBER(3) := 10;
  lv_test_txt VARCHAR2(10);
BEGIN
  lv_test_txt := 'Allen';
  
  DBMS_OUTPUT.PUT_LINE(lv_test_date);
  DBMS_OUTPUT.PUT_LINE(lv_test_num);
  DBMS_OUTPUT.PUT_LINE(lv_test_txt);
  DBMS_OUTPUT.PUT_LINE('lhsdlfjsdf' || 'xxxx' || '  heey Katy ' || lv_test_date);
END;
*/





-- Assignment 2-2
DECLARE
  lv_test_date DATE := '10-DEC-2012';
  lv_test_num CONSTANT NUMBER(3) := 10;
  lv_test_txt VARCHAR2(10);
BEGIN
  lv_test_txt := 'Allen';
  
  DBMS_OUTPUT.PUT_LINE(lv_test_date);
  DBMS_OUTPUT.PUT_LINE(lv_test_num);
  DBMS_OUTPUT.PUT_LINE(lv_test_txt);
  DBMS_OUTPUT.PUT_LINE('lhsdlfjsdf' || 'xxxx' || '  heey Katy ' || lv_test_date);
END;