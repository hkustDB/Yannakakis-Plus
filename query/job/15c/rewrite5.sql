create or replace view aggJoin8262743478328893420 as (
with aggView3381552919658638063 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView3381552919658638063 where mc.company_id=aggView3381552919658638063.v13);
create or replace view aggJoin5856831237627928666 as (
with aggView1096536931199787009 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select id as v40, title as v41, production_year as v44 from title as t, aggView1096536931199787009 where t.id=aggView1096536931199787009.v40 and production_year>1990);
create or replace view aggJoin9066040825767864033 as (
with aggView6335052306965672863 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView6335052306965672863 where mk.keyword_id=aggView6335052306965672863.v24);
create or replace view aggJoin8497348256493786780 as (
with aggView4935873498076134619 as (select id as v20 from company_type as ct)
select v40 from aggJoin8262743478328893420 join aggView4935873498076134619 using(v20));
create or replace view aggJoin9064672716621481950 as (
with aggView8108709395677997275 as (select v40 from aggJoin9066040825767864033 group by v40)
select v40 from aggJoin8497348256493786780 join aggView8108709395677997275 using(v40));
create or replace view aggJoin6749713860131892573 as (
with aggView4417208618689120842 as (select v40 from aggJoin9064672716621481950 group by v40)
select v40, v41, v44 from aggJoin5856831237627928666 join aggView4417208618689120842 using(v40));
create or replace view aggView4167043526093541742 as select v41, v40 from aggJoin6749713860131892573 group by v41,v40;
create or replace view aggJoin1516121609446714006 as (
with aggView3665101125056167106 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView3665101125056167106 where mi.info_type_id=aggView3665101125056167106.v22 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggView3154612628271582899 as select v40, v35 from aggJoin1516121609446714006 group by v40,v35;
create or replace view aggJoin6299450780588775180 as (
with aggView789294453661796114 as (select v40, MIN(v41) as v53 from aggView4167043526093541742 group by v40)
select v35, v53 from aggView3154612628271582899 join aggView789294453661796114 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin6299450780588775180;
