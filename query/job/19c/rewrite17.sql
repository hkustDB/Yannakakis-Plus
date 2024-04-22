create or replace view aggView434396519286381055 as select id as v53, title as v54 from title as t where production_year>2000;
create or replace view aggView4686725603718382193 as select name as v43, id as v42 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggJoin6350447181144909763 as (
with aggView2206333750576815533 as (select v53, MIN(v54) as v66 from aggView434396519286381055 group by v53)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView2206333750576815533 where ci.movie_id=aggView2206333750576815533.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4993355263117012454 as (
with aggView3212453165670676792 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v53, v9, v20, v66 from aggJoin6350447181144909763 join aggView3212453165670676792 using(v51));
create or replace view aggJoin3811112176472106375 as (
with aggView6109613117030278462 as (select person_id as v42 from aka_name as an group by person_id)
select v42, v53, v9, v20, v66 as v66 from aggJoin4993355263117012454 join aggView6109613117030278462 using(v42));
create or replace view aggJoin5173665607955188242 as (
with aggView2424238305372512218 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView2424238305372512218 where mi.info_type_id=aggView2424238305372512218.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin41237609415898245 as (
with aggView7831051219510044702 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView7831051219510044702 where mc.company_id=aggView7831051219510044702.v23);
create or replace view aggJoin4755744381996731633 as (
with aggView9123999541553612266 as (select id as v9 from char_name as chn)
select v42, v53, v20, v66 from aggJoin3811112176472106375 join aggView9123999541553612266 using(v9));
create or replace view aggJoin3578675012755000597 as (
with aggView5752425042924822220 as (select v53 from aggJoin41237609415898245 group by v53)
select v53, v40 from aggJoin5173665607955188242 join aggView5752425042924822220 using(v53));
create or replace view aggJoin5792327080347054191 as (
with aggView8194401335772798359 as (select v53 from aggJoin3578675012755000597 group by v53)
select v42, v20, v66 as v66 from aggJoin4755744381996731633 join aggView8194401335772798359 using(v53));
create or replace view aggJoin3829599882522797338 as (
with aggView7773566452638154955 as (select v42, MIN(v66) as v66 from aggJoin5792327080347054191 group by v42,v66)
select v43, v66 from aggView4686725603718382193 join aggView7773566452638154955 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin3829599882522797338;
