create or replace view aggView5705858908512700023 as select id as v53, title as v54 from title as t where production_year>2000;
create or replace view aggView5558607180923378089 as select name as v43, id as v42 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggJoin8792192485176023331 as (
with aggView1492543048086839753 as (select v53, MIN(v54) as v66 from aggView5705858908512700023 group by v53)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView1492543048086839753 where ci.movie_id=aggView1492543048086839753.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin7850299696919716742 as (
with aggView1953499578917388014 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v53, v9, v20, v66 from aggJoin8792192485176023331 join aggView1953499578917388014 using(v51));
create or replace view aggJoin1782138672205646825 as (
with aggView5670909051586726868 as (select person_id as v42 from aka_name as an group by person_id)
select v42, v53, v9, v20, v66 as v66 from aggJoin7850299696919716742 join aggView5670909051586726868 using(v42));
create or replace view aggJoin5917392089386202369 as (
with aggView184995054360286584 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView184995054360286584 where mi.info_type_id=aggView184995054360286584.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin5546042653977489756 as (
with aggView6201567802672226791 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView6201567802672226791 where mc.company_id=aggView6201567802672226791.v23);
create or replace view aggJoin7584712302832790511 as (
with aggView4678141069220180057 as (select v53 from aggJoin5917392089386202369 group by v53)
select v53 from aggJoin5546042653977489756 join aggView4678141069220180057 using(v53));
create or replace view aggJoin1261541901975477251 as (
with aggView457699709128864476 as (select id as v9 from char_name as chn)
select v42, v53, v20, v66 from aggJoin1782138672205646825 join aggView457699709128864476 using(v9));
create or replace view aggJoin2734779503741838848 as (
with aggView469397961115058399 as (select v53 from aggJoin7584712302832790511 group by v53)
select v42, v20, v66 as v66 from aggJoin1261541901975477251 join aggView469397961115058399 using(v53));
create or replace view aggJoin8310008108236564105 as (
with aggView7091643644527933915 as (select v42, MIN(v66) as v66 from aggJoin2734779503741838848 group by v42,v66)
select v43, v66 from aggView5558607180923378089 join aggView7091643644527933915 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin8310008108236564105;
