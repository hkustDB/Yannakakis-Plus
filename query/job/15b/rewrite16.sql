create or replace view aggJoin1223617234003376477 as (
with aggView1518864028493785740 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select movie_id as v40, company_id as v13, company_type_id as v20, note as v31 from movie_companies as mc, aggView1518864028493785740 where mc.movie_id=aggView1518864028493785740.v40 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin6103759317895346180 as (
with aggView2024705754337639285 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView2024705754337639285 where mi.info_type_id=aggView2024705754337639285.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin4608305239921742973 as (
with aggView1873434520882425410 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select v40, v20, v31 from aggJoin1223617234003376477 join aggView1873434520882425410 using(v13));
create or replace view aggJoin7055867473173924028 as (
with aggView5154860559147362772 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin4608305239921742973 join aggView5154860559147362772 using(v20));
create or replace view aggJoin3792071867003093212 as (
with aggView2189440809301293624 as (select v40 from aggJoin7055867473173924028 group by v40)
select v40, v35, v36 from aggJoin6103759317895346180 join aggView2189440809301293624 using(v40));
create or replace view aggJoin2423215821864508759 as (
with aggView3104955648577648029 as (select v40, MIN(v35) as v52 from aggJoin3792071867003093212 group by v40)
select id as v40, title as v41, production_year as v44, v52 from title as t, aggView3104955648577648029 where t.id=aggView3104955648577648029.v40 and production_year<=2010 and production_year>=2005);
create or replace view aggJoin3611831130834493778 as (
with aggView5639882352067038563 as (select v40, MIN(v52) as v52, MIN(v41) as v53 from aggJoin2423215821864508759 group by v40,v52)
select keyword_id as v24, v52, v53 from movie_keyword as mk, aggView5639882352067038563 where mk.movie_id=aggView5639882352067038563.v40);
create or replace view aggJoin5766574734143353020 as (
with aggView3227236957707635587 as (select id as v24 from keyword as k)
select v52, v53 from aggJoin3611831130834493778 join aggView3227236957707635587 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin5766574734143353020;
