create or replace view aggJoin2185137213560249780 as (
with aggView4548562455993632477 as (select id as v9, name as v71 from char_name as chn)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView4548562455993632477 where ci.person_role_id=aggView4548562455993632477.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin8767201705069744127 as (
with aggView8618715530745787845 as (select person_id as v48 from aka_name as an group by person_id)
select id as v48, name as v49, gender as v52 from name as n, aggView8618715530745787845 where n.id=aggView8618715530745787845.v48 and name LIKE '%An%' and gender= 'f');
create or replace view aggJoin5565874900755055188 as (
with aggView993257961944299238 as (select v48, MIN(v49) as v72 from aggJoin8767201705069744127 group by v48)
select v59, v20, v57, v71 as v71, v72 from aggJoin2185137213560249780 join aggView993257961944299238 using(v48));
create or replace view aggJoin1420396142667438983 as (
with aggView2430374342083190992 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView2430374342083190992 where mi.info_type_id=aggView2430374342083190992.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin982738979429134339 as (
with aggView3890476671928065878 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v59 from movie_companies as mc, aggView3890476671928065878 where mc.company_id=aggView3890476671928065878.v23);
create or replace view aggJoin3485339401553998782 as (
with aggView6500748619823883272 as (select v59 from aggJoin982738979429134339 group by v59)
select v59, v20, v57, v71 as v71, v72 as v72 from aggJoin5565874900755055188 join aggView6500748619823883272 using(v59));
create or replace view aggJoin8447165478160015304 as (
with aggView5740065108507707329 as (select id as v57 from role_type as rt where role= 'actress')
select v59, v20, v71, v72 from aggJoin3485339401553998782 join aggView5740065108507707329 using(v57));
create or replace view aggJoin6880588930977753509 as (
with aggView4616900776172940119 as (select v59, MIN(v71) as v71, MIN(v72) as v72 from aggJoin8447165478160015304 group by v59,v72,v71)
select id as v59, title as v60, production_year as v63, v71, v72 from title as t, aggView4616900776172940119 where t.id=aggView4616900776172940119.v59 and production_year>2010);
create or replace view aggJoin2459979903029730876 as (
with aggView4256569899193598336 as (select v59, MIN(v71) as v71, MIN(v72) as v72, MIN(v60) as v73 from aggJoin6880588930977753509 group by v59,v72,v71)
select v59, v43, v71, v72, v73 from aggJoin1420396142667438983 join aggView4256569899193598336 using(v59));
create or replace view aggJoin498878058479638943 as (
with aggView3561867990477299101 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select movie_id as v59 from movie_keyword as mk, aggView3561867990477299101 where mk.keyword_id=aggView3561867990477299101.v32);
create or replace view aggJoin7952759512409444427 as (
with aggView7189480368597141240 as (select v59 from aggJoin498878058479638943 group by v59)
select v71 as v71, v72 as v72, v73 as v73 from aggJoin2459979903029730876 join aggView7189480368597141240 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin7952759512409444427;
