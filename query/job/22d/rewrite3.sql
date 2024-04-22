create or replace view aggView7657922239224554585 as select name as v2, id as v1 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin5199230589850560762 as (
with aggView1277615855656169557 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView1277615855656169557 where mi.info_type_id=aggView1277615855656169557.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin4025770707959252651 as (
with aggView1648650248396305466 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView1648650248396305466 where mk.keyword_id=aggView1648650248396305466.v14);
create or replace view aggJoin7954361039791021055 as (
with aggView4850736738162423209 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView4850736738162423209 where mi_idx.info_type_id=aggView4850736738162423209.v12 and info<'8.5');
create or replace view aggView2951314510478363504 as select v32, v37 from aggJoin7954361039791021055 group by v32,v37;
create or replace view aggJoin7158104285178975195 as (
with aggView2007334839957679654 as (select v37 from aggJoin5199230589850560762 group by v37)
select v37 from aggJoin4025770707959252651 join aggView2007334839957679654 using(v37));
create or replace view aggJoin8532872056966028369 as (
with aggView9048865546349771256 as (select v37 from aggJoin7158104285178975195 group by v37)
select id as v37, title as v38, kind_id as v17, production_year as v41 from title as t, aggView9048865546349771256 where t.id=aggView9048865546349771256.v37 and production_year>2005);
create or replace view aggJoin8459446008153818505 as (
with aggView8509107324748974654 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select v37, v38, v41 from aggJoin8532872056966028369 join aggView8509107324748974654 using(v17));
create or replace view aggView7148051817767341631 as select v37, v38 from aggJoin8459446008153818505 group by v37,v38;
create or replace view aggJoin5189265671431751015 as (
with aggView9211145944180481018 as (select v1, MIN(v2) as v49 from aggView7657922239224554585 group by v1)
select movie_id as v37, company_type_id as v8, v49 from movie_companies as mc, aggView9211145944180481018 where mc.company_id=aggView9211145944180481018.v1);
create or replace view aggJoin8524029729063579430 as (
with aggView1706532884758918934 as (select v37, MIN(v38) as v51 from aggView7148051817767341631 group by v37)
select v32, v37, v51 from aggView2951314510478363504 join aggView1706532884758918934 using(v37));
create or replace view aggJoin2735222436965626194 as (
with aggView4303142926421727338 as (select id as v8 from company_type as ct)
select v37, v49 from aggJoin5189265671431751015 join aggView4303142926421727338 using(v8));
create or replace view aggJoin3758786510769228211 as (
with aggView4004978484068335848 as (select v37, MIN(v49) as v49 from aggJoin2735222436965626194 group by v37,v49)
select v32, v51 as v51, v49 from aggJoin8524029729063579430 join aggView4004978484068335848 using(v37));
select MIN(v49) as v49,MIN(v32) as v50,MIN(v51) as v51 from aggJoin3758786510769228211;
