create or replace view aggJoin8856648678958625903 as (
with aggView2460305792173743093 as (select id as v53, title as v66 from title as t where production_year>2000)
select movie_id as v53, info_type_id as v30, v66 from movie_info as mi, aggView2460305792173743093 where mi.movie_id=aggView2460305792173743093.v53);
create or replace view aggJoin5628944849001670881 as (
with aggView8976353627650684775 as (select id as v51 from role_type as rt where role= 'actress')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20 from cast_info as ci, aggView8976353627650684775 where ci.role_id=aggView8976353627650684775.v51 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin6430011965598101806 as (
with aggView6133815157029495184 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView6133815157029495184 where mc.company_id=aggView6133815157029495184.v23);
create or replace view aggJoin1478197617967294355 as (
with aggView8113149843803298736 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v66 from aggJoin8856648678958625903 join aggView8113149843803298736 using(v30));
create or replace view aggJoin1625965839200355449 as (
with aggView8795543826039568032 as (select id as v9 from char_name as chn)
select v42, v53, v20 from aggJoin5628944849001670881 join aggView8795543826039568032 using(v9));
create or replace view aggJoin6558237937468018290 as (
with aggView5047104506566630869 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView5047104506566630869 where n.id=aggView5047104506566630869.v42 and gender= 'f');
create or replace view aggJoin6737422573270256298 as (
with aggView6531331908199987360 as (select v42, MIN(v43) as v65 from aggJoin6558237937468018290 group by v42)
select v53, v20, v65 from aggJoin1625965839200355449 join aggView6531331908199987360 using(v42));
create or replace view aggJoin7712440144849824177 as (
with aggView2288431727529555116 as (select v53, MIN(v65) as v65 from aggJoin6737422573270256298 group by v53,v65)
select v53, v65 from aggJoin6430011965598101806 join aggView2288431727529555116 using(v53));
create or replace view aggJoin4962193223813541228 as (
with aggView7711988363495225426 as (select v53, MIN(v65) as v65 from aggJoin7712440144849824177 group by v53,v65)
select v66 as v66, v65 from aggJoin1478197617967294355 join aggView7711988363495225426 using(v53));
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin4962193223813541228;
