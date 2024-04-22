create or replace view aggJoin6541294486510141273 as (
with aggView2678642989261012987 as (select id as v9, name as v71 from char_name as chn)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView2678642989261012987 where ci.person_role_id=aggView2678642989261012987.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin3606066836887151139 as (
with aggView8503716723374425575 as (select id as v59, title as v73 from title as t where title LIKE 'Kung Fu Panda%' and production_year>2010)
select v48, v59, v20, v57, v71, v73 from aggJoin6541294486510141273 join aggView8503716723374425575 using(v59));
create or replace view aggJoin2092395997690574335 as (
with aggView6803986444593222301 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v59, v20, v71, v73 from aggJoin3606066836887151139 join aggView6803986444593222301 using(v57));
create or replace view aggJoin7369944877933405677 as (
with aggView8234598732373911623 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView8234598732373911623 where mi.info_type_id=aggView8234598732373911623.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin8450630639241728319 as (
with aggView1582520530796005381 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select movie_id as v59 from movie_keyword as mk, aggView1582520530796005381 where mk.keyword_id=aggView1582520530796005381.v32);
create or replace view aggJoin5867122040715147096 as (
with aggView8464968668778522579 as (select person_id as v48 from aka_name as an group by person_id)
select id as v48, name as v49, gender as v52 from name as n, aggView8464968668778522579 where n.id=aggView8464968668778522579.v48 and name LIKE '%An%' and gender= 'f');
create or replace view aggJoin3818551861676680241 as (
with aggView6469508197631524792 as (select v48, MIN(v49) as v72 from aggJoin5867122040715147096 group by v48)
select v59, v20, v71 as v71, v73 as v73, v72 from aggJoin2092395997690574335 join aggView6469508197631524792 using(v48));
create or replace view aggJoin6530840632594933175 as (
with aggView5397969354863674407 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select movie_id as v59 from movie_companies as mc, aggView5397969354863674407 where mc.company_id=aggView5397969354863674407.v23);
create or replace view aggJoin5525722098054193667 as (
with aggView1648469724565838568 as (select v59 from aggJoin6530840632594933175 group by v59)
select v59, v20, v71 as v71, v73 as v73, v72 as v72 from aggJoin3818551861676680241 join aggView1648469724565838568 using(v59));
create or replace view aggJoin8017500841104187555 as (
with aggView3839549474768549911 as (select v59 from aggJoin7369944877933405677 group by v59)
select v59, v20, v71 as v71, v73 as v73, v72 as v72 from aggJoin5525722098054193667 join aggView3839549474768549911 using(v59));
create or replace view aggJoin2622738853271233203 as (
with aggView5121439131083509149 as (select v59, MIN(v71) as v71, MIN(v73) as v73, MIN(v72) as v72 from aggJoin8017500841104187555 group by v59,v72,v71,v73)
select v71, v73, v72 from aggJoin8450630639241728319 join aggView5121439131083509149 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin2622738853271233203;
