--变量声明与赋值
declare
	v_price number(10,2);--单价
	v_usenum number(10,2);--用了的吨数
	v_money number(10,2);--金额
	
begin
	v_price:=2.45;
	v_usenum:=17.65;
	v_money:=v_price*v_usenum;
	
	DBMS_OUTPUT.put_line('金额为'||v_money);

end;

--使用表中的数据计算刚刚的例子
declare
	v_price number(10,2);--单价
	v_usenum number(10,2);--用了的吨数
	v_money number(10,2);--金额
	
begin
	v_price:=2.45;
	--v_usenum:=17.65;
	select usenum into v_usenum from account where id=2;
	v_money:=v_price*v_usenum;
	
	DBMS_OUTPUT.put_line('金额为'||v_money);
end;

--异常处理
declare
	v_price number(10,2);--单价
	v_usenum number(10,2);--用了的吨数
	v_money number(10,2);--金额
	
begin
	v_price:=2.45;
	--v_usenum:=17.65;
	select usenum into v_usenum from account where id=200;
	v_money:=v_price*v_usenum;
	
	DBMS_OUTPUT.put_line('金额为'||v_money);
	
	EXCEPTION
		when no_data_found then
			DBMS_OUTPUT.put_line('没有找到数据');
end;

--if条件 阶梯计算水费，水费分为5，10，>10三档阶梯计费
declare 
	v_price1 number(10,2);
	v_price2 number(10,2);
	v_price3 number(10,2);
	
	v_account account%rowtype;
	v_usenum number(10,2);
	v_money number(10,2);
begin
	v_price1 := 2.45;
	v_price2 := 4.50;
	v_price3 := 8.50;
	select * into v_account from ACCOUNT where id=3;
	v_usenum := v_account.usenum;
	
	if v_usenum<=5 then
		v_money := v_usenum*v_price1;
	elsif v_usenum<=10 then
		v_money := 5*v_price1+(v_usenum-5)*v_price2;
	else
		v_money := 5*v_price1+5*v_price2+(v_usenum-10)*v_price3;
	end if;
		
		DBMS_OUTPUT.put_line(v_money);
end;


--无条件循环
declare
	v_num number;
begin 
	v_num := 1;
	loop
		DBMS_OUTPUT.put_line(v_num);
		v_num := v_num+1;
		if v_num>100 then
			exit;
		end if;
	end loop;
end;
--条件循环
declare
 v_num number;
begin
	v_num:=1;
	while v_num<100
		loop
			DBMS_OUTPUT.put_line(v_num);
			v_num:=v_num+1;
		end loop;
end;
--for循环
declare

begin
		for v_num in 1..100
		loop
			DBMS_OUTPUT.put_line(v_num);
		end loop;
end;

