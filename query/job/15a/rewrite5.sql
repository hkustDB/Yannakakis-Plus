create or replace view aggJoin3711409094730506294 as (
with aggView701117567219353544 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView701117567219353544 where mk.keyword_id=aggView701117567219353544.v24);
create or replace view aggJoin3320098411840615350 as (
with aggView361376774455545816 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView361376774455545816 where mc.company_id=aggView361376774455545816.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin4404837922429276380 as (
with aggView8280992109708162738 as (select v40 from aggJoin3711409094730506294 group by v40)
select movie_id as v40 from aka_title as aka_t, aggView8280992109708162738 where aka_t.movie_id=aggView8280992109708162738.v40);
create or replace view aggJoin8273729520099708420 as (
with aggView8924712941323416053 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin3320098411840615350 join aggView8924712941323416053 using(v20));
create or replace view aggJoin6862416595258032525 as (
with aggView6963841485551388135 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView6963841485551388135 where mi.info_type_id=aggView6963841485551388135.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggView4138369076911548911 as select v35, v40 from aggJoin6862416595258032525 group by v35,v40;
create or replace view aggJoin4294075062185912062 as (
with aggView1662834743930057573 as (select v40 from aggJoin4404837922429276380 group by v40)
select v40, v31 from aggJoin8273729520099708420 join aggView1662834743930057573 using(v40));
create or replace view aggJoin2497545392128732109 as (
with aggView5280210927296885807 as (select v40 from aggJoin4294075062185912062 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView5280210927296885807 where t.id=aggView5280210927296885807.v40 and production_year>2000);
create or replace view aggView6900661041008305360 as select v41, v40 from aggJoin2497545392128732109 group by v41,v40;
create or replace view aggJoin5146111769850467400 as (
with aggView3113041227187566832 as (select v40, MIN(v35) as v52 from aggView4138369076911548911 group by v40)
select v41, v52 from aggView6900661041008305360 join aggView3113041227187566832 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin5146111769850467400;
