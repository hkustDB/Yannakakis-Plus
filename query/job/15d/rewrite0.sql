create or replace view aggJoin5385408480956391936 as (
with aggView4381561718489273955 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView4381561718489273955 where mc.company_id=aggView4381561718489273955.v13);
create or replace view aggJoin8586117569550988356 as (
with aggView5668602434054690924 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, note as v36 from movie_info as mi, aggView5668602434054690924 where mi.info_type_id=aggView5668602434054690924.v22 and note LIKE '%internet%');
create or replace view aggJoin6777044589539466553 as (
with aggView5057864771634621008 as (select v40 from aggJoin8586117569550988356 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView5057864771634621008 where t.id=aggView5057864771634621008.v40 and production_year>1990);
create or replace view aggJoin1856742627376443179 as (
with aggView790677237406092753 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView790677237406092753 where mk.keyword_id=aggView790677237406092753.v24);
create or replace view aggJoin1132839394098031623 as (
with aggView4158297253225514770 as (select v40 from aggJoin1856742627376443179 group by v40)
select v40, v41, v44 from aggJoin6777044589539466553 join aggView4158297253225514770 using(v40));
create or replace view aggView2506106889590270071 as select v40, v41 from aggJoin1132839394098031623 group by v40,v41;
create or replace view aggJoin6949751834959897153 as (
with aggView5946802466483743978 as (select id as v20 from company_type as ct)
select v40 from aggJoin5385408480956391936 join aggView5946802466483743978 using(v20));
create or replace view aggJoin5296391712184342418 as (
with aggView4592920502233244532 as (select v40 from aggJoin6949751834959897153 group by v40)
select movie_id as v40, title as v3 from aka_title as aka_t, aggView4592920502233244532 where aka_t.movie_id=aggView4592920502233244532.v40);
create or replace view aggView640655533993171288 as select v40, v3 from aggJoin5296391712184342418 group by v40,v3;
create or replace view aggJoin4586273541647073678 as (
with aggView8358927034983749290 as (select v40, MIN(v41) as v53 from aggView2506106889590270071 group by v40)
select v3, v53 from aggView640655533993171288 join aggView8358927034983749290 using(v40));
select MIN(v3) as v52,MIN(v53) as v53 from aggJoin4586273541647073678;
