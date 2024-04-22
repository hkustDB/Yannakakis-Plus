create or replace view aggView3158965720141384636 as select name as v36, id as v35 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggView1030404513047009467 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView92339441680689644 as select name as v10, id as v9 from char_name as chn;
create or replace view aggJoin2701843105747783783 as (
with aggView1995364494793560855 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView1995364494793560855 where mc.company_id=aggView1995364494793560855.v32);
create or replace view aggJoin3172368884982697407 as (
with aggView8622699548226478580 as (select v18 from aggJoin2701843105747783783 group by v18)
select id as v18, title as v47 from title as t, aggView8622699548226478580 where t.id=aggView8622699548226478580.v18);
create or replace view aggView6361877972191573786 as select v18, v47 from aggJoin3172368884982697407 group by v18,v47;
create or replace view aggJoin7749065715289035047 as (
with aggView854326133978305308 as (select v35, MIN(v3) as v58 from aggView1030404513047009467 group by v35)
select v36, v35, v58 from aggView3158965720141384636 join aggView854326133978305308 using(v35));
create or replace view aggJoin4638425196125504967 as (
with aggView3317583928051569766 as (select v9, MIN(v10) as v59 from aggView92339441680689644 group by v9)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView3317583928051569766 where ci.person_role_id=aggView3317583928051569766.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin3828303997486329312 as (
with aggView338640442202095986 as (select v18, MIN(v47) as v61 from aggView6361877972191573786 group by v18)
select v35, v20, v22, v59 as v59, v61 from aggJoin4638425196125504967 join aggView338640442202095986 using(v18));
create or replace view aggJoin8325383450890247195 as (
with aggView2314450748487890671 as (select id as v22 from role_type as rt where role= 'actress')
select v35, v20, v59, v61 from aggJoin3828303997486329312 join aggView2314450748487890671 using(v22));
create or replace view aggJoin3647711009066939416 as (
with aggView4561978145865321210 as (select v35, MIN(v59) as v59, MIN(v61) as v61 from aggJoin8325383450890247195 group by v35,v61,v59)
select v36, v58 as v58, v59, v61 from aggJoin7749065715289035047 join aggView4561978145865321210 using(v35));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v36) as v60,MIN(v61) as v61 from aggJoin3647711009066939416;
