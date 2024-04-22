create or replace view aggJoin4772173433569853974 as (
with aggView2004530259341041385 as (select id as v21 from info_type as it1 where info= 'budget')
select movie_id as v29, info as v22 from movie_info as mi, aggView2004530259341041385 where mi.info_type_id=aggView2004530259341041385.v21);
create or replace view aggView7210619005692469321 as select v29, v22 from aggJoin4772173433569853974 group by v29,v22;
create or replace view aggJoin5990236855415095724 as (
with aggView8176254836524354593 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView8176254836524354593 where mc.company_id=aggView8176254836524354593.v1);
create or replace view aggJoin4517304540720845719 as (
with aggView981712073502479351 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin5990236855415095724 join aggView981712073502479351 using(v8));
create or replace view aggJoin6554724827316346119 as (
with aggView2802853382486149781 as (select v29 from aggJoin4517304540720845719 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView2802853382486149781 where t.id=aggView2802853382486149781.v29 and production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%')));
create or replace view aggJoin177152090221845254 as (
with aggView6471642202897360228 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select movie_id as v29 from movie_info_idx as mi_idx, aggView6471642202897360228 where mi_idx.info_type_id=aggView6471642202897360228.v26);
create or replace view aggJoin5941476872034880403 as (
with aggView4460783044972864192 as (select v29 from aggJoin177152090221845254 group by v29)
select v29, v30, v33 from aggJoin6554724827316346119 join aggView4460783044972864192 using(v29));
create or replace view aggView2067382175674363292 as select v29, v30 from aggJoin5941476872034880403 group by v29,v30;
create or replace view aggJoin2578407312423661755 as (
with aggView2911816216192549711 as (select v29, MIN(v22) as v41 from aggView7210619005692469321 group by v29)
select v30, v41 from aggView2067382175674363292 join aggView2911816216192549711 using(v29));
select MIN(v41) as v41,MIN(v30) as v42 from aggJoin2578407312423661755;
