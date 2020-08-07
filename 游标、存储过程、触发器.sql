--游标示例 用游标依次计算account的水费 
declare
	cursor cur_usenum is select * from ACCOUNT;
	v_account ACCOUNT%rowtype;
begin
	open cur_usenum;--打开游标
		loop
			fetch cur_usenum into v_account;--提取游标
			exit when cur_usenum%notfound;
			DBMS_OUTPUT.put_line(v_account.usenum);
		end loop;
	close cur_usenum;
end;
--带参数的游标
declare
	cursor cur_usenum(v_id number) is select * from ACCOUNT where id<v_id;
	v_account ACCOUNT%rowtype;
begin
		open cur_usenum(4);
			loop
				fetch cur_usenum into v_account;
				exit when cur_usenum%notfound;
				DBMS_OUTPUT.put_line(v_account.usenum);
			end loop;
		close cur_usenum;
end;


--for循环 调用游标
declare
	cursor cur_usenum(v_id number) is select * from account where id<v_id;
begin
	for v_account in cur_usenum(5)
		loop
			DBMS_OUTPUT.put_line(v_account.usenum);
		end loop;
end;

--存储函数
create or replace function fun_findaddress
	(v_id number)
return varchar2
is
	v_address varchar2(255);
begin
	select address into v_address from INFO where id=v_id;
	return v_address;
exception
	when NO_DATA_FOUND then
		DBMS_OUTPUT.put_line('未找到id为'||v_id||'的数据');
end;
--调用函数
select id,fun_findaddress(id) from account where id < 5;


create sequence seq_id start with 5 increment by 2;
--存储过程
create or replace procedure pro_add
	(v_name varchar2,v_add varchar2)
is
begin
	insert into info values(seq_id.nextval,v_name,v_add,sysdate);
	commit;
end;
--调用
call pro_add('何以笙','上海市静安区');

begin
	pro_add('刘亦菲','北京市大兴区');
end;


--带传出参数的存储过程
CREATE OR REPLACE procedure pro_add_out
	(v_id out number,v_name varchar2)
is
	v_add varchar2(255);
begin
	v_add:='浙江省杭州市';
	select seq_id.nextval into v_id from dual;
	insert into INFO values(v_id,v_name,v_add,sysdate);
	commit;
end;
--调用
declare 
	v_id number;
begin
	pro_add_out(v_id,'鱿鱼');
	dbms_output.put_line(v_id);
end;


--触发器,计算本月使用的水量=本月表数-上月表数
create or replace trigger tri_update
	before
	update of usenum
	on account
	for each row
declare
	
begin
	:new.usenum := :new.usenum-:old.usenum;
end;

--后置触发器
--创建日志表，记录修改了用户名前后的记录
create table LOG_NAME(
	id number(8),
	day date,
	oldName varchar2(50),
	newName varchar2(50));

create or replace trigger tri_name
	after
	update of name
	on info
	for each row
declare

begin
	insert into log_name values(:new.id,sysdate,:old.name,:new.name);
end;


















