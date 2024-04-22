create or replace view aggJoin5536927786129767729 as (
with aggView1471398193646356115 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView1471398193646356115 where ci.person_role_id=aggView1471398193646356115.v9);
create or replace view aggJoin875461791649409208 as (
with aggView5818605045610090725 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView5818605045610090725 where t.kind_id=aggView5818605045610090725.v28 and production_year>2005);
create or replace view aggJoin8287505844645770089 as (
with aggView4632858470590757490 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select movie_id as v47 from movie_keyword as mk, aggView4632858470590757490 where mk.keyword_id=aggView4632858470590757490.v25);
create or replace view aggJoin6630577908865584758 as (
with aggView4273636332652750822 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView4273636332652750822 where mi_idx.info_type_id=aggView4273636332652750822.v23 and info>'8.0');
create or replace view aggJoin7818113204732575985 as (
with aggView8862733104616808738 as (select v47, MIN(v33) as v60 from aggJoin6630577908865584758 group by v47)
select movie_id as v47, subject_id as v5, status_id as v7, v60 from complete_cast as cc, aggView8862733104616808738 where cc.movie_id=aggView8862733104616808738.v47);
create or replace view aggJoin1508677378197377775 as (
with aggView6279187982900210001 as (select v47 from aggJoin8287505844645770089 group by v47)
select v47, v48, v51 from aggJoin875461791649409208 join aggView6279187982900210001 using(v47));
create or replace view aggJoin9186430554014199720 as (
with aggView7641687684359112414 as (select v47, MIN(v48) as v61 from aggJoin1508677378197377775 group by v47)
select v38, v47, v59 as v59, v61 from aggJoin5536927786129767729 join aggView7641687684359112414 using(v47));
create or replace view aggJoin7332162517975073839 as (
with aggView5520410330215895910 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47, v5, v60 from aggJoin7818113204732575985 join aggView5520410330215895910 using(v7));
create or replace view aggJoin1791571514706104279 as (
with aggView338614428175218697 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47, v60 from aggJoin7332162517975073839 join aggView338614428175218697 using(v5));
create or replace view aggJoin3143766026635897022 as (
with aggView5776284438005783235 as (select v47, MIN(v60) as v60 from aggJoin1791571514706104279 group by v47,v60)
select v38, v59 as v59, v61 as v61, v60 from aggJoin9186430554014199720 join aggView5776284438005783235 using(v47));
create or replace view aggJoin4220017090269175254 as (
with aggView7958660926979877559 as (select id as v38 from name as n)
select v59, v61, v60 from aggJoin3143766026635897022 join aggView7958660926979877559 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin4220017090269175254;
