create or replace view aggView3597133067198205131 as select name as v3, person_id as v35 from aka_name as an group by name,person_id;
create or replace view aggJoin6463159608390902631 as (
with aggView8402686168146227135 as (select name as v36, id as v35 from name as n where gender= 'f')
select v35, v36 from aggView8402686168146227135 where v36 LIKE '%Angel%');
create or replace view aggView7379409654046331131 as select id as v9, name as v10 from char_name as chn;
create or replace view aggJoin2931175175745028519 as (
with aggView3893751639810852688 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView3893751639810852688 where mc.company_id=aggView3893751639810852688.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin1249569555961385643 as (
with aggView6211926878524634115 as (select v18 from aggJoin2931175175745028519 group by v18)
select id as v18, title as v47, production_year as v50 from title as t, aggView6211926878524634115 where t.id=aggView6211926878524634115.v18 and production_year>=2007 and production_year<=2010);
create or replace view aggView8876903356489030837 as select v47, v18 from aggJoin1249569555961385643 group by v47,v18;
create or replace view aggJoin1755820921023388138 as (
with aggView8264385993489348185 as (select v35, MIN(v36) as v60 from aggJoin6463159608390902631 group by v35)
select person_id as v35, movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60 from cast_info as ci, aggView8264385993489348185 where ci.person_id=aggView8264385993489348185.v35 and note= '(voice)');
create or replace view aggJoin5012007905222026207 as (
with aggView5259743788471976757 as (select v9, MIN(v10) as v59 from aggView7379409654046331131 group by v9)
select v35, v18, v20, v22, v60 as v60, v59 from aggJoin1755820921023388138 join aggView5259743788471976757 using(v9));
create or replace view aggJoin4783738965057115447 as (
with aggView2700048782067580076 as (select v18, MIN(v47) as v61 from aggView8876903356489030837 group by v18)
select v35, v20, v22, v60 as v60, v59 as v59, v61 from aggJoin5012007905222026207 join aggView2700048782067580076 using(v18));
create or replace view aggJoin2667293003556163002 as (
with aggView7589067990288113933 as (select id as v22 from role_type as rt where role= 'actress')
select v35, v20, v60, v59, v61 from aggJoin4783738965057115447 join aggView7589067990288113933 using(v22));
create or replace view aggJoin2102142243598221913 as (
with aggView8029330426596463273 as (select v35, MIN(v60) as v60, MIN(v59) as v59, MIN(v61) as v61 from aggJoin2667293003556163002 group by v35,v59,v60,v61)
select v3, v60, v59, v61 from aggView3597133067198205131 join aggView8029330426596463273 using(v35));
select MIN(v3) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin2102142243598221913;
