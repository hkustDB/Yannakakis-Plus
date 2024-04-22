create or replace view aggView8997960952197710667 as select id as v40, title as v41 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin7170065544280593707 as (
with aggView2364940258569909832 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView2364940258569909832 where mi.info_type_id=aggView2364940258569909832.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin7957235278621839301 as (
with aggView2770631079141966248 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView2770631079141966248 where mc.company_id=aggView2770631079141966248.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin5689252282279317005 as (
with aggView8986422468176799231 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin7957235278621839301 join aggView8986422468176799231 using(v20));
create or replace view aggJoin2475994764468281115 as (
with aggView1475522560501713412 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select movie_id as v40, keyword_id as v24 from movie_keyword as mk, aggView1475522560501713412 where mk.movie_id=aggView1475522560501713412.v40);
create or replace view aggJoin4097734763140866027 as (
with aggView307211020326778019 as (select v40 from aggJoin5689252282279317005 group by v40)
select v40, v35, v36 from aggJoin7170065544280593707 join aggView307211020326778019 using(v40));
create or replace view aggJoin2688492955391262263 as (
with aggView5402321438274089509 as (select id as v24 from keyword as k)
select v40 from aggJoin2475994764468281115 join aggView5402321438274089509 using(v24));
create or replace view aggJoin8004358119482197639 as (
with aggView7947686382965571354 as (select v40 from aggJoin2688492955391262263 group by v40)
select v40, v35, v36 from aggJoin4097734763140866027 join aggView7947686382965571354 using(v40));
create or replace view aggView464765501101677309 as select v40, v35 from aggJoin8004358119482197639 group by v40,v35;
create or replace view aggJoin149028356656771706 as (
with aggView4671481886442755773 as (select v40, MIN(v41) as v53 from aggView8997960952197710667 group by v40)
select v35, v53 from aggView464765501101677309 join aggView4671481886442755773 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin149028356656771706;
