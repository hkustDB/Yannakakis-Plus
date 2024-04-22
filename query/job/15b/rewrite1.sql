create or replace view aggView4095087727524483636 as select id as v40, title as v41 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin8230342578088317930 as (
with aggView3531011125249594132 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView3531011125249594132 where mi.info_type_id=aggView3531011125249594132.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin8809723762781880152 as (
with aggView3899601698477413170 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView3899601698477413170 where mc.company_id=aggView3899601698477413170.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin8913125345956064047 as (
with aggView7191374455966269446 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin8809723762781880152 join aggView7191374455966269446 using(v20));
create or replace view aggJoin2496210046579183836 as (
with aggView1805845703452389611 as (select v40 from aggJoin8913125345956064047 group by v40)
select movie_id as v40 from aka_title as aka_t, aggView1805845703452389611 where aka_t.movie_id=aggView1805845703452389611.v40);
create or replace view aggJoin2042404730547374042 as (
with aggView6014906920361108326 as (select v40 from aggJoin2496210046579183836 group by v40)
select movie_id as v40, keyword_id as v24 from movie_keyword as mk, aggView6014906920361108326 where mk.movie_id=aggView6014906920361108326.v40);
create or replace view aggJoin6800571407506464197 as (
with aggView5894150774792110336 as (select id as v24 from keyword as k)
select v40 from aggJoin2042404730547374042 join aggView5894150774792110336 using(v24));
create or replace view aggJoin7940558410868029613 as (
with aggView274929274819107979 as (select v40 from aggJoin6800571407506464197 group by v40)
select v40, v35, v36 from aggJoin8230342578088317930 join aggView274929274819107979 using(v40));
create or replace view aggView6842583876788126652 as select v40, v35 from aggJoin7940558410868029613 group by v40,v35;
create or replace view aggJoin5354032237425018999 as (
with aggView2452787676582504582 as (select v40, MIN(v35) as v52 from aggView6842583876788126652 group by v40)
select v41, v52 from aggView4095087727524483636 join aggView2452787676582504582 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin5354032237425018999;
